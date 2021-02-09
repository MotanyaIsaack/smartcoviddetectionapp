import 'package:flutter/material.dart';

import 'package:health_care/Helper/constant.dart';
import 'package:health_care/Helper/shared_manager.dart';
import 'package:health_care/screens/user_screens/DoctorList.dart';

import 'package:health_care/screens/user_screens/dashboard.dart';
import 'package:health_care/widgets/tabbar/user_profile.dart';
import 'package:health_care/widgets/Tabbar/DoctorList.dart';

void main() => runApp(TabBarScreen());

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  bool isButtonClick = false;

  final List<Widget> listScreen = [
    DashboardScreen(),
    DoctorList(),
//    UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: SharedManager.shared.currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            activeIcon: Icon(
              Icons.home,
            ),
            title: Text(AppTitle.drawerHome),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text(AppTitle.drawerDoctors),
          ),
//           BottomNavigationBarItem(
//            icon: Icon(Icons.person),
//            title: Text(AppTitle.drawerProfile),
//          ),
        ]);
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//        floatingActionButton: FloatingActionButton(
//          child:  Icon(Icons.speaker_group,color:isButtonClick?Colors.blue:Colors.black,),
//          onPressed: (){
//            setState(() {
//              isButtonClick = true;
//              SharedManager.shared.currentIndex = 2;
//            });
//          },
//          backgroundColor: Colors.grey[300],
//        ),
  }

  void onTabTapped(int index) {
    setState(() {
      if (index != 2) {
        isButtonClick = false;
        SharedManager.shared.currentIndex = index;
      } else {
        SharedManager.shared.currentIndex = index;
      }
    });
  }

  //This is for localization

}
