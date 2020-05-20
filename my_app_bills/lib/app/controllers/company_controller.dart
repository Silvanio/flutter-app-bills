import 'package:myAppBills/app/models/company_model.dart';
import 'package:myAppBills/app/services/company_service.dart';
import 'package:myAppBills/app/services/service_locator.dart';

class CompanyController {
  static CompanyModel currentCompany;

  Future<CompanyModel> getCompanyInfoFromService() async {
    currentCompany = await getIt<CompanyService>().getCompanyInfoFromService();
    return currentCompany;
  }
}
