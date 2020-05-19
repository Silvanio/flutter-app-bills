import 'package:flutter/material.dart';
import 'package:myutility/app/models/company_model.dart';
import 'package:myutility/app/models/login_model.dart';
import 'package:myutility/app/services/company_service.dart';
import 'package:myutility/app/services/login_service.dart';
import 'package:myutility/app/services/service_locator.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();

  LoginModel _loginModel;
  CompanyModel _companyModel;

  List<CompanyModel> _companyList;

  LoginController() {
    _loginModel = new LoginModel(remember: true, company: "");
    //_companyList = new List<CompanyModel>();
  }

  Future<List<CompanyModel>> listAllCompany() {
    return getIt<CompanyService>().listAllCompany();
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

  //List<CompanyModel> get getCompanyList => _companyList;

  LoginModel get getLoginModel => _loginModel;

  CompanyModel get getCompanyModel => _companyModel;

  /*set setCompanyList(List<CompanyModel> value) {
    _companyList = value;
  }*/

  set setLoginModel(LoginModel value) {
    _loginModel = value;
  }

  set setCompanyModel(CompanyModel value) {
    _companyModel = value;
  }
}
