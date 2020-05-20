import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myAppBills/components/my_label.dart';
import 'package:myAppBills/generated/l10n.dart';

class DialogUtil {
  static void confirmationMessage(BuildContext context, String title, String message, {List<Widget> actions}) {
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FittedBox(
                fit: BoxFit.fitHeight,
                child: MyLabel(label: title.toUpperCase(), fontSize: 24, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w300)),
            InkWell(child: ImageIcon(new AssetImage("assets/images/ic_close.png"), color: Colors.black,), onTap: () => Navigator.of(context).pop()),
          ],
        ),
        titlePadding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0),
        contentPadding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
        content: Container(
            height: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(0), child: ImageIcon(new AssetImage("assets/images/ic_alert.png"), size: 140, color: Color(0xffff6a00))),
                Container(
                  margin: EdgeInsets.only(left:8.0, right: 8.0),
                  child: MyLabel(label: message, fontSize: 12, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w500),
                ),
                Container(margin: EdgeInsets.all(0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: actions)),
              ],
            )));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  static void alertMessage(BuildContext context, String title, String message) {
    _message(context, title, message, "assets/images/ic_alert.png", Color(0xffff6a00));
  }

  static void successMessage(BuildContext context, String title, String message) {
    _message(context, title, message, "assets/images/ic_valid.png", Color(0xff219653));
  }

  static void errorMessage(BuildContext context, String title, String message) {
    _message(context, title, message, "assets/images/ic_error.png", Color(0xffe61739));
  }

  static void _message(BuildContext context, String title, String message, String icon, Color colorIcon) {
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyLabel(label: title, fontSize: 24, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w300),
            InkWell(child: ImageIcon(new AssetImage("assets/images/ic_close.png"), color: Colors.black,), onTap: () => Navigator.of(context).pop()),
          ],
        ),
        titlePadding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0),
        contentPadding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 45),
        content: Container(
            height: 170,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                  child: ImageIcon(new AssetImage(icon), size: 140, color: colorIcon),
                ),
                MyLabel(label: message, fontSize: 12, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w500),
              ],
            )));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
