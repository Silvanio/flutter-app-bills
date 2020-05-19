import 'dart:core';

class LoginModel {
  static final String nameTable = "tb_login";
  static final String create =
      "CREATE TABLE tb_login(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, remember INTEGER, companyId companyId, company TEXT, token TEXT)";

  String username;
  String password;
  bool remember;
  int companyId;
  String company;
  String token;

  LoginModel({this.username, this.password, this.remember, this.companyId, this.token, this.company});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        username: json['username'],
        password: json['password'],
        remember: json['remember'] == 0 ? true: false,
        companyId: json['companyId'],
        company: json['company'],
        token: json['token'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    map["remember"] = remember ? 0: 1;
    map["companyId"] = companyId;
    map["company"] = company;
    map["token"] = token;
    return map;
  }

}
