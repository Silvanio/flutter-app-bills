import 'package:myutility/app/models/contract_detail_model.dart';
import 'package:myutility/app/models/contract_model.dart';
import 'package:myutility/app/models/input/client_input.dart';
import 'package:myutility/app/services/service_locator.dart';
import 'package:myutility/utils/Constants.dart' as Constants;
import 'package:myutility/utils/convert.dart';
import 'package:myutility/utils/rest_api.dart';
import 'package:flutter/services.dart' show rootBundle;


class ContractService {

  Future<List<ContractModel>> listContracts(String token) async{
    Resource<List<ContractModel>> resource = Resource(
        url: Constants.api_all_contracts,
        parse: (response) {
          Iterable list = MyConvert.jsonParse(response.bodyBytes);
          return list.map((model) => ContractModel.fromJson(model)).toList();
        });

    Map<String, String> headers = {"token": token};

    String response = await rootBundle.loadString("assets/json/contracts.json");
    Iterable list = MyConvert.jsonParseString(response);
    return list.map((model) => ContractModel.fromJson(model)).toList();
    
    return getIt<RestAPI>().put(resource, headers: headers);
  }

  Future<ContractDetailModel> getContractDetail(String token, ClientInput input) async{
    Resource<ContractDetailModel> resource = Resource(
        url: Constants.api_contracts_detail,
        parse: (response) {
          Map model = MyConvert.jsonParse(response.bodyBytes);
          return ContractDetailModel.fromJson(model);
        });

    Map<String, dynamic> body = input.toMap();
    Map<String, String> headers = {"Content-Type": "application/json","token": token};


    String response = await rootBundle.loadString("assets/json/contract_detail.json");
   Map<String, dynamic> data = MyConvert.jsonParseString(response);
    return ContractDetailModel.fromJson(data);

    return getIt<RestAPI>().putWithBody(resource, body, headers: headers);
  }

}
