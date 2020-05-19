import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Color(0xAAAAAAAA),
  fontFamily: 'OpenSans',
);

final kHintTextStyleError = TextStyle(
    color: Colors.red,
    height: 0
);

final kLabelStyleDropItem = TextStyle(
  color: Color(0xAAAAAAAA),
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kLabelDropBoxStyle = TextStyle(
  color: Color(0xAAAAAAAA),
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Color(0xAAAAAAAA),
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kTextStyleBoldUnderlinedBlack = TextStyle(
  color: Color(0xA0000000),
  letterSpacing: 1.5,
  fontSize: 11.0,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
  fontFamily: 'OpenSans',
);

final kTextStyleBoldBlack = TextStyle(
  color: Color(0xA0000000),
  letterSpacing: 1.5,
  fontSize: 11.0,
  fontWeight: FontWeight.normal,
  fontFamily: 'OpenSans',
);

final kTextStyleBoldBlackTitle = TextStyle(
  color: Color(0xA0000000),
  letterSpacing: 1.5,
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
  fontFamily: 'OpenSans',
);

final kTextSyleWhite = TextStyle(
  color: Color(0xFFFFFFFF),
  letterSpacing: 1.5,
  fontSize: 11.0,
  fontWeight: FontWeight.normal,
  fontFamily: 'OpenSans',
);

final kTextSyleBlack = TextStyle(
  color: Color(0xA0000000),
  letterSpacing: 1.5,
  fontSize: 11.0,
  fontWeight: FontWeight.normal,
  fontFamily: 'OpenSans',
);

final kTextSyleRed = TextStyle(
  color: Colors.red,
  letterSpacing: 1.5,
  fontSize: 11.0,
  fontWeight: FontWeight.normal,
  fontFamily: 'OpenSans',
);

final kTextSyleTransparent = TextStyle(
  color: Colors.transparent,
  letterSpacing: 1.5,
  fontSize: 11.0,
  fontWeight: FontWeight.normal,
  fontFamily: 'OpenSans',
);

final kTextSyleGreyTitle = TextStyle(
  color: Color(0xAAAAAAAA),
  letterSpacing: 1.5,
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyleColumn = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);


final layoutLogin =   Container(
  height: double.infinity,
  width: double.infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF73AEF5),
        Color(0xFF61A4F1),
        Color(0xFF478DE0),
        Color(0xFF398AE5),
      ],
      stops: [0.1, 0.4, 0.7, 0.9],
    ),
  ),
);


