import 'package:flutter/material.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/screens/onboarding_screens/OnBoardingComonView.dart';

void main() => runApp(new OnBoardingMedicine());

class OnBoardingMedicine extends StatefulWidget {
  @override
  _OnBoardingMedicineState createState() => _OnBoardingMedicineState();
}

class _OnBoardingMedicineState extends State<OnBoardingMedicine> {
  @override
  Widget build(BuildContext context) {
    return setLocalView(
      AppImage.onBoardImg2,
      AppTitle.onBoardTitle2,
      AppString.onBoard2Descript,
    );
  }
}
