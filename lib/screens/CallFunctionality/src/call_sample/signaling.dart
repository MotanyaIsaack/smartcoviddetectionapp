import 'dart:convert';
import 'dart:async';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'random_string.dart';
import '../utils/device_info.dart'
    if (dart.library.js) '../utils/device_info_web.dart';
import '../utils/websocket.dart'
    if (dart.library.js) '../utils/websocket_web.dart';

enum SignalingState {
  CallStateNew,
  CallStateRinging,
  CallStateInvite,
  CallStateConnected,
  CallStateBye,
  ConnectionOpen,
  ConnectionClosed,
  ConnectionError,
}

/*
 * callbacks for Signaling API.
 */
typedef void SignalingStateCallback(SignalingState state);
typedef void StreamStateCallback(MediaStream stream);
typedef void OtherEventCallback(dynamic event);
typedef void DataChannelMessageCallback(
    RTCDataChannel dc, RTCDataChannelMessage data);
typedef void DataChannelCallback(RTCDataChannel dc);

class Signaling {
  String _selfId = randomNumeric(6);
  SimpleWebSocket _socket;
  var _sessionId;
  var _host;
  var _peerConnections = new Map<String, RTCPeerConnection>();
  var _dataChannels = new Map<String, RTCDataChannel>();
  var _remoteCandidates = [];

