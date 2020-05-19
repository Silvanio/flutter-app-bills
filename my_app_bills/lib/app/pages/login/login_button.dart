import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginButton extends StatelessWidget {
  LoginButton({this.label, this.onPressed});

  @required
  final VoidCallback onPressed;
  @required
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        disabledColor: Colors.white60,
        child: Text(
          label,
          style: TextStyle(
            color: Color(0xAAAAAAAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
