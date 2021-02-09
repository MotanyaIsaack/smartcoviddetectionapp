import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:health_care/models/patient/patients.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  final numberFormatter = NumberFormat("#,### ksh");

  @override
  Widget build(BuildContext context) {
    final patientData = Provider.of<Patients>(context);
    final patients = patientData.items;

    return Flexible(
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: ListView.builder(
          itemCount: patients.length,
          itemBuilder: (ctx, i) {
            return Container(
              padding: EdgeInsets.only(top: 1, right: 10, left: 10, bottom: 10),
              margin: EdgeInsets.only(top: 6, right: 3, bottom: 10, left: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 5),
                    title: Text(patients[i].name),
                    subtitle: Text(patients[i].procedure),
                    trailing: Text(
                        numberFormatter.format(patients[i].amount).toString()),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(patients[i].profileImage),
                    ),
                  ),
                  Text(
                    patients[i].description,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
