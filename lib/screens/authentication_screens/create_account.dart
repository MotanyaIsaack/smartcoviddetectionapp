import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/widgets/comonloginwidgets.dart';
import 'package:health_care/widgets/tabbar/tabbar.dart';

void main() => runApp(new CreateAccount());

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          elevation: 1.0,
          title: new Text(
            AppTranslations.of(context).text(AppTitle.createAccountTitle),
            style: new TextStyle(color: AppColor.themeColor, fontSize: 22),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                AppTranslations.of(context).text(AppTitle.onBoardSkip),
                style: new TextStyle(color: Colors.grey, fontSize: 18),
              ),
              onPressed: () {},
            )
          ],
        ),
        body: new Form(
          key: _formKey,
          child: new Container(
            color: Colors.white,
            padding: new EdgeInsets.all(20),
            child: new ListView(
              children: <Widget>[
                createAccountTextField(
                    AppTranslations.of(context)
                        .text(AppTitle.createAccountFullName),
                    Icons.keyboard_arrow_down,
                    0),
                SizedBox(
                  height: 35,
                ),
                createAccountTextField(
                    AppTranslations.of(context).text(AppTitle.createAccountDOB),
                    Icons.keyboard_arrow_down,
                    1),
                SizedBox(
                  height: 35,
                ),
                createAccountTextField(
                    AppTranslations.of(context)
                        .text(AppTitle.createAccountGender),
                    Icons.keyboard_arrow_down,
                    2),
                SizedBox(
                  height: 35,
                ),
                createAccountTextField(
                    AppTranslations.of(context)
                        .text(AppTitle.createAccountWeight),
                    Icons.keyboard_arrow_down,
                    3),
                SizedBox(
                  height: 35,
                ),
                createAccountTextField(
                    AppTranslations.of(context)
                        .text(AppTitle.createAccountHeight),
                    Icons.keyboard_arrow_down,
                    4),
                SizedBox(
                  height: 50,
                ),
                new InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      print(CreateAccountString.fullName);
                      print(CreateAccountString.dob);
                      print(CreateAccountString.gender);
                      print(CreateAccountString.weight);
                      print(CreateAccountString.height);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TabBarScreen()));
                    }
                  },
                  child: new Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    child: new Material(
                      color: AppColor.themeColor,
                      borderRadius: BorderRadius.circular(32.5),
                      elevation: 5.0,
                      child: new Center(
                        child: new Text(
                          AppTranslations.of(context)
                              .text(AppTitle.loginSignUp),
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
