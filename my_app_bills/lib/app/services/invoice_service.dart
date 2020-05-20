import 'package:myAppBills/app/models/input/invoice_input.dart';
import 'package:myAppBills/app/models/invoice_model.dart';
import 'package:myAppBills/utils/Constants.dart' as Constants;
import 'package:myAppBills/utils/convert.dart';
import 'package:myAppBills/utils/rest_api.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myAppBills/app/services/service_locator.dart';



class InvoiceService {

  Future<List<InvoiceModel>> getInvoices(InvoiceInput input) async{
    Resource<List<InvoiceModel>> resource = Resource(
        url: Constants.api_get_client_doc,
        parse: (response) {
          Iterable list = MyConvert.jsonParse(response.bodyBytes);
          return list.map((model) => InvoiceModel.fromJson(model)).toList();
        });

    Map<String, dynamic> body = input.toMap();
    Map<String, String> headers = {"Content-Type": "application/json","token": input.token};

    return Future.delayed(Duration(seconds: 1)).then((value) async{
      String response = await rootBundle.loadString("assets/json/doc_faturas.json");
      Iterable list = MyConvert.jsonParseString(response);
      return list.map((model) => InvoiceModel.fromJson(model)).toList();
    });

    return getIt<RestAPI>().putWithBody(resource, body, headers: headers);
  }
}
