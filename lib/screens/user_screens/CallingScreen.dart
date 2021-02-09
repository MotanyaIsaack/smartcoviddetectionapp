import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/common_widgets//commonwidgets.dart';
import 'package:health_care/helper/constant.dart';

import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/models/doctors/doctors.dart';

class CallingScreen extends StatefulWidget {
  final DoctorModel doctorInfo;

  CallingScreen({Key key,this.doctorInfo}):super(key:key);
  static const routeName = '/callscreen';
  @override
  _CallingScreenState createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        color: Colors.white,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText(
                      AppTitle.calling,
                      Colors.grey,
                      18.0,
                      FontWeight.w500,
                      1),
                  SizedBox(
                    height: 5,
                  ),
                  setCommonText(
                      widget.doctorInfo.full_name, Colors.black, 16.0, FontWeight.w500, 1),
                ],
              ),
            ),
             SizedBox(
              height: 20,
            ),
             Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Center(
                  child:  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                       Container(
                        height: MediaQuery.of(context).size.width - 150,
                        width: MediaQuery.of(context).size.width - 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 1, color: Colors.grey[300])),
                      ),
                       Container(
                        height: MediaQuery.of(context).size.width - 220,
                        width: MediaQuery.of(context).size.width - 220,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 1, color: Colors.grey[300])),
                      ),
                       Container(
                        height: MediaQuery.of(context).size.width - 280,
                        width: MediaQuery.of(context).size.width - 280,
                        child:  Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(
                                (MediaQuery.of(context).size.width - 280) / 2),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(widget.doctorInfo.image))),
                            )),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
             Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Container(
                    height: 50,
                    width: 50,
                    child:  Material(
                      color: Colors.white,
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(25),
                      child:  IconButton(
                        icon: Icon(Icons.volume_off),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                   Container(
                    height: 50,
                    width: 50,
                    child:  Material(
                      color: Colors.red,
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(25),
                      child:  IconButton(
                        icon: Icon(Icons.call_end, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      appBar:  AppBar(
        centerTitle: true,
        // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
        title: setHeaderTitle(
            'Calling',
            AppColor.themeColor),
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.themeColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
