import 'package:flutter/material.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/screens/authentication_screens/login_page.dart';
import 'package:health_care/screens/onboarding_screens//OnBoardingComonView.dart';

void main() => runApp(new OnBoardingAppointment());

class OnBoardingAppointment extends StatefulWidget {
  @override
  _OnBoardingAppointmentState createState() => _OnBoardingAppointmentState();
}

class _OnBoardingAppointmentState extends State<OnBoardingAppointment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: new EdgeInsets.all(20),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          setLocalView(
            AppImage.onBoardImg3,
            AppTitle.onBoardTitle3,
            AppString.onBoard3Descript,
          ),
          SizedBox(
            height: 120,
          ),
          new InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginPage.routeName, (route) => false);
            },
            child: new Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: new Material(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.circular(22.5),
                elevation: 5.0,
                child: new Center(
                  child: new Text(
                    AppTitle.getStarted,
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
