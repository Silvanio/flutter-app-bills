import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyLabel extends StatelessWidget {
  static const LIGHT = "Montserrat-Light";
  static const REGULAR = "Montserrat-Regular";
  static const MEDIUM = "Montserrat-Medium";

  MyLabel({this.label, this.color, this.fontSize, this.fontFamily, this.fontWeight, this.decoration, this.height});

  @required
  String label;
  Color color;
  double fontSize;
  String fontFamily;
  FontWeight fontWeight;
  TextDecoration decoration;
  double height;

  @override
  Widget build(BuildContext context) {
    label = label == null ? "" : label;
    color = color == null ? Color(0xff1f414d) : color;
    fontSize = fontSize == null ? 11 : fontSize;
    fontFamily = fontFamily == null ? REGULAR : fontFamily;
    fontWeight = fontWeight == null ? FontWeight.normal : fontWeight;
    decoration = decoration == null ? TextDecoration.none : decoration;
    height = height == null ? null : height;

    return Text(label, style:
    TextStyle(color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        decoration: decoration,
        height: height
    ));
  }
}
