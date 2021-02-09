import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/localization/app_translations_delegate.dart';
import 'package:health_care/localization/application.dart';
import 'package:health_care/models/doctors/doctors.dart';
import 'package:health_care/screens/user_screens/BookAppointment.dart';
import 'package:health_care/screens/user_screens/CallingScreen.dart';
import 'package:health_care/screens/user_screens/MessageScreen.dart';
import 'package:health_care/screens/user_screens/PersonalInformations.dart';
import 'package:health_care/screens/user_screens/WorkingAddress.dart';
import 'package:health_care/screens/user_screens/googlefindDoctors.dart';

void main() => runApp(new DoctorProfileScreen());

class DoctorProfileScreen extends StatefulWidget {
  final DoctorModel doctorInfo;
  DoctorProfileScreen({Key key, this.doctorInfo}) : super(key: key);

  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  List driverInfoList = [];

  _setProfileImageDetailsView() {
    return Container(
      height: 400,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CallingScreen(doctorInfo: widget.doctorInfo,)));
                      },
                      child: Container(
                        child: Center(
                          child: Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          AppImage.doctorProfilePhone),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // border: Border.all(width:2,color:Colors.black),
                            image: DecorationImage(
                                image: NetworkImage(widget.doctorInfo.image),
                                fit: BoxFit.contain)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: false).push(
                            MaterialPageRoute(
                                builder: (context) => MessageScreen()));
                      },
                      child: Container(
                        child: Center(
                          child: Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          AppImage.doctorProfileMessage),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  setCommonText(widget.doctorInfo.full_name, Colors.black, 18.0,
                      FontWeight.w600, 1),
                  SizedBox(
                    height: 5,
                  ),
                  setCommonText(widget.doctorInfo.specialization, Colors.grey, 16.0,
                      FontWeight.w500, 1),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star_border,
                        color: AppColor.themeColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      setCommonText(widget.doctorInfo.hospital_name,
                          AppColor.themeColor, 16.0, FontWeight.w500, 1),
                      SizedBox(
                        width: 8,
                      ),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BookAppointment(doctorInfo: widget.doctorInfo,)));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          color: AppColor.themeColor,
                          borderRadius: BorderRadius.circular(25),
                          elevation: 5.0,
                          child: Center(
                            child: Text(
                              'Book Appointment',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setPersonalInformationsView() {
    return Container(
      height: 260,
      // color: Colors.red,
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              //GoogleMapScreen
              if (index == 0) {
                Navigator.of(context, rootNavigator: false).push(
                    MaterialPageRoute(
                        builder: (context) => PersonalInformations(doctorInfo: widget.doctorInfo,)));
              } else{
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GoogleMapScreen(
                      doctorInfo: widget.doctorInfo,)));
              }
            },
            child: Container(
              height: 80,
              padding: EdgeInsets.all(8),
              child: Material(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
                elevation: 3.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: <Widget>[
                      driverInfoList[index]['icons'],
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 2,
                        height: 17,
                        color: AppColor.themeColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: setCommonText(driverInfoList[index]["title"],
                              Colors.black54, 16.0, FontWeight.w600, 2),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.themeColor,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    this.driverInfoList = [
      {
        'title': 'Personal Info',
        'icons': Icon(
          Icons.person,
          color: AppColor.themeColor,
          size: 18,
        ),
      },
      {
        'title': 'Work Location',
        'icons': Icon(
          Icons.location_city,
          color: AppColor.themeColor,
          size: 18,
        )
      },
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              _setProfileImageDetailsView(),
              _setPersonalInformationsView()
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(
              'Doctors Profile',
              Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.place, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GoogleMapScreen(
                  doctorInfo: widget.doctorInfo,
                )));
              },
            )
          ],
        ),
      ),

    );
  }


}
