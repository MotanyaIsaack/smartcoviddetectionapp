import 'dart:convert';

import 'package:flutter/material.dart';

class Appointment {
  final String fullName;
  final String profileImage;
  final String description;
  final String date;
  final String time;
  final int id;
  final String haspaid;


  // ignore: sort_constructors_first
  Appointment({this.fullName, this.profileImage, this.description, this.date, this.time, this.id, this.haspaid});

  Appointment copyWith({
    String fullName,
    String profileImage,
    String description,
    DateTime date,
    TimeOfDay time,
    int id,
    String haspaid,
  }) =>
      Appointment(
        fullName: fullName ?? this.fullName,
        profileImage: profileImage ?? this.profileImage,
        description: description ?? this.description,
        date: date ?? this.date,
        time: time ?? this.time,
        id: id ?? this.id,
        haspaid: haspaid ?? this.haspaid,
      );

  factory Appointment.fromRawJson(String str) =>
      Appointment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    fullName: json["patient_name"] == null ? null : json["patient_name"],
    description: json["description"] == null ? null : json["description"],
    date: json["date"] == null ? null : json["date"],
    time: json["time"] == null ? null : json["time"],
    id: json["user_id"] == null ? null : json["user_id"],
    haspaid: json["has_paid"] == null ? null : json["has_paid"],
  );

  Map<String, dynamic> toJson() => {
    "patient_name": fullName == null ? null : fullName,
    "profileImage": profileImage == null ? null : profileImage,
    "description": description == null ? null : description,
    "date": date == null ? null : date,
    "time": time == null ? null : time,
    "user_id": id == null ? null : id,
    "has_paid": haspaid == null ? null : haspaid,
  };
}


