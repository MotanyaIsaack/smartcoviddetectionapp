import 'dart:convert';

import 'package:health_care/screens/authentication_screens/signup_page.dart';

class DoctorModel {
  String full_name;
  String phone_number;
  String email;
  String hospital_name;
  String specialization;
  String id_number;
  String licence;
  String latitude;
  String longitude;
  String license_no;
  String image;
  int id;


  DoctorModel({
    this.full_name,
    this.phone_number,
    this.email,
    this.hospital_name,
    this.specialization,
    this.id_number,
    this.licence,
    this.latitude,
    this.longitude,
    this.license_no,
    this.image,
    this.id
  });

  DoctorModel copyWith({
    String full_name,
    String phone_number,
    String email,
    String hospital_name,
    String specialization,
    String id_number,
    String licence,
    String latitude,
    String longitude,
    String license_no,
    String image,
    String id,
  }) =>
      DoctorModel(
        full_name: full_name ?? this.full_name,
        phone_number: phone_number ?? this.phone_number,
        email: email ?? this.email,
        hospital_name: hospital_name ?? this.hospital_name,
        specialization: specialization ?? this.specialization,
        id_number: id_number ?? this.id_number,
        licence: licence ?? this.licence,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        license_no: license_no ?? this.license_no,
        image: image ?? this.image,
        id: id ?? this.id,
      );

  factory DoctorModel.fromRawJson(String str) =>
      DoctorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    full_name: json["full_name"] == null ? null : json["full_name"],
    phone_number: json["phone_number"] == null ? null : json["phone_number"],
    email: json["email"] == null ? null : json["email"],
    hospital_name: json["hospital_name"] == null ? null : json["hospital_name"],
    specialization:
    json["specialization"] == null ? null : json["specialization"],
    id_number:
    json["id_number"] == null ? null : json["id_number"],
    licence: json["licence"] == null
        ? null
        : json["licence"],
    license_no: json["license_no"] == null ? null : json["license_no"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    image: json["image"] == null ? null : json["image"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": full_name == null ? null : full_name,
    "phone_number": phone_number == null ? null : phone_number,
    "email": email == null ? null : email,
    "hospital_name": hospital_name == null ? null : hospital_name,
    "specialization": specialization == null ? null : specialization,
    "id_number": id_number == null ? null : id_number,
    "licence": licence == null ? null : licence,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "license_no": license_no == null ? null : license_no,
    "image": image == null ? null : image,
    "id": id == null ? null : id,
  };
}
