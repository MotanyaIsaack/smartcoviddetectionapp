import 'package:flutter/material.dart';
import 'package:health_care/models/patient/patient.dart';
import 'package:health_care/models/user/users.dart';
import 'package:health_care/widgets/drawer.dart';
import 'package:provider/provider.dart';

import 'package:health_care/models/appointment/appointments.dart';
import 'package:health_care/models/chat/chats.dart';
import 'package:health_care/screens/doctors_screens/appointments_screen.dart';
import 'package:health_care/screens/doctors_screens/chats_screen.dart';
import 'package:health_care/widgets/patient_list.dart';
import 'package:health_care/widgets/search_widget.dart';
import 'package:health_care/models/patient/patients.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  static const routeName = '/doctorDashboard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String name;
  String email;
  String profile_image;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
//    var user = jsonDecode(localStorage.getString('user'));
    setState(() {
      name = localStorage.getString('first_name');
      print(name);
      email = localStorage.getString('email');
      profile_image = localStorage.getString('image');
    });
  }

  int _cIndex = 0;

  void incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
//          backgroundColor: Colors.white,
          drawer: DrawerWidget(),
          body: NestedScrollView(
            headerSliverBuilder: (ctx, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: RichText(
                    text: TextSpan(
                        text: 'Welcome, ',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                        children: <TextSpan>[
                          TextSpan(
                              text: name ?? ' ',
                              style: TextStyle(
                                  color: Colors.white))
                        ]),
                  ),
                  bottom: TabBar(
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(
                          child: Icon(
                        Icons.people,
                      )),
                      Tab(child: Icon(Icons.chat)),
                      Tab(child: Icon(Icons.timelapse)),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            profile_image ?? 'https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg'
                        ),
                      ),
                    )
                  ],
                  floating: true,
//                  backgroundColor: Colors.transparent,
                ),
              ];
            },
            body: TabBarView(children: [
              Column(
                children: [
                  SearchWidget(),
                  AppointmentsScreen(),
                ],
              ),
              ChangeNotifierProvider(
                create: (ctx) => Chats(),
                child: ChatsScreen(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => Chats(),
                child: ChatsScreen(),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
