

import 'dart:convert';
import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/api.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';

import 'package:health_care/models/doctors/doctors.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart'; //For creating the SMTP Server


void main() => runApp(new BookAppointment());

class BookAppointment extends StatefulWidget {
  final DoctorModel doctorInfo;


  // ignore: sort_constructors_first
  BookAppointment({Key key,this.doctorInfo}):super(key:key);
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment>
    with TickerProviderStateMixin {
  final Map<DateTime, List> _holidays = {
    DateTime(2019, 1, 1): ['New Year\'s Day'],
    DateTime(2019, 1, 6): ['Epiphany'],
    DateTime(2019, 2, 14): ['Valentine\'s Day'],
    DateTime(2019, 4, 21): ['Easter Sunday'],
    DateTime(2019, 4, 22): ['Easter Monday'],
  };
  String name;
  String email;
  var id;

  Map<DateTime, List> _events;
  List selectedEvents;
  var _selectedvalue;
  AnimationController _animationController;
  CalendarController _calendarController;
  var textController = TextEditingController();
  var phone = TextEditingController();
  var description = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();

    final _selectedDay = DateTime.now();

    _events = {};

    selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  void _loadUserData() async {
    var localStorage = await SharedPreferences.getInstance();
//    var user = jsonDecode(localStorage.getString('user'));
    setState(() {
      name = localStorage.getString('first_name');
      print(name);
      email = localStorage.getString('email');
      id = localStorage.getInt('id');
    });
  }

  sendemail(calendar, time) async {
    setState(() {
      _isLoading = true;
    });
    var username = 'isaackmotanya6@gmail.com';
    var password = 'aarmaeesloqqvmbc';

    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    var format_date = DateFormat.yMd().add_jms().format(calendar);
    final message = Message()
      ..from = Address(username)
      ..recipients.add(widget.doctorInfo.email) //recipent email
//      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
//      ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
      ..subject = 'Booked Appointment at ${
          DateFormat.yMEd().add_jms().format(DateTime.now())}' //subject of the email
      ..text = 'Hello.\n $name is requesting for an appoint with you.\n The details are listed here below \n Date: $format_date \n at : $time \n email : $email' ;//body of the email

    try {
      final sendReport = await send(message, smtpServer);
      _showDialog('Thanks', sendReport.toString());
      print('Message sent: ' + sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      _showDialog('Failed!', e.toString());
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }
  void _showDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text(title),
            content:  Text(message),
            actions: <Widget>[
              RaisedButton(
                child:  Text(
                  'Close',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  bool _isLoading = false;

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }
  var picked_day;
  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      selectedEvents = events;
      picked_day = day;
    });
  }
  bool isHTML = false;

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//  Future<void> send() async {
//    final email = Email(
//      body: _events.toString(),
//      subject:'',
//      recipients: [],
//      isHTML: isHTML,
//    );
//
//    String platformResponse;
//
//    try {
//      await FlutterEmailSender.send(email);
//      platformResponse = 'success';
//    } catch (error) {
//      platformResponse = error.toString();
//    }
//
//    if (!mounted) return;
//
//    _scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(platformResponse),
//    ));
//  }
  setCommonTextFieldForFillTheDetails(String hinttext, dynamic myIcon ,TextEditingController controllerText) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20),
      // color: Colors.teal,
      padding: EdgeInsets.only(
        left: 12,
        right: 25,
        bottom: 4,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColor.themeColor)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            myIcon,
            color: Colors.grey,
            size: 18,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              controller: controllerText,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  setCommonTextPay() {
    return Container(
      height: 50,
      // color: Colors.teal,
      padding: EdgeInsets.only(
        left: 12,
        right: 25,
        bottom: 4,
      ),
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(25),
//          border: Border.all(color: AppColor.themeColor)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.attach_money,
            color: Colors.grey,
            size: 18,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                  text: 'Pay, ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                        text: '1000',
                        style: TextStyle(
                            color: Colors.lightGreen))
                  ]),
            ),
          )
        ],
      ),
    );
  }

  _setProfileImageView() {
    return Container(
      height: MediaQuery.of(context).size.width / 2,
      // color: Colors.red,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(widget.doctorInfo.image),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          setCommonText(
              widget.doctorInfo.full_name, Colors.black, 17.0, FontWeight.w600, 1)
        ],
      ),
    );
  }

  _setCalendarView() {
    return Container(
      // height: MediaQuery.of(context).size.width,
      // color: Colors.red,
      padding: EdgeInsets.all(20),
      child: Material(
        color: AppColor.themeColor,
        borderRadius: BorderRadius.circular(8),
        elevation: 2.0,
        child: TableCalendar(
          calendarController: _calendarController,
          events: _events,
          holidays: _holidays,
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.white),
              weekendStyle: TextStyle(color: Colors.white)),
          calendarStyle: CalendarStyle(
            weekdayStyle: TextStyle(
              color: Colors.white,
            ),
            weekendStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            selectedColor: Colors.deepOrange[400],
            todayColor: Colors.orange[400],
            markersColor: Colors.black,
            outsideDaysVisible: false,
          ),
          onDaySelected: _onDaySelected,
          onVisibleDaysChanged: _onVisibleDaysChanged,
        ),
      ),
    );
  }
  List<String> _times = ['10.00:00', '14:00:00', '16:00:00', '18:00:00'];

  _setTimingView() {
    return Container(
      height: 100,
      padding: EdgeInsets.all(15),
      child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width / 3,
            padding: EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColor.themeColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: DropdownButton(
                  hint: Text('Pick a Time'),
                  value: _selectedvalue,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedvalue = newValue;
                    });
                  },
                  items: _times.map((time) {
                    return DropdownMenuItem(
                      child: Text(time),
                      value: time,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),


    );
  }

  _setBookNowView() {
    return Container(
        height: 110,
        child: Padding(
            padding: EdgeInsets.all(30),
            child: InkWell(
              onTap: () {
                _process_appointment();
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  color: AppColor.themeColor,
                  borderRadius: BorderRadius.circular(25),
                  elevation: 5.0,
                  child: Center(
                    child: Text(
                      _isLoading ? 'Processing.......' : 'Book Now',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: ListView(
            children: <Widget>[
              _setProfileImageView(),
              SizedBox(
                height: 30,
              ),
              setCommonTextFieldForFillTheDetails("Enter Phone Number", Icons.phone, phone),
              SizedBox(
                height: 20,
              ),
              setCommonTextFieldForFillTheDetails("Enter Description", Icons.note, description),
              _setCalendarView(),
              _setTimingView(),
              setCommonTextPay(),
              _setBookNowView(),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(
              'Book Appointment',
              Colors.white),
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

  void _process_appointment() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'phone_number': phone.text,
      'user_id': id,
      'doctor_id' :  widget.doctorInfo.id,
      'description' : description.text,
      'date' : picked_day.toString(),
      'time' : _selectedvalue.toString()

    };
//    print(data);
    var res = await Network().processappointment(data, 'process_appointments');
//    print("Here");
//    print(res.body);
    var body = json.decode(res.body);
    print(body);
    var status = res.body.contains('ok');

    if (status) {
      sendemail(picked_day, _selectedvalue);
    }else{
      _showDialog('Error', 'Something went wrong in processing the details');
    }


  }


}
