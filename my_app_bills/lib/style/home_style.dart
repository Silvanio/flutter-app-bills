import 'package:flutter/material.dart';

final Color kDefaultColorHome = Color(0xFF398AE5);

final kHomeBoxDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kContractCard = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF398AE5),
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
);

final kCardBlueBox = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
     // Color(0xFF73AEF5),
      //Color(0xFF61A4F1),
     // Color(0xFF478DE0),
     // Color(0xFF398AE5),
      //Color(0xFF398AE5),
      Color(0xFF398AE5),
      Color(0xFF398AE5),
      Color(0xFF398AE5),
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
);

final kContractListBox = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      // Color(0xFF73AEF5),
      //Color(0xFF61A4F1),
      // Color(0xFF478DE0),
      // Color(0xFF398AE5),
      Color(0xFF398AE5),
      Color(0xFF398AE5),
      Color(0xFF398AE5),
      Color(0xFF398AE5),
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
    borderRadius: new BorderRadius.only(
      bottomLeft: const Radius.circular(5.0),
      bottomRight: const Radius.circular(5.0),
      topLeft: const Radius.circular(5.0),
      topRight: const Radius.circular(5.0),
    )
);

final kCardGreyBox = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      Colors.white70,
      Colors.grey,
      Colors.black12,
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
);