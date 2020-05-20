import 'package:myAppBills/app/models/consumption_model.dart';
import 'package:myAppBills/app/models/input/consumption_input.dart';
import 'package:myAppBills/app/services/service_locator.dart';
import 'package:myAppBills/utils/convert.dart';
import 'package:myAppBills/utils/rest_api.dart';
import 'package:myAppBills/utils/Constants.dart' as Constants;
import 'package:flutter/services.dart' show rootBundle;



class ConsumptionService {
  Future<List<ConsumptionModel>> getConsumptionList(ConsumptionInput input)  {
    Resource<List<ConsumptionModel>> resource = Resource(
        url: Constants.api_get_consumption,
        parse: (response) {
          Iterable list = MyConvert.jsonParse(response.bodyBytes);
          return list.map((model) => ConsumptionModel.fromJson(model)).toList();
        });

    Map<String, dynamic> body = input.toMap();
    Map<String, String> headers = {"Content-Type": "application/json", "token": input.token};



    return Future.delayed(Duration(seconds: 0)).then((value) async{
      String response = await rootBundle.loadString("assets/json/history_consumption.json");
      Iterable list = MyConvert.jsonParseString(response);
      return list.map((model) => ConsumptionModel.fromJson(model)).toList();
    });

    return getIt<RestAPI>().putWithBody(resource, body, headers: headers);
  }
}
