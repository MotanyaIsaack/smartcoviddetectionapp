import 'package:flutter/material.dart';
import 'package:health_care/Helper/constant.dart';
import 'package:health_care/Helper/shared_manager.dart';

class MyTextFormFields extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isEmail;
  final bool isPassword;
  final IconData icon;

  MyTextFormFields({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isEmail = false,
    this.isPassword = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
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

class CreateAccountString {
  static var fullName = "";
  static var dob = "";
  static var gender = "";
  static var height = "";
  static var weight = "";
  static var day = "";
  static var watch_later = "";
}

createAccountTextField(String hinttext, dynamic myIcon, int tag) {
  return new Container(
    height: 65,
    // color: Colors.teal,
    padding: new EdgeInsets.only(left: 20, right: 8, bottom: 4, top: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.5),
        border: Border.all(color: AppColor.themeColor)),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new TextFormField(
            textDirection: SharedManager.shared.direction,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            style: new TextStyle(color: Colors.grey, fontSize: 16),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter $hinttext first";
              }
              {
                switch (tag) {
                  case 0:
                    CreateAccountString.fullName = value;
                    break;
                  case 1:
                    CreateAccountString.dob = value;
                    break;
                  case 2:
                    CreateAccountString.gender = value;
                    break;
                  case 3:
                    CreateAccountString.weight = value;
                    break;
                  case 4:
                    CreateAccountString.height = value;
                    break;
                  case 5:
                    CreateAccountString.day = value;
                    break;
                  case 6:
                    CreateAccountString.watch_later = value;
                    break;
                  default:
                }
                return value;
              }
            },
          ),
        ),
        new Icon(
          myIcon,
          color: Colors.grey,
          size: 30,
        ),
        SizedBox(
          width: 3,
        ),
      ],
    ),
  );
}
