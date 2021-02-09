import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
//import 'package:health_care/Screens/BlogDetails/BlogDetails.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'signaling.dart';
import 'package:flutter_webrtc/webrtc.dart';

class CallSample extends StatefulWidget {
  static String tag = 'call_sample';
  final String ip;
  CallSample({Key key, @required this.ip}) : super(key: key);

  @override
  _CallSampleState createState() => new _CallSampleState(serverIP: ip);
}

class _CallSampleState extends State<CallSample> {
  Signaling _signaling;
  var _selfId;
  var _toId;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  bool _inCalling = false;
  bool _isMessage = false;
  bool _isFromClient = false;
  bool _isRinging = false;
  bool _isMute = false;
  String callType = "";
  final String serverIP;
  List<PeerObject> peerList;
  Timer timer;
  List<MessageBloc> messageList = [];
  final _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  File image;
  String imageBase64;
  String typeStringMsg = "";
  String _toName = "";
  String callingName = "";

  _CallSampleState({Key key, @required this.serverIP});

  @override
  initState() {
    super.initState();
    initRenderers();
    _connect();
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  deactivate() {
    super.deactivate();
    if (_signaling != null) _signaling.close();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
  }

  void _connect() async {
    if (_signaling == null) {
      _signaling = new Signaling(serverIP)..connect();

      _signaling.onStateChange = (SignalingState state) {
        switch (state) {
          case SignalingState.CallStateNew:
            this.setState(() {
              _inCalling = true;
            });
            break;
          case SignalingState.CallStateBye:
            this.setState(() {
              _localRenderer.srcObject = null;
              _remoteRenderer.srcObject = null;
              _inCalling = false;
            });
            break;
          case SignalingState.CallStateInvite:
            print("=================>Invite State");
            break;
          case SignalingState.CallStateConnected:
            print("=================>Connected State");
            break;
          case SignalingState.CallStateRinging:
            print("=================>Ringing State");
            break;
          case SignalingState.ConnectionClosed:
            print("=================>Connection Closed State");
            break;
          case SignalingState.ConnectionError:
            print("=================>Error Connection State");
            break;
          case SignalingState.ConnectionOpen:
            print("=================>Open Connection State");
            break;
            break;
        }
      };

      _signaling.onDataChannelMessage = ((context, data) {
        print("Data message:------->$data");
      });

      _signaling.onMessageRequest = ((event) async {
        //  print(event);
        final type = event['type'];
        if (type == 'call') {
          if (event['call']['callToId'].toString() == this._selfId.toString()) {
            // calling screen
            //call type
            this.callType = event['call']['callType'].toString();
            this.callingName = event['call']['callFromName'].toString();
            if (Platform.isAndroid) {
              playRington();
            } else {
              this.timer = Timer.periodic(Duration(seconds: 3), (timer) {
                playRington();
              });
            }
            setState(() {
              this._isRinging = true;
              this._isFromClient = true;
            });
          }
        } else if (type == "acceptReject") {
          //acceptRejectFromId
          //acceptRejectType
          final status = event['acceptReject']['acceptRejectType'];
          final fromId = event['acceptReject']['acceptRejectFromId'];

          final typeCall = event['acceptReject']['callType'];

          if (fromId == this._toId) {
            if (status == "0") {
              //accept
              if (typeCall == "audio") {
                _invitePeer(context, 'audio', fromId, false);
              } else {
                _invitePeer(context, 'video', fromId, false);
              }

              setState(() {
                this._isRinging = false;
                this._isFromClient = false;
                stoppedRignTone();
                this.timer.cancel();
              });
            } else {
              setState(() {
                this._isRinging = false;
                this._isFromClient = false;
                stoppedRignTone();
                this.timer.cancel();
              });
            }
          } else {
            setState(() {
              stoppedRignTone();
              this.timer.cancel();
            });
          }
        } else if (type == 'message') {
          final msgData = event['message'];
          final fromId = msgData['fromId'];
          final toID = msgData['toId'];

          if ((fromId == this._selfId) && (toID == this._toId) ||
              (fromId == this._toId) && (toID == this._selfId)) {
            final message = MessageBloc();
            message.fromId = msgData['fromId'];
            message.toId = msgData['toId'];
            message.time = msgData['time'];
            message.message = msgData['message'];
            message.msgType = msgData['msgType'];
            message.imgStr = msgData['imgString'];

            setState(() {
              messageList.add(message);
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent + 200);
            });
          }
        } else {
          final msgData = event['requestMessage'];
          print(_selfId);
          print(msgData['toId']);
        }
      });

      _signaling.onPeersUpdate = ((event) {
        this.setState(() {
          _selfId = event['self'];
          final events = event['peers'];
          peerList = [];
          if (SharedManager.shared.isDoctor) {
            //Patient List
            for (var i = 0; i < events.length; i++) {
              if (events[i]['isDoctor'] == '0') {
                //  _peers.add(events[i]);
                var peer = PeerObject();
                var event = events[i];
                peer.peerID = event['id'];
                peer.peerName = event['name'];
                peer.peerNumber = event['typeUser'];
                peer.peerRole = event['role'];
                peer.peerSpecility = event['role'];
                peer.isOpenMessageSheet = false;
                peer.messageCount = 0;

                this.peerList.add(peer);
              }
            }
          } else {
            //Doctor List
            for (var i = 0; i < events.length; i++) {
              if (events[i]['isDoctor'] == '1') {
                //  _peers.add(events[i]);
                var peer = PeerObject();
                var event = events[i];
                peer.peerID = event['id'];
                peer.peerName = event['name'];
                peer.peerNumber = event['typeUser'];
                peer.peerRole = event['role'];
                peer.peerSpecility = event['role'];
                peer.isOpenMessageSheet = false;
                peer.messageCount = 0;

                this.peerList.add(peer);
              }
            }
          }
        });
      });

      _signaling.onLocalStream = ((stream) {
        _localRenderer.srcObject = stream;
      });

      _signaling.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
      });

