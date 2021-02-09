import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Helper/constant.dart';
import 'package:health_care/Helper/shared_manager.dart';
import 'package:health_care/screens/user_screens/Appointmentdetails.dart';
import 'package:health_care/screens/user_screens/NotificationList.Dart';

setHeaderTitle(String title, dynamic color) {
  // return new Text(title,
  //     style: new TextStyle(
  //       color: color,
  //       fontWeight: FontWeight.w600,
  //       fontSize: 22,
  //     ),
  //     textAlign: TextAlign.center,
  // );

  return AutoSizeText(
    title,
    textDirection: SharedManager.shared.direction,
    style: TextStyle(
      color: color,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

setCommonText(String title, dynamic color, dynamic fontSize, dynamic fontweight,
    dynamic noOfLine) {
  //This is for the normal text.
  // return new Text(
  //   title,
  //   style: new TextStyle(
  //     color: color,
  //     fontSize: fontSize,
  //     fontWeight: fontweight,
  //   ),
  //   maxLines: noOfLine,
  //   overflow: TextOverflow.ellipsis,
  // );

  return AutoSizeText(
    title,
    textDirection: SharedManager.shared.direction,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontweight,
    ),
    maxLines: noOfLine,
    overflow: TextOverflow.ellipsis,
  );
}

setCommonTextFieldForFillTheDetails(String hinttext, dynamic myIcon) {
  return Container(
    height: 50,
    // color: Colors.teal,
    padding: EdgeInsets.only(
      left: 12,
      right: 25,
      bottom: 4,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColor.themeColor)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          myIcon,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextFormField(
            textDirection: SharedManager.shared.direction,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        )
      ],
    ),
  );
}

setWidgetsForList(String imgUrl, String name, String role, String hospital,
    String review, bool isOnline) {
  return Container(
    height: 120,
    padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
    child: Material(
      // color: Colors.yellow,
      elevation: 2.0,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: AppColor.themeColor),
                      image: DecorationImage(
                        image: NetworkImage(imgUrl),
                        fit: BoxFit.contain,
                      )),
                ),
                Positioned(
                  left: 65,
                  right: 5,
                  top: 10,
                  child: Container(
                    height: 8,
                    width: 8,
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 4,
              child: Container(
                height: 120,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText(name, Colors.black, 17.0, FontWeight.w600, 1),
                    SizedBox(
                      height: 5,
                    ),
                    setCommonText(role, Colors.grey, 15.0, FontWeight.w500, 1),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.place,
                          size: 18,
                          color: Colors.grey[400],
                        ),
                        setCommonText("$hospital", Colors.grey[400],
                            15.0, FontWeight.w600, 1),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(top: 8, right: 5),
                height: 120,
                // color: Colors.green,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.star_border,
                      color: AppColor.themeColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    FittedBox(
                      child: setCommonText(
                          review?? ' ', Colors.black, 15.0, FontWeight.w600, 1),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

setAppointmentListView(int index, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AppointmentDetails()));
    },
    child: Container(
      padding: EdgeInsets.only(top: 7, bottom: 7),
      height: 100,
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            children: <Widget>[
               Container(
                color: AppColor.themeColor,
                height: 50,
                width: 2,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("Periodic health check", Colors.black, 16.0,
                          FontWeight.w600, 2),
                      SizedBox(
                        height: 5,
                      ),
                      setCommonText(
                          "11AM - 3PM", Colors.grey, 15.0, FontWeight.w600, 2),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: AppColor.themeColor),
                    image: DecorationImage(
                      image: AssetImage(AppImage.doctorList),
                      fit: BoxFit.cover,
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

setCommonCartNitificationView(BuildContext context) {
  return <Widget>[
    Container(
      height: 20,
      width: 30,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NotificationsScreen()));
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Icon(
              Icons.notifications,
              color: Colors.white,
              size: 25,
            ),
            Positioned(
                top: 8,
                left: 13,
                child: Container(
                  height: 16,
                  width: 16,
                  child: Material(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                      child: Center(
                        child: setCommonText(
                            "7", Colors.black54, 12.0, FontWeight.w500, 1),
                      )),
                ))
          ],
        ),
      ),
    ),
    SizedBox(
      width: 20,
    )
  ];
}
