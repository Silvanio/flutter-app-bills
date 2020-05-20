import 'package:myAppBills/app/models/login_model.dart';
import 'package:myAppBills/utils/Constants.dart' as Constants;
import 'package:myAppBills/utils/db_helper.dart';
import 'package:myAppBills/utils/my_exception.dart';
import 'package:myAppBills/utils/rest_api.dart';
import 'package:myAppBills/app/services/service_locator.dart';

class LoginService {

  Future<String> login(LoginModel loginModel) {
    Resource<String> resource = Resource(
        url: Constants.api_auth,
        parse: (response) {
          Map<String, String> headers = response.headers;
          String token = headers['token'];
          if (token == null) {
               throw new MyException(code: 1, message: "Token error");
          }
          return token;
        });

    Map<String, String> headers = {
      "username": loginModel.username,
      "password": loginModel.password,
      //"company_id": loginModel.companyId.toString()
      "company_id" : Constants.api_companyid
    };

   return Future.delayed(Duration(seconds: 0)).then((value) {
      return "123";
    });
    return getIt<RestAPI>().get(resource, headers: headers);
  }

  Future<int> save(LoginModel login) async {
    var dbClient = await DbHelper.internal().db;
    int res = await dbClient.insert(LoginModel.nameTable, login.toMap());
    return res;
  }

  Future<void> deleteAll() async {
    var dbClient = await DbHelper.internal().db;
    dbClient.delete(LoginModel.nameTable);
  }

  Future<LoginModel> getLoginBD() async {
    var db = await DbHelper.internal().db;
    List<Map<String, dynamic>> records = await db.query(LoginModel.nameTable);
    if(records.isEmpty){
      return null;
    }
    return  LoginModel.fromJson(records.first);
  }
}
