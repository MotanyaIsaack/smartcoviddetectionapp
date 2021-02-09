import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/localization/app_translations_delegate.dart';
import 'package:health_care/localization/application.dart';

class AppointmentDetails extends StatefulWidget {
  static const routeName = '/appointmentdetails';
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  _setDoctorDetails() {
    return  Container(
      padding:const EdgeInsets.all(15),
      // height: 320,
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            // color: Colors.white,
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: <Widget>[
                     Container(
                      height: 60,
                      width: 60,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(AppImage.doctorList),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child:  Container(
                        // color: Colors.red,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            setCommonText("JohnSmith", Colors.black, 18.0,
                                FontWeight.w600, 2),
                            SizedBox(
                              height: 3,
                            ),
                            setCommonText("Cardiologist", Colors.grey, 15.0,
                                FontWeight.w500, 2),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
           Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child:  Material(
              color: Colors.white,
              borderRadius:  BorderRadius.circular(8),
              elevation: 2.0,
              child:  Padding(
                  padding:  EdgeInsets.only(left: 15, right: 15),
                  child: _setDetailCommonView(
                      "Jan 10, 1994", Icons.calendar_today)),
            ),
          ),
          SizedBox(
            height: 30,
          ),
           Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child:  Material(
              color: Colors.white,
              borderRadius:  BorderRadius.circular(8),
              elevation: 2.0,
              child:  Padding(
                  padding:  EdgeInsets.only(left: 15, right: 15),
                  child:
                      _setDetailCommonView("10 AM - 12 PM", Icons.watch_later)),
            ),
          ),
          SizedBox(
            height: 35,
          ),
           Container(
            height: 300,
            child:  Material(
              color: Colors.white,
              borderRadius:  BorderRadius.circular(8),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   Expanded(
                    flex: 1,
                    child:  Align(
                      alignment: Alignment.centerLeft,
                      child:  Container(
                        padding:  EdgeInsets.only(left: 15, right: 15),
                        child: setCommonText(
                            AppTitle.orderService,
                            Colors.black,
                            20.0,
                            FontWeight.w700,
                            1),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                   Expanded(
                    flex: 2,
                    child:  Container(
                      // color: Colors.green,
                      padding:  EdgeInsets.only(left: 15, right: 15),
                      child: _setOrderServiceView(
                          AppTitle.overallExamition,
                          "29 mins",
                          "138"),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                   Expanded(
                    flex: 2,
                    child:  Container(
                      // color: Colors.green,
                      padding:  EdgeInsets.only(left: 15, right: 15),
                      child: _setOrderServiceView(
                          AppTitle.bloodTest,
                          "12 mins",
                          "38"),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                   Expanded(
                    flex: 1,
                    child:  Container(
                      padding:  EdgeInsets.only(left: 15, right: 15),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          setCommonText(
                              AppTitle.total,
                              Colors.black,
                              20.0,
                              FontWeight.w700,
                              1),
                          setCommonText(
                              "\$380", Colors.black, 20.0, FontWeight.w700, 1),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
           Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child:  Material(
              color: AppColor.themeColor,
              borderRadius: BorderRadius.circular(30),
              elevation: 5.0,
              child:  Center(
                child:  Text(
                  AppTitle.cancelAppointment,
                  style:  TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _setOrderServiceView(String title, String subTitle, String price) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            setCommonText(title, Colors.grey, 17.0, FontWeight.w700, 1),
            SizedBox(
              height: 3,
            ),
            setCommonText(subTitle, Colors.blue, 17.0, FontWeight.w600, 1),
          ],
        ),
        setCommonText("\$$price", Colors.black, 17.0, FontWeight.w700, 1),
      ],
    );
  }

  _setDetailCommonView(String title, dynamic icon) {
    return  Row(
      children: <Widget>[
         Icon(
          icon,
          size: 20,
        ),
        SizedBox(
          width: 10,
        ),
         Container(
          height: 20,
          width: 2,
          color: Colors.grey[400],
        ),
        SizedBox(
          width: 10,
        ),
        setCommonText(title, Colors.black, 17.0, FontWeight.w500, 1)
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
        body:  Container(
          color: Colors.grey[100],
          child:  ListView(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              _setDoctorDetails(),
            ],
          ),
        ),
        appBar:  AppBar(
          centerTitle: true,
          title: setHeaderTitle(
              'Appointment Details',
              Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading:  IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),

    );
  }

}
