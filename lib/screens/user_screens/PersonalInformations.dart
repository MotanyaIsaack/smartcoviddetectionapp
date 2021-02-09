import 'package:flutter/material.dart';
import 'package:health_care/helper/api.dart';
import 'package:health_care/helper/common_widgets//commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/models/doctors/doctors.dart';
import 'package:health_care/models/hospitals/hospitals.dart';
import 'package:loading_animations/loading_animations.dart';

class PersonalInformations extends StatefulWidget {
  final DoctorModel doctorInfo;

  PersonalInformations({Key key,this.doctorInfo}):super(key:key);
  static const routeName = '/personalInfo';
  @override
  _PersonalInformationsState createState() => _PersonalInformationsState();
}

class _PersonalInformationsState extends State<PersonalInformations> {
  bool _isLoading = false;
  List<Hospital> _hospital;
  List<Hospital> hospital;


  Future<void> _fetchData() async {
    _isLoading = true;
    final apis = Network();
    hospital = await apis.getGoogleHospitals();
    setState(() {
      _hospital = hospital;
      _getHospital(_hospital);
//      _isLoading = false;
    });
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }
  var details;
  Hospital _detail;
  void _getHospital(List hospital){
    _fetchData();
    print(widget.doctorInfo.hospital_name);
    var details =  hospital.firstWhere((detail) => detail.name.toString() == widget.doctorInfo.hospital_name.toUpperCase());
    print(details);

    setState(() {
      _detail = details;
//      _isLoading = false;
    });

  }
  String titleCase(String text) {
    if (text == null) throw ArgumentError("string: $text");

    if (text.isEmpty) return text;

    /// If you are careful you could use only this part of the code as shown in the second option.
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
  _setAboutWidgets() {
    return  Container(
      // height: 200,
      padding:  EdgeInsets.all(20),
      child:  Material(
        color: Colors.white,
        elevation: 3.0,
        borderRadius: BorderRadius.circular(8),
        child:  Padding(
          padding: EdgeInsets.all(10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setCommonText('Work Address',
                  Colors.black, 16.0, FontWeight.w600, 1),
              SizedBox(
                height: 5,
              ),
              setCommonText(
                  'Hospital: '+titleCase(_detail.name)
                      +'\n'+
                      'County: '+titleCase(_detail.province)
                      +'\n'+
                      'Sub_Location: '+titleCase(_detail.sub_location)
                      +'\n'+
                      'Division: ' +titleCase(_detail.division
                      +'\n'+
                      'Agency Level' +titleCase(_detail.agency)
                      ),
                  Colors.grey,
                  15.0,
                  FontWeight.w400,
                  10)
            ],
          ),
        ),
      ),
    );
  }

  _setPersonalInformationView() {
    return  Container(
      // color: Colors.red,
      padding:  EdgeInsets.all(20),
      child:  Column(
        children: <Widget>[
          _setCommonWidget('Phone Number',
              widget.doctorInfo.phone_number, ' '),
          SizedBox(
            height: 20,
          ),
          _setCommonWidget(
              'Email', widget.doctorInfo.email, ' '),
        ],
      ),
    );
  }

  _setCommonWidget(String title, String subStr1, String subStr2) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child:  Material(
        color: Colors.white,
        elevation: 3.0,
        borderRadius: BorderRadius.circular(8),
        child:  Padding(
          padding:  EdgeInsets.all(8),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setCommonText(title, Colors.black, 17.0, FontWeight.w600, 1),
              SizedBox(
                height: 8,
              ),
              setCommonText(subStr1, Colors.grey, 15.0, FontWeight.w500, 5),
              SizedBox(
                height: 5,
              ),
              setCommonText(subStr2, Colors.grey, 15.0, FontWeight.w500, 5),
            ],
          ),
        ),
      ),
    );
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _detail == null
          ? Center(child: LoadingJumpingLine.square(backgroundColor: Colors.red,))
          :Container(
        color: Colors.grey[100],
        child:  ListView(
          children: <Widget>[
            _setAboutWidgets(),
            _setPersonalInformationView(),
          ],
        ),
      ),
      appBar:  AppBar(
        centerTitle: true,
        // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
        title: setHeaderTitle(
            'Personal Information',
            Colors.white),
        backgroundColor: AppColor.themeColor,
        elevation: 1.0,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
