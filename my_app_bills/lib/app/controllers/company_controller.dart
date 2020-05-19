import 'package:myutility/app/models/company_model.dart';
import 'package:myutility/app/services/company_service.dart';
import 'package:myutility/app/services/service_locator.dart';

class CompanyController {

  String _gdprMarketing, _gdprThirdParty;


  /// serviço
  Future<CompanyModel> getCompanyInfoFromService() {
    return getIt<CompanyService>().getCompanyInfoFromService();
  }

  /// info da empresa (logos, currency, aviso legal)
  Future<CompanyModel> getCompanyBD() {
    return getIt<CompanyService>().getCompanyBD();
  }

  Future<void> deleteAllCompany() {
    return getIt<CompanyService>().deleteAllCompany();
  }

  void saveCompany(CompanyModel companyModel) {
    getIt<CompanyService>().saveCompany(companyModel).then((res) => {print(res)});
  }

  Future<dynamic> getCompanyCurrency() {
    return getIt<CompanyService>().getCompanyCurrency();
  }

  /// info da empresa (contactos)
  Future<CompanyContactModel> getCompanyContactBD() {
    return getIt<CompanyService>().getCompanyContactBD();
  }

  /// info da empresa (contactos), a lista inteira
  Future<List<CompanyContactModel>> getCompanyContactListBD() {
    return getIt<CompanyService>().getCompanyContactListBD();
  }

  Future<void> deleteAllCompanyContact() {
    return getIt<CompanyService>().deleteAllCompanyContact();
  }

  void saveCompanyContact(CompanyContactModel companyInfoModel) {
    getIt<CompanyService>().saveCompanyContact(companyInfoModel).then((res) => {print(res)});
  }

  /// info da empresa (legalWarning, welcomeMsg, gdprMarketing, gdprThirdParty)

  Future<void> deleteAllCompanyLegalWarning() {
    return getIt<CompanyService>().deleteAllCompanyLegalWarning();
  }

  void saveCompanyLegalWarning(CompanyLegalWarningModel companyLegalWarningModel) {
    getIt<CompanyService>().saveCompanyLegalWarning(companyLegalWarningModel).then((res) => {print(res)});
  }

  Future<dynamic> getGdprMarketingText() async {
    _gdprMarketing = await getIt<CompanyService>().getGdrpMarketingText();
  }

  Future<dynamic> getGdprThirdPartyText() async {
    _gdprThirdParty = await getIt<CompanyService>().getGdrpThirdPartyText();
  }


  String get getgdprMarketing => _gdprMarketing;
  String get getgdprThirdParty => _gdprThirdParty;

}
