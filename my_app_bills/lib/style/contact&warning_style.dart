import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final kBoxRoundShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0), boxShadow: [
  BoxShadow(
    offset: const Offset(0.0, 2.0),
    blurRadius: 1.0,
    spreadRadius: 1.0,
    color: Color(0xAAAAAAAA),
  ),
]);
