
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_care/helper/api.dart';
import 'package:health_care/widgets/hospital_locate.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:health_care/models/hospitals/hospitals.dart';


import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(FindHospitalScreen());

class FindHospitalScreen extends StatefulWidget {

//  static const routeName = '/findhospitalscreen';

  @override
  _FindHospitalScreenState createState() => _FindHospitalScreenState();
}

class _FindHospitalScreenState extends State<FindHospitalScreen> {


  Position _currentPosition;
  double long = 0.0;
  double latt = 0.0;


List <Hospital> _list;
List <Hospital> googleHospitals;


  static LatLng _initialPosition;
  static  LatLng _lastMapPosition = _initialPosition;
  final Map<String, Marker> _markers = {};
  final Set<Marker> _markers2 = {};
//  final Map<String, Marker> _markers2 = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleHospitals = await Network().getGoogleHospitals();
    print(googleHospitals);
    setState(() {
      _markers.clear();

      for (final item in googleHospitals){
      final marker = Marker(
        markerId: MarkerId(item.name),
        position: LatLng(double.parse(item.lat),
            double.parse(item.long)),
        infoWindow: InfoWindow(
          title: item.name,
          snippet: item.sub_location,
        ),

      );
      _markers[item.name] = marker;
      _markers2.toString();
    }
    });

    }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();

  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
  _onAddMarkerButtonPressed() {
    setState(() {
      _markers2.add(
          Marker(
              markerId: MarkerId(_lastMapPosition.toString()),
              position: _lastMapPosition,
              infoWindow: InfoWindow(
                  title: "Pizza Parlour",
                  snippet: "This is a snippet",
                  onTap: (){
                  }
              ),
              onTap: (){
              },

              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));

    });
  }

  Widget mapButton(Function function, Icon icon, Color color) {
    return RawMaterialButton(
      onPressed: function,
      child: icon,
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(7.0),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff028090),
        primaryColorDark: Color(0xff3A1772),
        primaryColorLight: Color(0xffAFA2FF),
        accentColor: Color(0xffE3D7FF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Find Hospital'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),

        body: _initialPosition == null && googleHospitals== null ? Container(child: Center(child:Text('loading map..', style: TextStyle(color: Colors.grey[400]),),),) : Container(
        child : Stack(children: <Widget>[
          GoogleMap(

            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,

              zoom: 14.4746,
            ),
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            onCameraMove: _onCameraMove,
            markers: _markers.values.toSet(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
                margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                child: Column(
                  children: <Widget>[
                    mapButton(_onAddMarkerButtonPressed,
                        Icon(
                            Icons.add_location
                        ), Colors.blue),

                  ],
                )),
          )
        ]
        ),

      ),
      ),
    );
  }
  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void _getCurrentLocation() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
  }

}

