import 'package:flutter/material.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/screens/CallFunctionality/src/ProfileRegister.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EatwellScreen extends StatefulWidget {
  static const routeName = '/eatwell';
  @override
  _EatwellScreenState createState() => _EatwellScreenState();
}

class _EatwellScreenState extends State<EatwellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: setHeaderTitle('Eat Well', Colors.white),
        backgroundColor: AppColor.themeColor,
        elevation: 1.0,
      ),
      body:  Container(
        width: double.infinity,
        child: WebView(
          initialUrl: Uri.dataFromString(
              '<html>'
                  '<body>'
                  '<div>'
                  '<iframe id="tool_eatwell" src="https://assets.nhs.uk/tools/eatwell/index.html?syn_id=e9e53230-bc57-11ea-baab-bf7bd459f893" style = "width:100%;" frameborder="0" scrolling="no" seamless></iframe><script src="https://assets.nhs.uk/tools/eatwell/js/iframe_helper.js"></script>'
                  '</div></body>'
                  '</html>'
              , mimeType: 'text/html').toString(),
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
