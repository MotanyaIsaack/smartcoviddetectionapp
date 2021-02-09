import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:health_care/Helper/constant.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/widgets/tabbar/tabbar.dart';
import 'package:health_care/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  static final SharedManager shared = SharedManager._internal();

  factory SharedManager() {
    return shared;
  }

  SharedManager._internal();

  // bool isRTL = true;
  bool isRTL = false;
  var direction = TextDirection.ltr;
  var count = 2;
  bool isOnboarding = false;
  int currentIndex = 0;
  var fontFamilyName = "Quicksand";
  bool isOpenMessageScreen = false;
  var ipAddress = "";

  String name;
  String mobile;
  String specility;
  bool isDoctor;

  var language = Locale("en", "");
  // var language =   Locale("es", "");
  // var language =   Locale("ar", "");
  // var language =   Locale("fr", "");

  setNavigation(BuildContext context, dynamic viewScreen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => viewScreen()));
  }

  storeBoolValueLocally(bool value, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  dynamic retriveStoredValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  String themeType = 'light';
  ThemeData getThemeType() {
    return ThemeData(
      brightness: _getBrightness(),
    );
  }

  Brightness _getBrightness() {
    if (themeType == "dark") {
      return Brightness.dark;
    } else {
      return Brightness.light;
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ValueNotifier<Locale> locale = ValueNotifier(Locale('en', ''));

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  setDrawer(BuildContext context, String email) {
    return Drawer(
        child: Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(email,
                textDirection: SharedManager.shared.direction,
                style: TextStyle(fontSize: 18, color: Colors.black)),
            accountEmail: Text(email,
                textDirection: SharedManager.shared.direction,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                )),
            currentAccountPicture: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundImage: AssetImage(AppImage.doctorProfile),
              ),
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
          ListTile(
            title: Text(AppTitle.drawerHome,
                textDirection: SharedManager.shared.direction,
                style: TextStyle(fontSize: 18, color: AppColor.themeColor)),
            leading: Icon(Icons.home, color: AppColor.themeColor),
            onTap: () {
              SharedManager.shared.currentIndex = 0;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => TabBarScreen()),
                  ModalRoute.withName('/TabBar'));
            },
          ),
          ListTile(
            title: Text(AppTitle.drawerDoctors,
                textDirection: SharedManager.shared.direction,
                style: TextStyle(fontSize: 18, color: AppColor.themeColor)),
            leading: Icon(Icons.local_hospital, color: AppColor.themeColor),
            onTap: () {
              SharedManager.shared.currentIndex = 1;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => TabBarScreen()),
                  ModalRoute.withName('/TabBar'));
            },
          ),
          ListTile(
            title: Text(AppTitle.drawerProfile,
                textDirection: SharedManager.shared.direction,
                style: TextStyle(fontSize: 18, color: AppColor.themeColor)),
            leading: Icon(Icons.person, color: AppColor.themeColor),
            onTap: () {
              SharedManager.shared.currentIndex = 4;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => TabBarScreen()),
                  ModalRoute.withName('/TabBar'));
            },
          ),
          ListTile(
            title: Text(AppTitle.drawerLogout,
                textDirection: SharedManager.shared.direction,
                style: TextStyle(fontSize: 18, color: AppColor.themeColor)),
            leading: Icon(Icons.exit_to_app, color: AppColor.themeColor),
            onTap: () {
              SharedManager.shared.currentIndex = 0;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  ModalRoute.withName('/MyHomePage'));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    ));
  }

  void showAlertDialog(String message, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Health Care'),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
