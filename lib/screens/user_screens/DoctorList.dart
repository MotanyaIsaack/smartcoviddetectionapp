import 'package:flutter/material.dart';
import 'package:health_care/helper/api.dart';
import 'package:health_care/helper/common_widgets//commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/user_model.dart';
import 'package:health_care/models/doctors/doctors.dart';
import 'package:health_care/screens/user_screens/doctorprofilescreen.dart';
import 'package:loading_animations/loading_animations.dart';

class DoctorList extends StatefulWidget {
  static const routeName = '/doctors_list';

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
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
      print(_doctors);
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
    return SafeArea(
      child: Scaffold(
        body: _doctors == null
          ? Center(child: LoadingJumpingLine.square(backgroundColor: Colors.red,))
        : Container(
            color: Colors.grey[100],
            child: ListView.builder(
              itemCount: _doctors.length,
              itemBuilder: (ctx, i) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DoctorProfileScreen(
                              doctorInfo: _doctors[i],
                            )));
                  },
                  child: setWidgetsForList(
                      _doctors[i].image,
                      _doctors[i].full_name,
                      _doctors[i].specialization,
                      _doctors[i].hospital_name,
                      null,
                      false),
                );
              },
            )),
        appBar: AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTitle.dashbFindDoctor, Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