      _signaling.onRemoveRemoteStream = ((stream) {
        _remoteRenderer.srcObject = null;
      });
    }
  }

  _invitePeer(context, mediaTye, peerId, usescreen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.invite(peerId, mediaTye, usescreen);
    }
  }

  _hangUp() {
    if (_signaling != null) {
      _signaling.bye();
    }
  }

  _switchCamera() {
    _signaling.switchCamera();
  }

  _muteMic() {
    if (_isMute) {
      _signaling.muteAudio(false);
      _isMute = false;
    } else {
      _signaling.muteAudio(true);
      _isMute = true;
    }
  }

  _buildRow(context, PeerObject peer) {
    // var self = (peer.peerID == _selfId);
    return new InkWell(
      onTap: () {},
      child: new Container(
          height: 150,
          padding: new EdgeInsets.only(left: 15, right: 15, top: 7),
          child: Material(
            elevation: 2.0,
            color: Colors.grey[200],
            child: new Padding(
              padding: new EdgeInsets.all(10),
              child: new Column(
                children: <Widget>[
                  new Expanded(
                      flex: 2,
                      child: new Container(
                        // color:Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      image: DecorationImage(
                                          image: AssetImage(SharedManager
                                                  .shared.isDoctor
                                              ? 'Assets/DoctorProfile/patient.png'
                                              : "Assets/DoctorProfile/doctor.png"))),
                                ),
                                SizedBox(width: 10),
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    setCommonText(
                                        SharedManager.shared.isDoctor
                                            ? "Pt." + peer.peerName
                                            : "Dr." + peer.peerName,
                                        Colors.black87,
                                        17.0,
                                        FontWeight.w500,
                                        1),
                                    SizedBox(height: 3),
                                    setCommonText(
                                        peer.peerRole,
                                        Colors.grey[600],
                                        15.0,
                                        FontWeight.w500,
                                        1),
                                    SizedBox(height: 3),
                                    setCommonText(
                                        peer.peerNumber,
                                        Colors.grey[400],
                                        14.0,
                                        FontWeight.w500,
                                        1),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            new Container(height: 1, color: Colors.grey[400])
                          ],
                        ),
                      )),
                  new Expanded(
                      child: new Container(
                    // color:Colors.green,
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.videocam),
                            onPressed: () {
                              //Video Call
                              //  _invitePeer(context,'video', peer.peerID, false);
                              //calling screen
                              // playRington();
                              // FlutterRingtonePlayer.playRingtone();
                              this._toId = peer.peerID;
                              _signaling.requestForCalling(
                                  _selfId,
                                  peer.peerID,
                                  SharedManager.shared.name,
                                  peer.peerName,
                                  'video');
                              setState(() {
                                this._isRinging = true;
                                this._isFromClient = false;
                                this.callingName = peer.peerName;
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.phone),
                            onPressed: () async {
                              //Phone Call
                              //  _invitePeer(context,'audio', peer.peerID, false);
                              //calling screen

                              this._toId = peer.peerID;
                              _signaling.requestForCalling(
                                  _selfId,
                                  peer.peerID,
                                  SharedManager.shared.name,
                                  peer.peerName,
                                  'audio');
                              setState(() {
                                this._isRinging = true;
                                this._isFromClient = false;
                                this.callingName = peer.peerName;
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.message),
                            onPressed: () async {
                              setState(() {
                                this._toName = peer.peerName;
                                this.messageList = [];
                                this._toId = peer.peerID;
                                this._isMessage = true;
                              });
                              // _signaling.sendDetailsOfExistingUser();
                              // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>MessageScreen(
                              // name: peer.peerName,
                              // role: peer.peerRole,
                              // id:peer.peerID,
                              // signaling: _signaling,
                              // selfId: _selfId
                              // )));
                            })
                      ],
                    ),
                  )),
                ],
              ),
            ),
          )),
    );
  }

  playRington() {
    FlutterRingtonePlayer.playRingtone();
  }

  stoppedRignTone() {
    setState(() {
      FlutterRingtonePlayer.stop();
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 250, maxWidth: 250);
    File imageFile = new File(image.path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    imageBase64 = base64.encode(imageBytes);
    print(imageBase64);
    setState(() {
      image = image;
    });
  }

  messageScreen() {
    return new Container(
        color: Colors.grey[300],
        child: Column(
          children: <Widget>[
            new Expanded(
              child: new ListView.builder(
                controller: _scrollController,
                itemCount:
                    (messageList.length == null) ? 0 : messageList.length,
                itemBuilder: (context, index) {
                  return (this._toId == messageList[index].fromId)
                      ? _setLeftBubble(
                          messageList[index].message,
                          messageList[index].time,
                          messageList[index].msgType,
                          messageList[index].imgStr)
                      : _setRightBubble(
                          messageList[index].message,
                          messageList[index].time,
                          messageList[index].msgType,
                          messageList[index].imgStr);
                },
              ),
            ),
            new Container(
              padding:
                  new EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 15),
              height: 90,
              color: Colors.white,
              child: new Row(
                children: <Widget>[
                  new Icon(
                    Icons.message,
                    color: AppColor.themeColor,
                    size: 22,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  new Expanded(
                    child: new Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: AppColor.themeColor),
                          borderRadius: BorderRadius.circular(5)),
                      padding: new EdgeInsets.only(left: 12, right: 12),
                      child: new TextFormField(
                        onChanged: (value) {
                          print('user is typing.......');
                        },
                        decoration: InputDecoration(
                            hintText: "Type Here...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: AppColor.themeColor, fontSize: 16)),
                        controller: _messageController,
                        style:
                            TextStyle(color: AppColor.themeColor, fontSize: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 22,
                    ),
                    color: AppColor.themeColor,
                    onPressed: () {
                      var now = new DateTime.now();
                      print('${now.hour}:${now.minute}');
                      final date =
                          '${now.day}/${now.month}/${now.year}  ${now.hour}:${now.minute}';
                      _signaling.sendMessage('$_selfId', '${this._toId}',
                          "$date", "${_messageController.text}", "", "0");
                      this._messageController.text = "";
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.image,
                      size: 22,
                    ),
                    color: AppColor.themeColor,
                    onPressed: () async {
                      var now = new DateTime.now();
                      print('${now.hour}:${now.minute}');
                      final date =
                          '${now.day}/${now.month}/${now.year}  ${now.hour}:${now.minute}';
                      await getImage();
                      _signaling.sendMessage(
                          '${this._selfId}',
                          '${this._toId}',
                          "$date",
                          "${_messageController.text}",
                          this.imageBase64,
                          "1");
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  callingScreen() {
    return new Container(
      color: Colors.white,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                setCommonText('Calling', Colors.grey, 18.0, FontWeight.w500, 1),
                SizedBox(
                  height: 5,
                ),
                setCommonText("${this.callingName}", Colors.black, 16.0,
                    FontWeight.w500, 1),
              ],
            ),
          ),
          new SizedBox(
            height: 20,
          ),
          new Container(
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: Center(
                child: new Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    new Container(
                      height: MediaQuery.of(context).size.width - 150,
                      width: MediaQuery.of(context).size.width - 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 1, color: Colors.grey[300])),
                    ),
                    new Container(
                      height: MediaQuery.of(context).size.width - 220,
                      width: MediaQuery.of(context).size.width - 220,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 1, color: Colors.grey[300])),
                    ),
                    new Container(
                      height: MediaQuery.of(context).size.width - 280,
                      width: MediaQuery.of(context).size.width - 280,
                      child: new Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.width - 280) / 2),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'Assets/DoctorProfile/doctor.png'))),
                          )),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20,
          ),
          new Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isFromClient
                    ? new Container(
                        height: 50,
                        width: 50,
                        child: new Material(
                          color: Colors.green,
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(25),
                          child: new IconButton(
                            icon: Icon(Icons.call, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                this._isRinging = false;
                                _signaling.requestForAcceptRejectCall(
                                    this._selfId,
                                    "",
                                    SharedManager.shared.name,
                                    "",
                                    "0",
                                    this.callType);
                              });
                            },
                          ),
                        ),
                      )
                    : new Container(
                        height: 50,
                        width: 50,
                        child: new Material(
                          color: Colors.white,
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(25),
                          child: new IconButton(
                            icon: Icon(Icons.volume_off),
                            onPressed: () {},
                          ),
                        ),
                      ),
                SizedBox(
                  width: 30,
                ),
                new Container(
                  height: 50,
                  width: 50,
                  child: new Material(
                    color: Colors.red,
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(25),
                    child: new IconButton(
                      icon: Icon(Icons.call_end, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          this._isRinging = false;
                          _signaling.requestForAcceptRejectCall(
                              this._selfId,
                              "",
                              SharedManager.shared.name,
                              "",
                              "1",
                              this.callType);
                          // _invitePeer(context,'video', _toId, false);
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: (!_isRinging)
            ? (!this._inCalling)
                ? new AppBar(
                    title: (!_isMessage)
                        ? SharedManager.shared.isDoctor
                            ? new Text('Patients List')
                            : new Text('Doctors List')
                        : new Text('${this._toName}'),
                    backgroundColor: AppColor.themeColor,
                    // actions: <Widget>[
                    //   (!this._isMessage)?this._isRinging?Text(""):
                    //   this._inCalling?Text(''):IconButton(icon:Icon(Icons.power_settings_new), onPressed:(){
                    //     _hangUp();
                    //     Navigator.of(context).pop(false);
                    //   }):
                    //   IconButton(
                    //     icon:Icon(Icons.close)
                    //     ,onPressed:(){
                    //       setState(() {
                    //         this._isMessage = false;
                    //       });
                    //     })
                    // ],
                  )
                : EmptyAppBar()
            : EmptyAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _inCalling
            ? new SizedBox(
                width: 200.0,
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FloatingActionButton(
                        child: const Icon(Icons.switch_camera),
                        onPressed: _switchCamera,
                      ),
                      FloatingActionButton(
                        onPressed: _hangUp,
                        tooltip: 'Hangup',
                        child: new Icon(Icons.call_end),
                        backgroundColor: Colors.pink,
                      ),
                      FloatingActionButton(
                        child: const Icon(Icons.mic_off),
                        onPressed: _muteMic,
                      )
                    ]))
            : null,
        body: (!this._isMessage)
            ? this._isRinging
                ? callingScreen()
                : _inCalling
                    ? OrientationBuilder(builder: (context, orientation) {
                        return new Container(
                          child: new Stack(children: <Widget>[
                            new Positioned(
                                left: 0.0,
                                right: 0.0,
                                top: 0.0,
                                bottom: 0.0,
                                child: new Container(
                                  margin: new EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: new RTCVideoView(_remoteRenderer),
                                  decoration:
                                      new BoxDecoration(color: Colors.black54),
                                )),
                            new Positioned(
                              left: 20.0,
                              top: 20.0,
                              child: new Container(
                                width: orientation == Orientation.portrait
                                    ? 90.0
                                    : 120.0,
                                height: orientation == Orientation.portrait
                                    ? 120.0
                                    : 90.0,
                                child: new RTCVideoView(_localRenderer),
                                decoration:
                                    new BoxDecoration(color: Colors.black54),
                              ),
                            ),
                            new Positioned(
                                right: 10,
                                top: 20,
                                child: setCommonText(this.callingName,
                                    Colors.red, 17.0, FontWeight.w500, 1))
                          ]),
                        );
                      })
                    : new ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0.0),
                        itemCount:
                            (this.peerList != null ? this.peerList.length : 0),
                        itemBuilder: (context, i) {
                          return _buildRow(context, this.peerList[i]);
                        })
            : messageScreen());
  }
}

