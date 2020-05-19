import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myutility/app/controllers/login_controller.dart';
import 'package:myutility/app/controllers/company_controller.dart';
import 'package:myutility/app/models/company_model.dart';
import 'package:myutility/app/models/login_model.dart';
import 'package:myutility/my_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginController loginController;
  CompanyController companyController;
  Uint8List _ImageLogo;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _currLang;

  @override
  void initState() {
    super.initState();

    _prefs.then((SharedPreferences prefs) {
      _currLang = (prefs.getString('currLang') ?? Intl.getCurrentLocale());
    });

    companyController = new CompanyController();
    companyController.getCompanyInfoFromService().then((companyModel) => {_processCompanyData(companyModel)});

    loginController = new LoginController();
    loginController.getLoginBD().then((loginModel) => {_processLogin(loginModel)});
  }

  void _processCompanyData(CompanyModel companyModel) async {
    if (companyModel != null) {
      setState(() {
        _ImageLogo = base64Decode(companyModel.companyLogo);
      });

      _refreshCompanyInfo(companyModel);
    }
  }

  /// renovar os dados da empresa aquando da nova inicializacao da app
  void _refreshCompanyInfo(CompanyModel companyModel) {
    companyController.deleteAllCompany();
    companyController.deleteAllCompanyContact();
    companyController.deleteAllCompanyLegalWarning();

    companyController.saveCompany(companyModel);
    for (int i = 0; i < companyModel.companyInfo.length; i++) {
      companyController.saveCompanyContact(companyModel.companyInfo[i]);
    }
    for (int i = 0; i < companyModel.companyLegalWarning.length; i++) {
      companyController.saveCompanyLegalWarning(companyModel.companyLegalWarning[i]);
    }
  }

  void _processLogin(LoginModel loginModel) async {
    if (loginModel != null && loginModel.remember) {
      await loginController.deleteUser();
      loginController.setLoginModel = loginModel;
      loginController.executeLogin().then((ok) => MyNavigator.goToWelcome(context)).catchError((e) {
        Timer(Duration(seconds: 3), () => MyNavigator.goToLogin(context));
      });
    } else {
      Timer(Duration(seconds: 3), () => MyNavigator.goToLogin(context));
    }
    S.load(Locale(_currLang)); // iniciar com a linguagem guardada, se houver uma
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: new Container(),
        )
      ],
    );

    double absoluteHeight = MediaQuery.of(context).size.height - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 40.0,
                ),
                height: absoluteHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    //Image(image: AssetImage('assets/images/logo_1_2.png'), width: 200),
                    _ImageLogo != null ? Image.memory(_ImageLogo, width: 220, alignment: Alignment.center) : new Container()
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/login_background.png"), fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
