import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/widgets/comonloginwidgets.dart';

void main() => runApp(new ForgotPassword());

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool value = false;

  _setForGotPasswordView() {
    return new Container(
      padding: new EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: new Column(
          children: <Widget>[
            new Text(
              AppTranslations.of(context).text(AppTitle.loginForgetPass),
              textDirection: SharedManager.shared.direction,
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            new Text(
              AppTranslations.of(context).text(AppTitle.forgetPassStr),
              textAlign: TextAlign.center,
              textDirection: SharedManager.shared.direction,
              style: new TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 35,
            ),
            MyTextFormFields(
                hintText:
                    AppTranslations.of(context).text(AppTitle.forgotPassEmail),
                icon: Icons.email),
            SizedBox(
              height: 25,
            ),
            new Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: new Material(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.circular(22.5),
                elevation: 5.0,
                child: new Center(
                  child: new Text(
                    AppTranslations.of(context)
                        .text(AppTitle.forgotPassSendEmail),
                    textDirection: SharedManager.shared.direction,
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColor.themeColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
        ),
        body:
            new Container(color: Colors.white, child: _setForGotPasswordView()),
      ),
      theme: SharedManager.shared.getThemeType(),
      localizationsDelegates: [
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [SharedManager.shared.language],
    );
  }
}
