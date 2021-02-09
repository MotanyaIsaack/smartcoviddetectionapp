import 'package:health_care/helper/api.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/models/appointment/appointment.dart';
import 'package:health_care/models/appointment/appointments.dart';
import 'package:flutter/material.dart';
import 'package:health_care/models/user/users.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {

   int id;

    bool _isLoading = false;
    bool _isSwitched = false;
    List<Appointment> _appointment;
    List<Appointment> appointment;


   void _loadUserData() async {
     var localStorage = await SharedPreferences.getInstance();
//    var user = jsonDecode(localStorage.getString('user'));
     setState(() {
       id = localStorage.getInt('id');
       print(id);
       _fetchData();
     });
   }

   Future<void> _fetchData() async {
     _isLoading = true;
     final apis = Network();
     var data = {
       'id': id,
     };
     appointment = await apis.getAppointments(data);
     setState(() {
       _appointment = appointment;
       print(_appointment);
//      _isLoading = false;
     });
   }

    @override
    void initState() {
      super.initState();
      _loadUserData();

    }

   @override
   Widget build(BuildContext context) {
     final chatsData = Provider.of<User>(context);

    return _appointment == null
        ? Center(child: LoadingJumpingLine.square(backgroundColor: Colors.red,)) :
    Flexible(
      child: ListView.builder(
        itemCount: _appointment.length,
        itemBuilder: (ctx, i) {
          return Card(
            child: ListTile(
              onTap: (){

              },
              title: Text(_appointment[i].fullName),
              subtitle: Text(
                _appointment[i].description,
                overflow: TextOverflow.ellipsis,
              ),
              dense: true,
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg'),
              ),
              trailing: Text(_appointment[i].date.toString(),
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
          );
        },
      ),
    );
  }
}
