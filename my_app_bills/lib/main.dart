import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myAppBills/app/pages/contracts/contracts_detail.dart';
import 'package:myAppBills/app/pages/contracts/contracts_list.dart';
import 'package:myAppBills/app/pages/home/home.dart';
import 'package:myAppBills/app/pages/home/welcome.dart';
import 'package:myAppBills/app/pages/login/login.dart';
import 'package:myAppBills/app/services/service_locator.dart';
import 'package:myAppBills/splash_screen.dart';
import 'package:myAppBills/generated/l10n.dart';

import 'app/pages/settings/settings.dart';

var routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => Login(),
  "/home": (BuildContext context) => Home(),
  "/welcome": (BuildContext context) => Welcome(),
  "/contract_detail": (BuildContext context) => ContractsDetail(),
  "/contract_list": (BuildContext context) => ContractsList(),
  "/settings": (BuildContext context) => Settings()
};

void main() {
  setup();
  Platform.isIOS ? runApp(MyAppIOS()) : runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "myAppBills",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: routes,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

class MyAppIOS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "myAppBills",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: routes,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
