import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_care/helper/api.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/Helper/Constant.dart';
import 'package:health_care/models/doctors/doctors.dart';
import 'package:loading_animations/loading_animations.dart';



void main () => runApp( GoogleMapScreen());


class GoogleMapScreen extends StatefulWidget {

  final DoctorModel doctorInfo;

    GoogleMapScreen({Key key,this.doctorInfo}):super(key:key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  bool _isLoading = false;
  bool _isSwitched = false;
  List<DoctorModel> _doctors;
  List<DoctorModel> doctors;
  static double latitude;
  static double longitude;


  Future<void> _fetchData() async {
    _isLoading = true;
    final apis = Network();
    doctors = await apis.getDoctors();
    setState(() {
      _doctors = doctors;
//      _isLoading = false;
    });
  }


//List doctorList = [
//  {"Name":"Jems Anderson","address":"B Satyam Corporate,Near Shivranjni ahmedabad","role":"Endocrinologist","review":"4.0","latitude":23.024338,"longitude":72.5280573,"img":AppImage.doctorProfile},
//  {"Name":"Tony Stark","address":"ABC, Shindhubhavar Road, Ahmedabad 380060","role":"Neurologist","review":"4.3","latitude":23.0239873,"longitude":72.525906,"img":AppImage.doctorProfile},
//  {"Name":"Thor","address":"ABC, Shindhubhavar Road, Ahmedabad 380060","role":"Rheumatologist","review":"4.7","latitude":23.024683,"longitude":72.527290,"img":AppImage.doctorProfile},
//  {"Name":"Paul Walker","address":"ABC, Shindhubhavar Road, Ahmedabad 380060","role":"Psychiatrist","review":"4.9","latitude":23.037964,"longitude":72.526907,"img":AppImage.doctorProfile},
//];



  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
//    _addmarker(0);
    _fetchData();
    super.initState();

  }


  Set<Marker> markers = Set();



  

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-3.244, 72.5280573),
    zoom: 14.4746,
  );


  _addmarker(int index){
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    // ImageConfiguration imageConfig = ImageConfiguration(devicePixelRatio: mediaQueryData.devicePixelRatio,size: Size(20, 20));
   // var imgIcon = await BitmapDescriptor.fromAssetImage(imageConfig,this.doctorList[index]['img']);

        var marker  = _doctors[index];
            var mapMarker = Marker(
              markerId: MarkerId(marker.full_name,
              ),
              position: LatLng(double.parse(marker.latitude), double.parse(marker.longitude),),
              draggable: false,
              infoWindow: InfoWindow(
                title: marker.full_name,
                snippet:marker.hospital_name,
              ),
              // icon:imgIcon
            );
            this.markers.add(mapMarker);
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home:  Scaffold(
        body:  _doctors == null
            ? Center(child: LoadingJumpingLine.square(backgroundColor: Colors.red,))
            :Stack(
          children: <Widget>[
             Container(
                color: Colors.white,
                child: GoogleMap(
                mapType: MapType.normal,
                compassEnabled: true,
                myLocationButtonEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(double.parse(widget.doctorInfo.latitude), double.parse(widget.doctorInfo.longitude)),
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: this.markers,
                ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                padding:  EdgeInsets.only(top: 20,bottom: 20),
                child:  ListView.builder(
                  itemCount: _doctors.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return  InkWell(
                      onTap: (){
                        setState(() {
                          markers = Set();
                          _addmarker(index);
                        });
                      },
                        child:  Container(
                        height: 180,
                        width: 180,
                        padding:  EdgeInsets.all(8),
                        child:  Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          child:  Padding(
                            padding:  EdgeInsets.all(8),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                 Padding(
                                  padding:  EdgeInsets.all(1),
                                  child:    Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                       Container(
                                        height: 10,
                                        width: 10,
                                        child:  Material(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                       Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                           Icon(Icons.star_border,color:AppColor.themeColor,size:18),
                                          setCommonText("24", Colors.black, 15.0, FontWeight.w500, 2),
                                        ],
                                      ),
                                  ],
                                ),
                                ),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                     Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image:NetworkImage(_doctors[index].image),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    setCommonText(_doctors[index].full_name, Colors.black, 16.0, FontWeight.w500, 2),
                                    SizedBox(height: 3),
                                    setCommonText(_doctors[index].specialization, Colors.grey, 14.0, FontWeight.w500, 2)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
        appBar:  AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle('Locate Doctor',Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading:  IconButton(
            icon: Icon(Icons.arrow_back_ios,color:Colors.white),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
      ),


    );
  }
}