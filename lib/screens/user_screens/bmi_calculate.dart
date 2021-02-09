import 'package:flutter/material.dart';
import 'package:health_care/helper/common_widgets/commonwidgets.dart';
import 'package:health_care/helper/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BMI_calculate extends StatefulWidget {
  static const routeName = '/bmiCalculate';
  @override
  _BMI_calculateState createState() => _BMI_calculateState();
}

class _BMI_calculateState extends State<BMI_calculate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: setHeaderTitle('BMI Calculator', Colors.white),
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
                  '<iframe id="tool_bmi" src="https://assets.nhs.uk/tools/bmi/index.html?syn_id=e9e53230-bc57-11ea-baab-bf7bd459f893" style = "width:100%;" frameborder="0" scrolling="no" seamless></iframe><script src="https://assets.nhs.uk/tools/bmi/js/iframe_helper.js"></script>'
                  '</div></body>'
                  '</html>'
              , mimeType: 'text/html').toString(),
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
