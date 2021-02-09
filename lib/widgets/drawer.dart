import 'package:flutter/material.dart';
import 'package:health_care/Helper/shared_manager.dart';
import 'package:health_care/Helper/constant.dart';
import 'package:health_care/screens/user_screens/DoctorList.dart';
import 'package:health_care/screens/user_screens/dashboard.dart';
import 'package:health_care/widgets/tabbar/tabbar.dart';
import 'package:health_care/main.dart';
import 'package:health_care/widgets/tabbar/user_profile.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
//  final String name;
//  final String email;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String name;
  String userEmail;
  String profileImage;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    var localStorage = await SharedPreferences.getInstance();
//    var user = jsonDecode(localStorage.getString('user'));
    setState(() {
      name = localStorage.getString('first_name');
      print(name);
      userEmail = localStorage.getString('email');

      profileImage = localStorage.getString('image');
    });
  }

  @override
  Widget build(BuildContext context) {
    _save(String token) async {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = token;
      prefs.setString(key, value);
    }

    return name == null
        ? Center(child: LoadingJumpingLine.square(backgroundColor: Colors.red,))
    : Drawer(
      child:  Container(
        color: Colors.white,
        child: ListView(
          padding:  EdgeInsets.all(0.0),
          children: <Widget>[
             UserAccountsDrawerHeader(
//                TODO: Replace eventually
              accountName: Text(name ?? ' ',
                  style:  TextStyle(fontSize: 18, color: Colors.black)),
              accountEmail: Text(userEmail ?? ' ',
                  style:  TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  )),
              currentAccountPicture:  GestureDetector(
                onTap: () {},
                child:  CircleAvatar(
                  backgroundImage:  NetworkImage(
                      profileImage ?? 'https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg'
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
             ListTile(
              title:  Text(AppTitle.drawerHome,
                  style:
                       TextStyle(fontSize: 18, color: AppColor.themeColor)),
              leading:  Icon(Icons.home, color: AppColor.themeColor),
              onTap: () {
                SharedManager.shared.currentIndex = 0;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
              },
            ),
             ListTile(
              title:  Text(AppTitle.drawerDoctors,
                  style:
                       TextStyle(fontSize: 18, color: AppColor.themeColor)),
              leading:
                   Icon(Icons.local_hospital, color: AppColor.themeColor),
              onTap: () {
                SharedManager.shared.currentIndex = 1;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DoctorList()));
              },
            ),
//             ListTile(
//              title:  Text(AppTitle.drawerProfile,
//                  style:
//                       TextStyle(fontSize: 18, color: AppColor.themeColor)),
//              leading:  Icon(Icons.person, color: AppColor.themeColor),
//              onTap: () {
//                SharedManager.shared.currentIndex = 4;
//                Navigator.of(context).pushAndRemoveUntil(
//                    MaterialPageRoute(builder: (context) => UserProfile()),
//                    ModalRoute.withName('/TabBar'));
//              },
//            ),
             ListTile(
              title:  Text(AppTitle.drawerLogout,
                  textDirection: SharedManager.shared.direction,
                  style:
                       TextStyle(fontSize: 18, color: AppColor.themeColor)),
              leading:  Icon(Icons.settings,
                  color: AppColor.themeColor),
              onTap: () {
                _save('0');
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
      ),
    );
  }
}
