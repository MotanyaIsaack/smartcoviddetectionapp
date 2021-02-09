import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/helper/api.dart';
import 'package:health_care/helper/databasehelper.dart';
import 'package:health_care/screens/user_screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart' as validator;

void mian() => runApp(new SignupPage());

class SignupPage extends StatefulWidget {
  static const routeName = '/register';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  // Boolean variable for CircularProgressIndicator.
  final TextEditingController _firstnameController =
      new TextEditingController();
  final TextEditingController _lastnameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _passwordController2 =
      new TextEditingController();
  bool _isloading = false;
  _onPressed() {
    setState(() {
      _isloading = true;
      if (_emailController.text.trim().toLowerCase().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty) {
        databaseHelper
            .registerData(
                _firstnameController.text.trim(),
                _lastnameController.text.trim(),
                _phoneController.text.trim(),
                _emailController.text.trim().toLowerCase(),
                _passwordController.text.trim())
            .whenComplete(() {
          if (databaseHelper.status) {
            _showDialog();
            msgStatus = 'Check email or password';
          } else {
            Navigator.of(context).pushNamed(DashboardScreen.routeName);
          }
        });
      }
    });
  }

  String firstName;
  String lastName;
  String phoneNumber;
  String password;
  String email;

  _setSignUPView() {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(AppImage.appLogo))),
            ),
            SizedBox(
              height: 50,
            ),
            TextInputContainer(
              controller: _firstnameController,
              hintText: 'Firstname',
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter your firstname';
                }
                return null;
              },
              onSaved: (String value) {
                firstName = value;
              },
              icon: Icons.person,
            ),
            SizedBox(
              height: 25,
            ),
            TextInputContainer(
              controller: _lastnameController,
              hintText: 'Lastname',
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter your lastname';
                }
                return null;
              },
              onSaved: (String value) {
                lastName = value;
              },
              icon: Icons.person,
            ),
            SizedBox(
              height: 25,
            ),
            TextInputContainer(
              controller: _phoneController,
              hintText: 'Phone',
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter your Phone';
                }
                return null;
              },
              onSaved: (String value) {
                phoneNumber = value;
              },
              icon: Icons.person,
            ),
            SizedBox(
              height: 25,
            ),
            TextInputContainer(
              controller: _emailController,
              hintText: 'Email',
              isEmail: true,
              validator: (String value) {
                if (!validator.isEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onSaved: (String value) {
                email = value;
              },
              icon: Icons.email,
            ),
            SizedBox(
              height: 25,
            ),
            TextInputContainer(
              controller: _passwordController,
              hintText: 'Password',
              isPassword: true,
              validator: (String value) {
                if (value.length < 7) {
                  return 'Password should be minimum 7 characters';
                }
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) {
                password = value;
              },
              icon: Icons.lock,
            ),
            SizedBox(
              height: 25,
            ),
            TextInputContainer(
              controller: _passwordController2,
              hintText: 'Confirm Password',
              isPassword: true,
              validator: (String value) {
                if (value.length < 7) {
                  return 'Password should be minimum 7 characters';
                } else if (password != null && value != password) {
                  print(value);
                  print(password);
                  return 'Password not matched';
                }
                return null;
              },
              icon: Icons.lock,
            ),
            SizedBox(
              height: 45,
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState.validate()) {
                  _register();
//      Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
//    If all data are correct then save data to out variables
                  _formKey.currentState.save();
                } else {
//    If all data are not valid then start auto validation.
                  setState(() {
                    _autoValidate = true;
                  });
                }
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  color: AppColor.themeColor,
                  borderRadius: BorderRadius.circular(22.5),
                  elevation: 5.0,
                  child: Center(
                    child: Text(
                      _isloading ? "Creating ... " : AppTitle.loginSignUp,
                      textDirection: SharedManager.shared.direction,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  AppTitle.signUpNote,
                  textDirection: SharedManager.shared.direction,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 2,
                ),
                InkWell(
                  child: Text(
                    AppTitle.loginSignIn,
                    textDirection: SharedManager.shared.direction,
                    style: TextStyle(
                        color: AppColor.themeColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  height: 50,
                  child: Text(
                    '$msgStatus',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.themeColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[_setSignUPView()],
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isloading = true;
    });
    var data = {
      'first_name': _firstnameController.text,
      'last_name': _lastnameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'phone_number': _phoneController.text
    };

    var res = await Network().authData(data, 'register');
    var body = json.decode(res.body);
    print(body['success']['id']);
    print(body['success']['first_name']);
    var status = res.body.contains('success');
    if (status) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['success']['token']));
      localStorage.setString(
          'user', json.encode(body['success']['first_name']));
      localStorage.setString('user_id', json.encode(body['success']['id']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      _showDialog();
    }

    setState(() {
      _isloading = false;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Failed'),
            content: new Text('Something went Wrong.'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
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
}

class TextInputContainer extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isEmail;
  final bool isPassword;
  final IconData icon;
  final TextEditingController controller;
  const TextInputContainer(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.isEmail = false,
      this.isPassword = false,
      this.icon,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      // color: Colors.teal,
      padding: new EdgeInsets.only(left: 8, right: 25),
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(22.5),
//          border: Border.all(color: AppColor.themeColor)),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            icon,
            color: Colors.grey,
            size: 18,
          ),
          SizedBox(
            width: 5,
          ),
          new Expanded(
            child: new TextFormField(
              controller: controller,
              textDirection: SharedManager.shared.direction,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              style: new TextStyle(color: Colors.grey, fontSize: 16),
              obscureText: isPassword ? true : false,
              validator: validator,
              onSaved: onSaved,
              keyboardType:
                  isEmail ? TextInputType.emailAddress : TextInputType.text,
            ),
          )
        ],
      ),
    );
  }
}
