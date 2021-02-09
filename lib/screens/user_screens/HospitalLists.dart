import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/common_widgets//commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/user_model.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/localization/app_translations.dart';

void main() => runApp(new HospitalLists());

class HospitalLists extends StatefulWidget {
  @override
  _HospitalListsState createState() => _HospitalListsState();
}

class _HospitalListsState extends State<HospitalLists> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: new Container(
            color: Colors.grey[100],
            child: new ListView.builder(
              itemCount: hospitalList.length,
              itemBuilder: (context, index) {
                return setWidgetsForList(
                    hospitalList[index].image,
                    hospitalList[index].name,
                    hospitalList[index].address,
                    hospitalList[index].distance,
                    hospitalList[index].review,
                    false);
              },
            )),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(
              AppTranslations.of(context).text(AppTitle.hospital),
              Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
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
