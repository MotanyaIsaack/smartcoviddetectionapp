import 'package:flutter/material.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/screens/onboarding_screens/OnBoardingComonView.dart';

void main() => runApp(new OnBoardingDoctor());

class OnBoardingDoctor extends StatefulWidget {
  @override
  _OnBoardingDoctorState createState() => _OnBoardingDoctorState();
}

class _OnBoardingDoctorState extends State<OnBoardingDoctor> {
  @override
  Widget build(BuildContext context) {
    return setLocalView(
      AppImage.onBoardImg1,
      AppTitle.onBoardTitle1,
      AppString.onBoard1Descript,
    );
  }
}
