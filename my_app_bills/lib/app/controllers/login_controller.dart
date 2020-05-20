import 'package:flutter/material.dart';
import 'package:myAppBills/app/models/company_model.dart';
import 'package:myAppBills/app/models/login_model.dart';
import 'package:myAppBills/app/services/login_service.dart';
import 'package:myAppBills/app/services/service_locator.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();

  LoginModel _loginModel;
  CompanyModel _companyModel;

  LoginController() {
    _loginModel = new LoginModel(remember: true, company: "");
  }

  Future<void> executeLogin() {
    return getIt<LoginService>().login(_loginModel).then((token) => {_loginModel.token = token, save()});
  }

  Future<LoginModel> getLoginBD() {
    return getIt<LoginService>().getLoginBD();
  }

  Future<void> deleteUser() {
    return getIt<LoginService>().deleteAll();
  }

  void save() {
    getIt<LoginService>().save(_loginModel).then((res) => {print(res)});
  }

  LoginModel get getLoginModel => _loginModel;

  CompanyModel get getCompanyModel => _companyModel;

  set setLoginModel(LoginModel value) {
    _loginModel = value;
  }

  set setCompanyModel(CompanyModel value) {
    _companyModel = value;
  }
}
