import 'package:flutter/material.dart';
import 'package:myutility/components/my_label.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({this.label, this.onPressed, this.buttonColor, this.labelColor,this.borderColor, this.fontSize, this.elevation});

  @required
  final VoidCallback onPressed;

  @required
  final String label;

  @required
  final Color buttonColor;

  @required
  Color borderColor;

  @required
  final Color labelColor;

  double fontSize;

  double elevation;

  @override
  Widget build(BuildContext context) {

    borderColor = borderColor == null ? Colors.transparent: borderColor;
    fontSize = fontSize == null ? 14.0: fontSize;
    elevation = elevation == null ? 5.0 : elevation;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: elevation,
        onPressed: onPressed,
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.3),
            side: BorderSide(color: borderColor)
        ),
        color: buttonColor,
        child: Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            fontFamily: MyLabel.MEDIUM,
          ),
        ),
      ),
    );
  }
}
