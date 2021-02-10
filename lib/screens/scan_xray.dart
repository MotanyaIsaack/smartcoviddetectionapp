import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_care/helper/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanXray extends StatefulWidget {
  @override
  _ScanXrayState createState() => _ScanXrayState();
}

class _ScanXrayState extends State<ScanXray> {
  String path;
  String _output;
  File _image;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Scan Xray')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _image == null
              ? Center(child: Text('Scanned Xray will be displayed here'))
              : ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(30),
                  children: [
                    Container(
                      height: h * .25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _output == null
                        ? SizedBox()
                        : Text(
                            "FINDINGS",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.center,
                          ),
                    SizedBox(height: 20),
                    _output == null
                        ? Center(
                            child: RaisedButton.icon(
                              onPressed: predict,
                              icon: Icon(Icons.assignment),
                              label: Text('View Predictions'),
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : Text(
                            "Classification: $_output",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              backgroundColor:
                                  _output == "Normal lungs detected"
                                      ? Colors.green
                                      : Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular((10))),
        onPressed: pickImage,
        icon: Icon(Icons.camera_alt_rounded),
        label: Text('Capture Image'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  predict() async {
    var dio = Dio();

    try {
      setState(() {
        _loading = true;
      });
      FormData formData = FormData.fromMap(
          {"patient_xray_image": await MultipartFile.fromFile(_image.path)});
      final response = await dio.post("http://192.168.100.253:5000/classify",
          data: formData);
      _output = response.data['classification'];
      String imageName = basename(_image.path);
      final prefs = await SharedPreferences.getInstance();
      final id = await prefs.getInt("id");
      print(id);
      final data = {
        'user_id': id,
        'prediction': _output,
        'x_ray_image_name': imageName
      };
      http.Response res = await Network().authData(data, 'record_prediction');
      print(res.body);
      setState(() {
        _loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  pickImage() async {
    setState(() {
      _loading = true;
      _output = null;
    });
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(image.path);
    if (image == null) return null;

    setState(() {
      _loading = false;
    });
  }
}
