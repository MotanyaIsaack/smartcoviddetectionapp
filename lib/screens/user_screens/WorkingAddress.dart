import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/localization/app_translations.dart';

void main() => runApp( WorkingAddress());

class WorkingAddress extends StatefulWidget {
  @override
  _WorkingAddressState createState() => _WorkingAddressState();
}

class _WorkingAddressState extends State<WorkingAddress> {
  _setWorkingAddressView() {
    return  ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return  Container(
          padding:  EdgeInsets.all(10),
          // height: 150,
          child:  Material(
            elevation: 2,
            borderRadius:  BorderRadius.circular(8),
            child:  Padding(
              padding: EdgeInsets.all(8),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText('Children Hospital', Colors.black, 16.0,
                      FontWeight.w600, 1),
                  SizedBox(
                    height: 10,
                  ),
                  setCommonText(
                      '220 A-2 Avenue,Parsipanny near HDFC Bank road, York 09876564',
                      Colors.grey,
                      14.0,
                      FontWeight.w600,
                      3),
                  SizedBox(
                    height: 10,
                  ),
                   Row(
                    children: <Widget>[
                      Icon(
                        Icons.place,
                        color: AppColor.themeColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      setCommonText("0.8 km away", AppColor.themeColor, 14.0,
                          FontWeight.w500, 1)
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Container(
          color: Colors.white,
          child: _setWorkingAddressView(),
        ),
        appBar:  AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(
              AppTitle.workAddress,
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
      );
  }
}