_setLeftBubble(String message, String time, String type, String image) {
  return new Container(
    // height: 100,
    padding: new EdgeInsets.only(left: 15, right: 100, top: 15, bottom: 15),
    child: new Container(
        child: (type == "0")
            ? new Material(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: new Padding(
                  padding: new EdgeInsets.all(8),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[new Expanded(child: Text(message))],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[Text(time)],
                      ),
                    ],
                  ),
                ),
              )
            : new Container(
                height: 150,
                width: 100,
                // color: Colors.red,
                padding: new EdgeInsets.only(right: 30),
                child: convertStringToImage(image))),
  );
}

_setRightBubble(String message, String time, String type, String image) {
  return new Container(
      // height: 110,
      padding: new EdgeInsets.only(right: 15, left: 100, top: 15, bottom: 15),
      child: new Container(
        child: (type == "0")
            ? new Material(
                color: AppColor.themeColor,
                borderRadius: new BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                child: new Padding(
                  padding: new EdgeInsets.all(8),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Expanded(
                              child: Text(
                            message,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ))
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            time,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 12.0),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : new Container(
                height: 200,
                // color: Colors.red,
                padding: new EdgeInsets.only(left: 30),
                child: convertStringToImage(image)),
      ));
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

Image convertStringToImage(String imgStr) {
  print(imgStr);
  final _byteImage = Base64Decoder().convert(imgStr);
  Widget image = Image.memory(
    _byteImage,
  );
  return image;
}

class MessageBloc {
  String message;
  String time;
  String toId;
  String fromId;
  String imgStr;
  String msgType;

  init(String message, String time, String toId, String fromID, String imgStr,
      String msgType) {
    this.message = message;
    this.time = time;
    this.toId = toId;
    this.fromId = fromId;
    this.imgStr = imgStr;
    this.msgType = msgType;
  }
}

class PeerObject {
  String peerName;
  String peerRole;
  String peerNumber;
  String peerID;
  String peerSpecility;
  bool isOpenMessageSheet;
  double messageCount;

  init(String peerName, String peerRole, String peerNumber, String peerID,
      String peerSpecility, bool isOpenMessageSheet, double messageCount) {
    this.peerName = peerName;
    this.peerRole = peerRole;
    this.peerNumber = peerNumber;
    this.peerID = peerID;
    this.peerSpecility = peerSpecility;
    this.isOpenMessageSheet = isOpenMessageSheet;
    this.messageCount = messageCount;
  }
}
