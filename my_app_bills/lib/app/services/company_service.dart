import 'package:flutter/services.dart' show rootBundle;
import 'package:myAppBills/app/models/company_model.dart';
import 'package:myAppBills/utils/convert.dart';

class CompanyService {
  Future<CompanyModel> getCompanyInfoFromService() async {
    String response = await rootBundle.loadString("assets/json/companies_info.json");
    Map<String, dynamic> data = MyConvert.jsonParseString(response);
    return CompanyModel.fromJson(data);
  }
}