  MediaStream _localStream;
  List<MediaStream> _remoteStreams;
  SignalingStateCallback onStateChange;
  StreamStateCallback onLocalStream;
  StreamStateCallback onAddRemoteStream;
  StreamStateCallback onRemoveRemoteStream;
  OtherEventCallback onPeersUpdate;
  OtherEventCallback onMessageRequest;
  DataChannelMessageCallback onDataChannelMessage;
  DataChannelCallback onDataChannel;

  Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
      /*
       * turn server configuration example.
      {
        'url': 'turn:123.45.67.89:3478',
        'username': 'change_to_real_user',
        'credential': 'change_to_real_secret'
      },
       */
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  final Map<String, dynamic> _constraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': [],
  };

  final Map<String, dynamic> _dcConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': false,
      'OfferToReceiveVideo': false,
    },
    'optional': [],
  };

  Signaling(this._host);

  close() {
    if (_localStream != null) {
      _localStream.dispose();
      _localStream = null;
    }

    _peerConnections.forEach((key, pc) {
      pc.close();
    });
    if (_socket != null) _socket.close();
  }

  void switchCamera() {
    if (_localStream != null) {
      _localStream.getVideoTracks()[0].switchCamera();
    }
  }

  void muteAudio(bool status) {
    _peerConnections.forEach((key, pc) {
      if (status) {
        _localStream.getAudioTracks()[0].enabled = true;
      } else {
        _localStream.getAudioTracks()[0].enabled = false;
      }
    });
  }

  void invite(String peerid, String media, usescreen) {
    this._sessionId = this._selfId + '-' + peerid;

    if (this.onStateChange != null) {
      this.onStateChange(SignalingState.CallStateNew);
    }

    _createPeerConnection(peerid, media, usescreen).then((pc) {
      _peerConnections[peerid] = pc;
      if (media == 'data') {
        _createDataChannel(peerid, pc);
      }
      _createOffer(peerid, pc, media);
    });
  }

  void bye() {
    _send('bye', {
      'session_id': this._sessionId,
      'from': this._selfId,
    });
  }

  void onMessage(message) async {
    Map<String, dynamic> mapData = message;
    var data = mapData['data'];

    switch (mapData['type']) {
      case 'peers':
        {
          List<dynamic> peers = data;
          if (this.onPeersUpdate != null) {
            Map<String, dynamic> event = new Map<String, dynamic>();
            event['self'] = _selfId;
            event['peers'] = peers;
            this.onPeersUpdate(event);
          }
        }
        break;
      case 'offer':
        {
          var id = data['from'];
          var description = data['description'];
          var media = data['media'];
          var sessionId = data['session_id'];
          this._sessionId = sessionId;

          if (this.onStateChange != null) {
            this.onStateChange(SignalingState.CallStateNew);
          }

          var pc = await _createPeerConnection(id, media, false);
          _peerConnections[id] = pc;
          await pc.setRemoteDescription(new RTCSessionDescription(
              description['sdp'], description['type']));
          await _createAnswer(id, pc, media);
          if (this._remoteCandidates.length > 0) {
            _remoteCandidates.forEach((candidate) async {
              await pc.addCandidate(candidate);
            });
            _remoteCandidates.clear();
          }
        }
        break;
      case 'answer':
        {
          var id = data['from'];
          var description = data['description'];

          var pc = _peerConnections[id];
          if (pc != null) {
            await pc.setRemoteDescription(new RTCSessionDescription(
                description['sdp'], description['type']));
          }
        }
        break;
      case 'candidate':
        {
          var id = data['from'];
          var candidateMap = data['candidate'];
          var pc = _peerConnections[id];
          RTCIceCandidate candidate = new RTCIceCandidate(
              candidateMap['candidate'],
              candidateMap['sdpMid'],
              candidateMap['sdpMLineIndex']);
          if (pc != null) {
            await pc.addCandidate(candidate);
          } else {
            _remoteCandidates.add(candidate);
          }
        }
        break;
      case 'leave':
        {
          var id = data;
          var pc = _peerConnections.remove(id);
          _dataChannels.remove(id);

          if (_localStream != null) {
            _localStream.dispose();
            _localStream = null;
          }

          if (pc != null) {
            pc.close();
          }
          this._sessionId = null;
          if (this.onStateChange != null) {
            this.onStateChange(SignalingState.CallStateBye);
          }
        }
        break;
      case 'bye':
        {
          var to = data['to'];
          var sessionId = data['session_id'];
          print('bye: ' + sessionId);

          if (_localStream != null) {
            _localStream.dispose();
            _localStream = null;
          }

          var pc = _peerConnections[to];
          if (pc != null) {
            pc.close();
            _peerConnections.remove(to);
          }

          var dc = _dataChannels[to];
          if (dc != null) {
            dc.close();
            _dataChannels.remove(to);
          }

          this._sessionId = null;
          if (this.onStateChange != null) {
            this.onStateChange(SignalingState.CallStateBye);
          }
        }
        break;
      case 'keepalive':
        {
          print('keepalive response!');
        }
        break;
      case "requestMessage":
        {
          // print("Message Request Data:$onMessageRequest");
          Map<String, dynamic> event = new Map<String, dynamic>();
          event['self'] = _selfId;
          event['requestMessage'] = data;
          this.onMessageRequest(event);
        }
        break;
      case "message":
        {
          print("Message Request Data:$onMessageRequest");
          Map<String, dynamic> event = new Map<String, dynamic>();
          event['type'] = 'message';
          event['message'] = data;
          this.onMessageRequest(event);
        }
        break;
      case "acceptReject":
        {
          print("Message Request Data:$onMessageRequest");
          Map<String, dynamic> event = new Map<String, dynamic>();
          event['type'] = "acceptReject";
          event['acceptReject'] = data;
          this.onMessageRequest(event);
        }
        break;
      case "call":
        {
          print("Message Request Data:$onMessageRequest");
          Map<String, dynamic> event = new Map<String, dynamic>();
          event['type'] = 'call';
          event['call'] = data;
          this.onMessageRequest(event);
        }
        break;
      case "typing":
        {
          print("Message Request Data:$onMessageRequest");
          Map<String, dynamic> event = new Map<String, dynamic>();
          event['type'] = 'typing';
          event['typing'] = data;
          this.onMessageRequest(event);
        }
        break;
      default:
        break;
    }
  }

  void requestForAcceptRejectCall(
      String acceptRejectfrom,
      String acceptRejectfromTo,
      String acceptRejectfromName,
      String acceptRejectToName,
      String acceptRejectType,
      String callType) async {
    _send('acceptReject', {
      'acceptRejectFromId': acceptRejectfrom,
      'acceptRejectToId': acceptRejectfromTo,
      'acceptRejectFromname': acceptRejectfromName,
      'acceptRejectToName': acceptRejectToName,
      "acceptRejectType": acceptRejectType,
      "callType": callType,
      //'0 -> accept, 1-> reject'
    });
    //  sendDetailsOfExistingUser();
  }

  void requestForCalling(String callFrom, String callTo, String callFromName,
      String callToName, String callType) async {
    _send('call', {
      'callFromId': callFrom,
      'callToId': callTo,
      'callFromName': callFromName,
      'callToName': callToName,
      'callType': callType
    });
    //  sendDetailsOfExistingUser();
  }

  void requestForTyping(
      String typingFrom, String typingTo, String typingFromName) async {
    _send('typing', {
      'typingFromId': typingFrom,
      'typingToId': typingTo,
      'typingFromName': typingFromName
    });
    //  sendDetailsOfExistingUser();
  }

  void requestForChat(
      String fromId, String toId, String fromName, String toName) async {
    // print('Socket Connection Status:${_socket.toString()}');
    print('Socket Connection is open');
    _send('requestMessage', {
      'fromName': fromName,
      'toName': toName,
      'fromId': fromId,
      'toId': toId,
    });
    //  sendDetailsOfExistingUser();
  }

  void sendMessage(String fromId, String toId, String time, String message,
      String imgString, String type) async {
    _send('message', {
      'fromId': fromId,
      'toId': toId,
      'time': time,
      'message': message,
      'imgString': imgString,
      'msgType': type
    });
    // sendDetailsOfExistingUser();
  }

  void sendDetailsOfExistingUser() {
    _send('new', {
      'name': SharedManager.shared.name,
      "typeUser": SharedManager.shared.mobile,
      "isDoctor": SharedManager.shared.isDoctor ? "1" : "0",
      "role": SharedManager.shared.specility,
      'id': _selfId,
      'user_agent': DeviceInfo.userAgent
    });
  }

  void connect() async {
    var url = 'ws://$_host:4442';
    // var url = 'https://tevocom.ecosmob.net:3001';

    _socket = SimpleWebSocket(url);

    print('connect to $url');

    _socket.onOpen = () {
      print('onOpen');
      this?.onStateChange(SignalingState.ConnectionOpen);
      _send('new', {
        'name': SharedManager.shared.name,
        "typeUser": SharedManager.shared.mobile,
        "isDoctor": SharedManager.shared.isDoctor ? "1" : "0",
        "role": SharedManager.shared.specility,
        'id': _selfId,
        'user_agent': DeviceInfo.userAgent
      });
    };

    _socket.onMessage = (message) {
      print('Recivied data: ' + message);
      JsonDecoder decoder = new JsonDecoder();
      this.onMessage(decoder.convert(message));
    };

    _socket.onClose = (int code, String reason) {
      print('Closed by server [$code => $reason]!');
      if (this.onStateChange != null) {
        this.onStateChange(SignalingState.ConnectionClosed);
      }
    };

    await _socket.connect();
  }

  Future<MediaStream> createStream(media, userscreen) async {
    if (media == "video") {
      Map<String, dynamic> mediaConstraints = {
        'audio': true,
        'video': {
          'mandatory': {
            'minWidth':
                '640', // Provide your own width, height and frame rate here
            'minHeight': '480',
            'minFrameRate': '30',
          },
          'facingMode': 'user',
          'optional': [],
        }
      };
      MediaStream stream = userscreen
          ? await navigator.getDisplayMedia(mediaConstraints)
          : await navigator.getUserMedia(mediaConstraints);
      if (this.onLocalStream != null) {
        this.onLocalStream(stream);
      }
      return stream;
    } else {
      Map<String, dynamic> mediaConstraints = {'audio': true, 'video': false};
      MediaStream stream = userscreen
          ? await navigator.getDisplayMedia(mediaConstraints)
          : await navigator.getUserMedia(mediaConstraints);
      if (this.onLocalStream != null) {
        this.onLocalStream(stream);
      }
      return stream;
    }
  }

  _createPeerConnection(id, media, userscreen) async {
    if (media != 'data') _localStream = await createStream(media, userscreen);
    RTCPeerConnection pc = await createPeerConnection(_iceServers, _config);
    if (media != 'data') pc.addStream(_localStream);
    pc.onIceCandidate = (candidate) {
      _send('candidate', {
        'to': id,
        'candidate': {
          'sdpMLineIndex': candidate.sdpMlineIndex,
          'sdpMid': candidate.sdpMid,
          'candidate': candidate.candidate,
        },
        'session_id': this._sessionId,
      });
    };

    pc.onIceConnectionState = (state) {};

    pc.onAddStream = (stream) {
      if (this.onAddRemoteStream != null) this.onAddRemoteStream(stream);
      //_remoteStreams.add(stream);
    };

    pc.onRemoveStream = (stream) {
      if (this.onRemoveRemoteStream != null) this.onRemoveRemoteStream(stream);
      _remoteStreams.removeWhere((it) {
        return (it.id == stream.id);
      });
    };

    pc.onDataChannel = (channel) {
      _addDataChannel(id, channel);
    };

    return pc;
  }

  _addDataChannel(id, RTCDataChannel channel) {
    channel.onDataChannelState = (e) {};
    channel.onMessage = (RTCDataChannelMessage data) {
      if (this.onDataChannelMessage != null)
        this.onDataChannelMessage(channel, data);
    };
    _dataChannels[id] = channel;

    if (this.onDataChannel != null) this.onDataChannel(channel);
  }

  _createDataChannel(id, RTCPeerConnection pc, {label: 'fileTransfer'}) async {
    RTCDataChannelInit dataChannelDict = new RTCDataChannelInit();
    RTCDataChannel channel = await pc.createDataChannel(label, dataChannelDict);
    _addDataChannel(id, channel);
  }

  _createOffer(String id, RTCPeerConnection pc, String media) async {
    try {
      RTCSessionDescription s =
          await pc.createOffer(media == 'data' ? _dcConstraints : _constraints);
      pc.setLocalDescription(s);
      _send('offer', {
        'to': id,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': this._sessionId,
        'media': media,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _createAnswer(String id, RTCPeerConnection pc, media) async {
    try {
      RTCSessionDescription s = await pc
          .createAnswer(media == 'data' ? _dcConstraints : _constraints);
      pc.setLocalDescription(s);
      _send('answer', {
        'to': id,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': this._sessionId,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _send(event, data) {
    data['type'] = event;
    JsonEncoder encoder = new JsonEncoder();
    _socket.send(encoder.convert(data));
  }
}
