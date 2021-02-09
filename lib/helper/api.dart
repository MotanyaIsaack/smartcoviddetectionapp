import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:health_care/models/appointment/appointment.dart';
import 'package:health_care/models/doctors/doctors.dart';
import 'package:health_care/models/hospitals/hospitals.dart';
import 'package:health_care/models/user/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'https://smartcovidpredictor.azurewebsites.net/api/';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

  authData(data, apiUrl) async {
    print(data);
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
//    ).then((onResponse){
//      print(onResponse.body);
//    }).catchError((onError){
//      print(onError.toString());
//    });
  }

  processappointment(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
//    ).then((onResponse){
//      print(onResponse.body);
//    }).catchError((onError){
//      print(onError.toString());
//    });
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
//    if (response.statusCode == 200){
//      return User.fromJson(json.decode(response.body));
//    }else{
//      throw Exception('Failed to load');
//    }
  }

  getUserData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    print(token);
    return await http.post(fullUrl, headers: _setHeaders());
//    if (response.statusCode == 200){
//      return User.fromJson(json.decode(response.body));
//    }else{
//      throw Exception('Failed to load');
//    }
  }

  Future<List> getGoogleHospitals() async {
    const googleHospitalsURL =
        'https://smartcovidpredictor.azurewebsites.net/api/get_hospitals';

    // Retrieve the locations of Google offices
    final response = await http.get(googleHospitalsURL);
    if (response.statusCode == 200) {
      final List<dynamic> map = json.decode(response.body);
      final parsed = map.cast<Map<String, dynamic>>();
      return parsed.map<Hospital>((json) => Hospital.fromJson(json)).toList();
    } else {
      throw HttpException(
          'Unexpected status code ${response.statusCode}:'
          ' ${response.reasonPhrase}',
          uri: Uri.parse(googleHospitalsURL));
    }
  }

  Future<List> getDoctors() async {
    const getDoctorsURL =
        'https://smartcovidpredictor.azurewebsites.net/api/get_doctors_json';
    // Retrieve the locations of Google offices
    final response = await http.get(getDoctorsURL);
    if (response.statusCode == 200) {
      final List<dynamic> map = json.decode(response.body);
      final parsed = map.cast<Map<String, dynamic>>();
      return parsed
          .map<DoctorModel>((json) => DoctorModel.fromJson(json))
          .toList();
    } else {
      throw HttpException(
          'Unexpected status code ${response.statusCode}:'
          ' ${response.reasonPhrase}',
          uri: Uri.parse(getDoctorsURL));
    }
  }

  Future<List> getAppointments(data) async {
    print(data);
    const getappointment =
        'https://smartcovidpredictor.azurewebsites.net/api/get_appointments';
    // Retrieve the locations of Google offices
    final response =
        await http.post(getappointment, body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> map = json.decode(response.body);
      final parsed = map.cast<Map<String, dynamic>>();
      return parsed
          .map<Appointment>((json) => Appointment.fromJson(json))
          .toList();
    } else {
      throw HttpException(
          'Unexpected status code ${response.statusCode}:'
          ' ${response.reasonPhrase}',
          uri: Uri.parse(getappointment));
    }
  }

//  getUserData(apiUrl) async {
//    var fullUrl = _url + apiUrl;
//    await _getToken();
//    print(token);
//    final response =  await http.post(
//        fullUrl,
//        headers: _setHeaders()
//    );
//    if (response.statusCode == 200){
//      return User.fromJson(json.decode(response.body));
//    }else{
//      throw Exception('Failed to load');
//    }
//  }
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
