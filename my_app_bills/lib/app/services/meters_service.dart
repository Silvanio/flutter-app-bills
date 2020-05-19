import 'package:myutility/app/models/input/client_input.dart';
import 'package:myutility/app/models/meters_model.dart';
import 'package:myutility/utils/Constants.dart' as Constants;
import 'package:myutility/utils/convert.dart';
import 'package:myutility/utils/rest_api.dart';
import 'package:myutility/app/services/service_locator.dart';

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
