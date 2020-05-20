import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:myAppBills/utils/my_exception.dart';

class Resource<T> {
  final String url;
  T Function(Response response) parse;
  Resource({this.url, this.parse});
}

class RestAPI {
  Future<T> get<T>(Resource<T> resource, {headers}) async {
    final response = await http.get(resource.url, headers: headers);
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || response == null) {
      String jsonError = response.headers["fault"];
      print("######################## CODE ERRO: "+ statusCode.toString());
      if(jsonError != null){
        print("######################## ERRO: "+ jsonError);
      }      throw new MyException(code: response.statusCode, message: jsonError);
    }
    return resource.parse(response);
  }

  Future<T>  put<T>(Resource<T> resource, {Map headers, body, encoding}) async {
    return http.put(resource.url, body: body, headers: headers, encoding: encoding).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || res == null) {
        String jsonError = response.headers["fault"];
        print("######################## CODE ERRO: "+ statusCode.toString());
        if(jsonError != null){
          print("######################## ERRO: "+ jsonError);
        }
        throw new MyException(code: response.statusCode, message: jsonError);
      }
      return resource.parse(response);
    });
  }


  Future<T> post<T>(Resource<T> resource, putBody,{Map headers}) async {
    return http.post(resource.url, body: json.encode(putBody), headers: headers, encoding: Utf8Codec()).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || res == null) {
        String jsonError = response.headers["fault"];
        print("######################## CODE ERRO: "+ statusCode.toString());
        if(jsonError != null){
          print("######################## ERRO: "+ jsonError);
        }
        throw new MyException(code: response.statusCode, message: jsonError);
      }
      return resource.parse(response);
    });
  }


  Future<T>  putWithBody<T>(Resource<T> resource, putBody,{Map headers}) async {
    return http.put(resource.url, body: json.encode(putBody), headers: headers, encoding: Utf8Codec()).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || res == null) {
        String jsonError = response.headers["fault"];
        print("######################## CODE ERRO: "+ statusCode.toString());
        if(jsonError != null){
          print("######################## ERRO: "+ jsonError);
        }
        throw new MyException(code: response.statusCode, message: jsonError);
      }
      return resource.parse(response);
    });
  }

}
