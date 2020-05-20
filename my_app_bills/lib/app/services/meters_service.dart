import 'package:myAppBills/app/models/input/client_input.dart';
import 'package:myAppBills/app/models/meters_model.dart';
import 'package:myAppBills/utils/Constants.dart' as Constants;
import 'package:myAppBills/utils/convert.dart';
import 'package:myAppBills/utils/rest_api.dart';
import 'package:myAppBills/app/services/service_locator.dart';

import 'package:flutter/services.dart' show rootBundle;


class MetersService {

  Future<List<MetersModel>> getMetersList(String token, ClientInput input) async{
    Resource<List<MetersModel>> resource = Resource(
        url: Constants.api_get_meters,
        parse: (response) {
          Iterable list = MyConvert.jsonParse(response.bodyBytes);
          return list.map((model) => MetersModel.fromJson(model)).toList();
        });

    Map<String, dynamic> body = input.toMap();
    Map<String, String> headers = {"Content-Type": "application/json","token": token};

    String response = await rootBundle.loadString("assets/json/counters.json");
    Iterable list = MyConvert.jsonParseString(response);
    return list.map((model) => MetersModel.fromJson(model)).toList();

    return getIt<RestAPI>().putWithBody(resource,body,  headers: headers);
  }
}
