import 'package:flutter/material.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/screens/user_screens/bloodpressure.dart';
import 'package:health_care/screens/user_screens/bmi_calculate.dart';
import 'package:health_care/screens/user_screens/livewell.dart';
import 'package:health_care/screens/user_screens/eatwell.dart';
import 'package:health_care/screens/user_screens/finder_name.dart';
import 'DoctorList.dart';

class FindDoctorScreen extends StatefulWidget {
  static const routeName = '/finddoctorsscreen';
  @override
  _FindDoctorScreenState createState() => _FindDoctorScreenState();
}


class _FindDoctorScreenState extends State<FindDoctorScreen> {
  List driverInfoList = [];

  _setenquiryView() {
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
                Navigator.of(context, rootNavigator: false).pushNamed(LiveWellScreen.routeName);
              }
              else if(index == 1){
                Navigator.of(context).pushNamed(FinderScreen.routeName);
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
  Widget build(BuildContext context) {
    this.driverInfoList = [
      {
        'title': 'Health Chatbot',
        'icons': Icon(
          Icons.person,
          color: AppColor.themeColor,
          size: 18,
        ),
      },
      {
        'title': 'Health Finder',
        'icons': Icon(
          Icons.search,
          color: AppColor.themeColor,
          size: 18,
        )
      },
    ];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: _setenquiryView()
      ),
      appBar: AppBar(
        centerTitle: true,
        // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
        title: setHeaderTitle('Health Tips and First Aid', Colors.white),
        backgroundColor: AppColor.themeColor,
        elevation: 1.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
