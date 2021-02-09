import 'package:flutter/foundation.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(jsonDecode(str));

class User with ChangeNotifier {
//  final int id;
  String first_name;
  String last_name;
  String phone_number;
  int role_id;
  String email;
  String profile_picture;
  int id;

  User(
      {this.first_name,
      this.last_name,
      this.phone_number,
      this.role_id,
      this.email,
      this.profile_picture,
      this.id});

  User copyWith(
          {String first_name,
          String last_name,
          String email,
          String phone_number,
          int role_id,
          String profile_picture,
          int id}) =>
      User(
//        id: id ?? this.id,
        first_name: first_name ?? this.first_name,
        last_name: last_name ?? this.last_name,
        email: email ?? this.email,
        phone_number: phone_number ?? this.phone_number,
        role_id: role_id ?? this.role_id,
        profile_picture: profile_picture ?? this.profile_picture,
        id: id ?? this.id,
//        password: password ?? this.password,
//        goodReviews: goodReviews ?? this.goodReviews,
//        totalScore: totalScore ?? this.totalScore,
//        satisfaction: satisfaction ?? this.satisfaction,
//        isfavourite: isfavourite ?? this.isfavourite,
//        image: image ?? this.image,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        first_name: json["first_name"] == null ? null : json["first_name"],
        last_name: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        phone_number:
            json["phone_number"] == null ? null : json["phone_number"],
        role_id: json["role_id"] == null ? null : json["role_id"],
        profile_picture:
            json["image"] == null ? null : json["image"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": first_name == null ? null : first_name,
        "last_name": last_name == null ? null : last_name,
        "email": email == null ? null : email,
        "phone_number": phone_number == null ? null : phone_number,
        "role_id": role_id == null ? null : role_id,
        "image": profile_picture == null ? null : profile_picture,
        "id": id == null ? null : id,
      };
}
