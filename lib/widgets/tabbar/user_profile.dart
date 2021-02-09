import 'package:flutter/material.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/localization/application.dart';
import 'package:health_care/main.dart';
import 'package:health_care/screens/user_screens/DoctorList.dart';
import 'package:health_care/widgets/drawer.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List profileList = [];

  final List<String> languagesList = application.supportedLanguages;
  final List<String> languageCodesList = application.supportedLanguagesCodes;

  _setUserProfiel() {
    return Container(
      height: 180,
      // color: Colors.red,
      child: Column(
        children: <Widget>[
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: NetworkImage('https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg'))),
          ),
          SizedBox(
            height: 15,
          ),
          setCommonText(
              PersonalInfo.name, Colors.black, 18.0, FontWeight.w500, 1),
          setCommonText(
              PersonalInfo.email, Colors.grey, 17.0, FontWeight.w400, 1)
        ],
      ),
    );
  }

  _setCommonViewForGoal() {
    return Container(
      height: MediaQuery.of(context).size.width / 1.5,
      padding: EdgeInsets.all(15),
      child: Material(
        color: Colors.white,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: _setCommonViewForDescription(
                                AppTitle.indicatorGoal, '100'),
                          ),
                        ),
                        Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            child: _setCommonViewForDescription(
                                AppTitle.indicatorGoal, "100"),
                          ),
                        ),
                        Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            child: _setCommonViewForDescription(
                                AppTitle.indicatorGoal, "100"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child:  Container(
                            child: _setCommonViewForDescription(
                                AppTitle.indicatorGoal, "100"),
                          ),
                        ),
                         Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                         Expanded(
                          child:  Container(
                            child: _setCommonViewForDescription(
                                AppTitle.indicatorGoal, "100"),
                          ),
                        ),
                         Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                         Expanded(
                          child:  Container(
                            child: _setCommonViewForDescription(
                                AppTitle.indicatorGoal, "100"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _setCommonViewForDescription(String title, String bpm) {
    return  Container(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            child: setCommonText(
                title, AppColor.themeColor, 18.0, FontWeight.w700, 1),
          ),
          SizedBox(height: 3),
           Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              setCommonText(bpm, Colors.black, 18.0, FontWeight.w500, 1),
              SizedBox(
                width: 3,
              ),
              setCommonText("bpm", Colors.grey, 16.0, FontWeight.w600, 1),
            ],
          )
        ],
      ),
    );
  }

  _setBottomView() {
    return  Container(
      height: profileList.length * 80.0,
      color: Colors.grey[200],
      padding:  EdgeInsets.all(15),
      child:  GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 5.5,
        physics: NeverScrollableScrollPhysics(),
        children: List<Widget>.generate(profileList.length, (index) {
          return  Container(
            height: 70,
            padding:  EdgeInsets.only(top: 5, bottom: 5),
            child:  InkWell(
              onTap: () {
                if (index == 0) {
//                Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>GoalSettingsScreen()));
                } else if (index == 1) {
                  Navigator.of(context, rootNavigator: false).push(
                      MaterialPageRoute(builder: (context) => DoctorList()));
                } else if (index == 2) {
//                  Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>AddWeightScreen()));
                } else {
                  SharedManager.shared.currentIndex = 0;
                  Navigator.of(context, rootNavigator: false)
                      .pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          ModalRoute.withName('/MyHomePage'));
                  // Navigator.of(context,rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()),ModalRoute.withName('/login'));
                }
              },
              child:  Material(
                elevation: 2.0,
                borderRadius:  BorderRadius.circular(5),
                child:  Padding(
                  padding:  EdgeInsets.only(left: 15, right: 15),
                  child:  Row(
                    children: <Widget>[
                      profileList[index]['icon'],
                      SizedBox(
                        width: 12,
                      ),
                       Container(
                        height: 30,
                        color: Colors.grey[300],
                        width: 2,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                       Expanded(
                          child: setCommonText(profileList[index]['title'],
                              Colors.grey, 16.0, FontWeight.w500, 1)),
                      SizedBox(
                        width: 12,
                      ),
                       Icon(Icons.arrow_forward_ios,
                          size: 18, color: AppColor.themeColor),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    this.profileList = [
      {
        "title": AppTitle.profileGoalSetting,
        "icon": Icon(
          Icons.gps_fixed,
          color: AppColor.themeColor,
          size: 18,
        )
      },
      {
        "title": AppTitle.profileDoctorFav,
        "icon": Icon(
          Icons.favorite,
          color: AppColor.themeColor,
          size: 18,
        )
      },
      {
        "title": AppTitle.profileWeight,
        "icon": Icon(
          Icons.widgets,
          color: AppColor.themeColor,
          size: 18,
        )
      },
//    {"title":AppTranslations.of(context).text(AppTitle.profileOrders),"icon":Icon(Icons.local_shipping,color: AppColor.themeColor,size: 18,)},
      {
        "title": AppTitle.drawerLogout,
        "icon": Icon(
          Icons.settings_power,
          color: AppColor.themeColor,
          size: 18,
        )
      },
    ];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(
              AppTitle.drawerProfile,
              Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          actions: setCommonCartNitificationView(context),
        ),
        drawer:DrawerWidget(),
        body: Container(
            color: Colors.grey[200],
            child:  ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _setUserProfiel(),
                _setCommonViewForGoal(),
                _setBottomView()
              ],
            )),

    );
  }
}
