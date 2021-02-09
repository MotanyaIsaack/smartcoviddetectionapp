import 'package:flutter/material.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:health_care/localization/app_translations.dart';
import 'package:health_care/screens/CallFunctionality/src/ProfileRegister.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FinderScreen extends StatefulWidget {
  static const routeName = '/search';
  @override
  _FinderScreenState createState() => _FinderScreenState();
}

class _FinderScreenState extends State<FinderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: setHeaderTitle('Health Finder', Colors.white),
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
              '<iframe src="https://api-bridge.azurewebsites.net/conditions/?p=all&aspect=name,overview_short,symptoms_short,symptoms_long,treatments_overview_short,other_treatments_long,self_care_long,prevention_short,causes_short&tab=0&uid=e9e53230-bc57-11ea-baab-bf7bd459f893" title="NHS website - health a-z" style="position: absolute; height: 100%; width: 100%; border: 2px solid #015eb8;"></iframe>'
              '</div></body>'
              '</html>'
              , mimeType: 'text/html').toString(),
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
