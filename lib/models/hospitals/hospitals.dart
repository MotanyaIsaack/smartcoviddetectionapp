import 'dart:io';

import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

Hospital userFromJson(String str) => Hospital.fromJson(jsonDecode(str));

@JsonSerializable()
class Hospital with ChangeNotifier {
//  final int id;
  String name;
  String province;
  String district;
  String division;
  String location;
  String sub_location;
  String level;
  String agency;
  String long;
  String lat;
  int id;

  Hospital({
    this.name,
    this.province,
    this.district,
    this.division,
    this.location,
    this.sub_location,
    this.level,
    this.agency,
    this.long,
    this.lat,
    this.id,
  });

  Hospital copyWith(
          {String name,
          String province,
          String district,
          String division,
          String location,
          String sub_location,
          String level,
          String agency,
          String long,
          String lat,
          int id}) =>
      Hospital(
//        id: id ?? this.id,
        name: name ?? this.name,
        province: province ?? this.province,
        district: district ?? this.district,
        division: division ?? this.division,
        location: location ?? this.location,
        sub_location: sub_location ?? this.sub_location,
        level: level ?? this.level,
        agency: agency ?? this.agency,
        long: long ?? this.long,
        lat: lat ?? this.lat,
        id: id ?? this.id,
      );

  factory Hospital.fromRawJson(String str) =>
      Hospital.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hospital.fromJson(Map<String, dynamic> json) =>
      Hospital(
        name: json["name"],
        province: json["province"],
        district: json["district"],
        division: json["division"],
        location: json["location"],
        sub_location: json["sub_location"],
        level: json["level"],
        agency: json["agency"],
        long: json["longitude"],
        lat: json["latitude"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "province": province == null ? null : province,
        "district": district == null ? null : district,
        "division": division == null ? null : division,
        "location": location == null ? null : location,
        "level": level == null ? null : level,
        "agency": agency == null ? null : agency,
        "longitude": long == null ? null : long,
        "latitude": lat == null ? null : lat,
        "id": id == null ? null : id,
      };


}
