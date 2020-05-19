import 'dart:convert';

import 'package:myutility/app/models/input/reading_input.dart';
import 'package:myutility/app/models/reading_model.dart';
import 'package:myutility/app/models/send_reading_model.dart';
import 'package:myutility/app/services/service_locator.dart';
import 'package:myutility/utils/convert.dart';
import 'package:myutility/utils/rest_api.dart';
import 'package:myutility/utils/Constants.dart' as Constants;
import 'package:flutter/services.dart' show rootBundle;


class ReadingService {
  Future<List<ReadingModel>> getReadingList(ReadingInput input) async{
    Resource<List<ReadingModel>> resource = Resource(
        url: Constants.api_get_reading,
        parse: (response) {
          Iterable list = MyConvert.jsonParse(response.bodyBytes);
          return list.map((model) => ReadingModel.fromJson(model)).toList();
        });

    Map<String, dynamic> body = input.toMap();
    Map<String, String> headers = {"Content-Type": "application/json", "token": input.token};

    return Future.delayed(Duration(seconds: 1)).then((value) async{
      String response = await rootBundle.loadString("assets/json/history_reading.json");
      Iterable list = MyConvert.jsonParseString(response);
      return list.map((model) => ReadingModel.fromJson(model)).toList();
    });

    return getIt<RestAPI>().putWithBody(resource, body, headers: headers);
  }

  Future<bool> sendReading(SendReadingModel model) {
    Resource<bool> resource = Resource(
        url: Constants.api_send_reading,
        parse: (response) {
          return true;
        });
    Map<String, dynamic> body = model.toMap();
    Map<String, String> headers = {"Content-Type": "application/json", "token": model.token};
    return Future.delayed(Duration(seconds: 0)).then((value) {
      return true;
    });
    return getIt<RestAPI>().post(resource, body, headers: headers);
  }
}
