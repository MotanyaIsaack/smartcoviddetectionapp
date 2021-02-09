import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/screens/doctors_screens/dashboard.dart';
import 'package:health_care/screens/user_screens/CallingScreen.dart';
import 'package:health_care/screens/user_screens/PersonalInformations.dart';
import 'package:health_care/screens/user_screens/AppointmentList.dart';
import 'package:health_care/screens/user_screens/FindDoctorScreen.dart';
import 'package:health_care/screens/user_screens/Appointmentdetails.dart';
import 'package:health_care/screens/user_screens/bloodpressure.dart';
import 'package:health_care/screens/user_screens/bmi_calculate.dart';
import 'package:health_care/screens/user_screens/livewell.dart';
import 'package:health_care/screens/user_screens/eatwell.dart';
import 'package:health_care/screens/user_screens/finder_name.dart';
import 'package:health_care/screens/authentication_screens/login_page.dart';
import 'package:health_care/screens/authentication_screens//signup_page.dart';
import 'package:health_care/screens/user_screens/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/api.dart';
import 'models/user/users.dart';
import 'screens/onboarding_screens/OnBoardingAppointment.dart';
import 'screens/onboarding_screens/OnBoardingDoctors.dart';
import 'screens/onboarding_screens/OnBoardingMedicine.dart';
import 'package:health_care/screens/user_screens/DoctorList.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff028090),
          primaryColorDark: Color(0xff3A1772),
          primaryColorLight: Color(0xffAFA2FF),
          accentColor: Color(0xffE3D7FF),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          DashboardScreen.routeName: (ctx) => DashboardScreen(),
          LoginPage.routeName: (ctx) => LoginPage(),
          SignupPage.routeName: (ctx) => SignupPage(),
//          FindHospitalScreen.routeName: (ctx) => FindHospitalScreen(),
          FindDoctorScreen.routeName: (ctx) => FindDoctorScreen(),
          AppointMentList.routeName: (ctx) => AppointMentList(),
          FinderScreen.routeName: (ctx) => FinderScreen(),
          AppointmentDetails.routeName: (ctx) => AppointmentDetails(),
          CallingScreen.routeName: (ctx) => CallingScreen(),
          DoctorList.routeName: (ctx) => DoctorList(),
          PersonalInformations.routeName: (ctx) => PersonalInformations(),
          DashBoard.routeName: (ctx) => DashBoard(),
          LiveWellScreen.routeName: (ctx) => LiveWellScreen(),
          EatwellScreen.routeName: (ctx) => EatwellScreen(),
          BMI_calculate.routeName: (ctx) => BMI_calculate(),
          BloodPressureScreen.routeName: (ctx) => BloodPressureScreen(),

//          NotificationsScreen.routeName : (ctx) => NotificationScreen(),
        },
      ),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    var localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = MyHomePage();
    } else {
      child = LoginPage();
    }
    return Scaffold(
      body: child,
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    var selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    var zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Container(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String name;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    var localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        name = user['first_name'];
      });
    }
  }

  final _controller = PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black;

  final List<Widget> _pages = <Widget>[
    // OnBoardingDoctor(),
    // OnBoardingMedicine(),
    OnBoardingAppointment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconTheme(
        data: IconThemeData(color: _kArrowColor),
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              PageView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _controller,
                itemCount: _pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index % _pages.length];
                },
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: AppColor.themeColor.withOpacity(0.0),
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: DotsIndicator(
                      controller: _controller,
                      itemCount: _pages.length,
                      color: AppColor.themeColor,
                      onPageSelected: (int page) {
                        _controller.animateToPage(
                          page,
                          duration: _kDuration,
                          curve: _kCurve,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 30,),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: FlatButton(
              //     onPressed: (){
              //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
              //     },
              //     child: new Text("Skip",
              //     style: new TextStyle(
              //       color: AppColor.themeColor,
              //       fontWeight: FontWeight.w500,
              //       fontSize: 17
              //     ),
              //     ),
              //   ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      var localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushNamedAndRemoveUntil(
          context, LoginPage.routeName, (route) => false);
    }
  }

//This is for localization

}
