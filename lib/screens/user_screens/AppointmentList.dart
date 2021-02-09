import 'package:flutter/material.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointMentList extends StatefulWidget {
  static const routeName = '/appointmentscreen';
  @override
  _AppointMentListState createState() => _AppointMentListState();
}

class _AppointMentListState extends State<AppointMentList>
    with TickerProviderStateMixin {
  final Map<DateTime, List> _holidays = {
    DateTime(2019, 1, 1): ['New Year\'s Day'],
    DateTime(2019, 1, 6): ['Epiphany'],
    DateTime(2019, 2, 14): ['Valentine\'s Day'],
    DateTime(2019, 4, 21): ['Easter Sunday'],
    DateTime(2019, 4, 22): ['Easter Monday'],
  };

  Map<DateTime, List> _events;
  List selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
    };

    selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  _setColenderView() {
    return Container(
      child: Material(
        color: AppColor.themeColor,
        elevation: 10.0,
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
          headerStyle: HeaderStyle(
            formatButtonTextStyle:
                TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
            formatButtonDecoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          onDaySelected: _onDaySelected,
          onVisibleDaysChanged: _onVisibleDaysChanged,
        ),
      ),
    );
  }

  _setAppointmentList() {
    return Container(
      color: Colors.grey[100],
      height: 550,
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return setAppointmentListView(index, context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          children: <Widget>[
            _setColenderView(),
            SizedBox(
              height: 20,
            ),
            _setAppointmentList()
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
        title: setHeaderTitle(AppTitle.dashbAppointment, Colors.white),
        backgroundColor: AppColor.themeColor,
        elevation: 1.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
  //This is for localization

}
