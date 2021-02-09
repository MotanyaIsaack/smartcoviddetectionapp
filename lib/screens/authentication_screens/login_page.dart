import 'package:flutter/material.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/helper/api.dart';
import 'package:health_care/models/user/users.dart';
import 'package:health_care/screens/authentication_screens/forgot_password.dart';
import 'package:health_care/screens/authentication_screens/signup_page.dart';
import 'package:health_care/screens/doctors_screens/dashboard.dart';
import 'package:health_care/screens/user_screens/dashboard.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool value = false;

  _setLoginView() {
    return Container(
      padding: EdgeInsets.all(20),
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      child: Form(
//        key: _formKey,
//        autovalidate: _autoValidate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 100,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(AppImage.appLogo))),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 45,
              // color: Colors.teal,
              padding: EdgeInsets.only(left: 8, right: 25),
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(22.5),
//          border: Border.all(color: AppColor.themeColor)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Colors.grey,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
//              textDirection: SharedManager.shared.direction,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 45,
              // color: Colors.teal,
              padding: EdgeInsets.only(left: 8, right: 25),
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(22.5),
//          border: Border.all(color: AppColor.themeColor)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.vpn_key,
                    color: Colors.grey,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _passwordController,
//              textDirection: SharedManager.shared.direction,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: this.value,
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                    });
                  },
                ),
                Text(
                  AppTitle.rememberMe,
                  textDirection: SharedManager.shared.direction,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: _login,
//              (){
//                Navigator.pushNamed(context, DashboardScreen.routeName);
//              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  color: AppColor.themeColor,
                  borderRadius: BorderRadius.circular(22.5),
                  elevation: 5.0,
                  child: Center(
                    child: Text(
                      _isLoading ? 'Processing.......' : AppTitle.loginSignIn,
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  child: Text(
                    AppTitle.loginForgetPass,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPassword()));
                  },
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  AppTitle.loginDontHaveAccount,
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
                    AppTitle.loginSignUp,
                    textDirection: SharedManager.shared.direction,
                    style: TextStyle(
                        color: AppColor.themeColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(SignupPage.routeName);
                  },
                ),
                SizedBox(
                  height: 25,
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
      body: Container(
          child: ListView(
        children: <Widget>[
          _setLoginView(),
        ],
      )),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': _emailController.text,
      'password': _passwordController.text
    };
//    print(data);
    var res = await Network().authData(data, 'login');
//    print("Here");
//    print(res.body);
    var body = json.decode(res.body);
    print(body);
    var status = res.body.contains('success');

    if (status) {
      Map<String, dynamic> logindata = jsonDecode(res.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', logindata['success']['token']);
      localStorage.setString('user', json.encode(body['first_name']));
      localStorage.setString('user_id', json.encode(body['user_id']));
      var user_details = await Network().getUserData('details');

      Map userMap = jsonDecode(user_details.body);
//      print(userMap);
      var user = User.fromJson(userMap['success']);

      localStorage.setString('first_name', user.first_name);
      localStorage.setString('last_name', user.last_name);
      localStorage.setString('phone', user.phone_number);
      localStorage.setString('email', user.email);
      localStorage.setInt('id', user.id);
      // //if ((user.profile_picture).contains(".jpg")) {
      //   localStorage.setString('image', user.profile_picture);
      // // }
      print(user.id);
      var det = User(email: user.email);
      print(det.email);
//    localStorage.setStringList('role', json.encode(user_details).toList());
      if (user.role_id == 2) {
        await Navigator.pushNamed(context, DashboardScreen.routeName);
      } else {
        await Navigator.pushReplacementNamed(context, DashBoard.routeName);
      }
    } else {
      _showDialog();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed'),
            content: Text('Check your email or password'),
            actions: <Widget>[
              RaisedButton(
                child: Text(
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
