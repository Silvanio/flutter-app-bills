import 'package:myutility/app/models/company_model.dart';
import 'package:myutility/app/models/consumption_model.dart';
import 'package:myutility/app/models/contract_detail_model.dart';
import 'package:myutility/app/models/contract_model.dart';
import 'package:myutility/app/models/input/client_input.dart';
import 'package:myutility/app/models/input/consumption_input.dart';
import 'package:myutility/app/models/input/invoice_input.dart';
import 'package:myutility/app/models/invoice_model.dart';
import 'package:myutility/app/models/login_model.dart';
import 'package:myutility/app/models/meters_model.dart';
import 'package:myutility/app/services/contract_service.dart';
import 'package:myutility/app/services/invoice_service.dart';
import 'package:myutility/app/services/login_service.dart';
import 'package:myutility/app/services/meters_service.dart';
import 'package:myutility/app/services/consumption_service.dart';
import 'package:myutility/app/services/company_service.dart';
import 'package:myutility/app/services/service_locator.dart';
import 'package:myutility/utils/convert.dart';

class HomeController {
  LoginModel _loginModel;
  ContractDetailModel _contractDetailModel;
  List<ContractDetailModel> _contractDetailModelList;
  CompanyModel _companyModel;
  CompanyContactModel _companyContactModel;
  String _currency, _welcomeMsg, _legalWarning;

  HomeController() {
    _loginModel = new LoginModel(company: "");
  }

  Future<LoginModel> getLoginBD() {
    return getIt<LoginService>().getLoginBD();
  }

  Future<void> getCompanyBD() async {
    _companyModel = await getIt<CompanyService>().getCompanyBD();
  }

  Future<void> getCompanyContactBD() async {
    _companyContactModel = await getIt<CompanyService>().getCompanyContactBD();
  }

  Future<dynamic> getCompanyCurrency() async {
    _currency = await getIt<CompanyService>().getCompanyCurrency();
  }

  Future<dynamic> getWelcomeMsgByLang() async {
    _welcomeMsg = await getIt<CompanyService>().getWelcomeMsgByLang();
  }

  Future<dynamic> getLegalWarningByLang() async {
    _legalWarning = await getIt<CompanyService>().getLegalWarningByLang();
  }

  Future<void> logout() {
    return getIt<LoginService>().deleteAll();
  }

  Future<List<ContractModel>> listContracts() {
    return getIt<ContractService>().listContracts(_loginModel.token);
  }

  Future<ContractDetailModel> getContractDetail(ContractModel model) async {
    ClientInput input = new ClientInput(clientNumber: model.clientNumber, accountNumber: model.accountNumber, cil: model.cil);
    return await getIt<ContractService>().getContractDetail(_loginModel.token, input);
  }

  Future<List<MetersModel>> getMetersList() {
    ClientInput input = new ClientInput(
        clientNumber: _contractDetailModel.contract.clientNumber,
        accountNumber: _contractDetailModel.contract.accountNumber,
        cil: _contractDetailModel.contract.cil);
    return getIt<MetersService>().getMetersList(_loginModel.token, input);
  }

  Future<InvoiceModel> getLastInvoice() async {
    InvoiceInput invoiceInput = InvoiceInput(
        ascending: "false",
        firstIndex: "0",
        numberOfElements: "1",
        orderByColumn: "1",
        token: _loginModel.token,
        client: ClientInput(
            clientNumber: _contractDetailModel.contract.clientNumber,
            accountNumber: _contractDetailModel.contract.accountNumber,
            cil: _contractDetailModel.contract.cil));

    List<InvoiceModel> invoiceList = await getIt<InvoiceService>().getInvoices(invoiceInput);

    if (invoiceList == null || invoiceList.isEmpty) {
      return null;
    }

    return invoiceList.first;
  }

  LoginModel get getLoginModel => _loginModel;

  ContractDetailModel get getContractDetailModel => _contractDetailModel;

  CompanyModel get getCompanyModel => _companyModel;

  CompanyContactModel get getCompanyContactModel => _companyContactModel;

  List<ContractDetailModel> get getContractDetailModelList => _contractDetailModelList;

  String get getCurrency => _currency;

  String get getWelcomeMsg => _welcomeMsg;

  String get getLegalWarning => _legalWarning;

  set setLoginModel(value) => _loginModel = value;

  set setContractDetailModel(value) => _contractDetailModel = value;

  set setCompanyModel(value) => _companyModel = value;

  set setCompanyContactModel(value) => _companyContactModel = value;

  set setContractDetailModelList(List<ContractDetailModel> value) => _contractDetailModelList = value;

  set setCurrency(String value) => _currency = value;
}
