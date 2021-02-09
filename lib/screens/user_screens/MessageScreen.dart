import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/helper/shared_manager.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/localization/app_translations_delegate.dart';
import 'package:health_care/localization/application.dart';

void main() => runApp(new MessageScreen());

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle("Chat", Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
            color: Colors.grey[300],
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return (index % 2 == 0)
                          ? _setRightBubble()
                          : _setLeftBubble();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 15, right: 15, bottom: 25, top: 15),
                  height: 90,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.message,
                        color: AppColor.themeColor,
                        size: 22,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: AppColor.themeColor),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: TextFormField(
                            textDirection: SharedManager.shared.direction,
                            decoration: InputDecoration(
                                hintText: AppTitle.typeHere,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: AppColor.themeColor, fontSize: 16)),
                            style: TextStyle(
                                color: AppColor.themeColor, fontSize: 16),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 22,
                        ),
                        color: AppColor.themeColor,
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            )),
      ),

    );
  }


}

_setLeftBubble() {
  return Container(
    // height: 100,
    padding: EdgeInsets.only(left: 15, right: 100, top: 15, bottom: 15),
    child: Container(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: setCommonText("Hello, How may I help you?",
                        Colors.black54, 16.0, FontWeight.w500, 5),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  setCommonText(
                      "10.45 AM", Colors.grey[400], 14.0, FontWeight.w500, 5),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_setRightBubble() {
  return Container(
    // height: 110,
    padding: EdgeInsets.only(right: 15, left: 100, top: 15, bottom: 15),
    child: Container(
      child: Material(
        color: AppColor.themeColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: setCommonText(
                        "Hello doctor, Are you there? I want to discuss something with you.",
                        Colors.black87,
                        16.0,
                        FontWeight.w500,
                        5),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  setCommonText(
                      "10.45 AM", Colors.white, 14.0, FontWeight.w500, 5),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
