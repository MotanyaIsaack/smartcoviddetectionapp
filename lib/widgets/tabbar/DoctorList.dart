import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/api.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/user_model.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/localization/app_translations_delegate.dart';
import 'package:health_care/localization/application.dart';
import 'package:health_care/models/doctors/doctors.dart';
import 'package:health_care/screens/user_screens/doctorprofilescreen.dart';
import 'package:loading_animations/loading_animations.dart';

void main() => runApp( DoctorListTabScreen());

class DoctorListTabScreen extends StatefulWidget {
  @override
  _DoctorListTabScreenState createState() => _DoctorListTabScreenState();
}

class _DoctorListTabScreenState extends State<DoctorListTabScreen> {
  bool _isLoading = false;
  bool _isSwitched = false;
  List<DoctorModel> _doctors;
  List<DoctorModel> doctors;


  Future<void> _fetchData() async {
    _isLoading = true;
    final apis = Network();
    doctors = await apis.getDoctors();
    setState(() {
      _doctors = doctors;
//      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _doctors == null
            ? Center(child: LoadingJumpingLine.square(backgroundColor: Colors.red,))
            :  Container(
            color: Colors.grey[100],
            child:  GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 3.8,
              children:  List<Widget>.generate(_doctors.length, (index) {
                return  InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: false)
                        .push(MaterialPageRoute(
                            builder: (context) => DoctorProfileScreen(
                                  doctorInfo: _doctors[index],
                                )));
                  },
                  child: setWidgetsForList(
                      _doctors[index].image,
                      _doctors[index].full_name,
                      _doctors[index].specialization,
                      _doctors[index].hospital_name,
                      null,
                      false),
                );
              }),
            )),
        appBar:  AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(
              AppTranslations.of(context).text(AppTitle.drawerDoctors),
              Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          actions: setCommonCartNitificationView(context),
        ),
        drawer: Drawer(),
      );


  }


}
