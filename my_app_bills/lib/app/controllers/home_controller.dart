import 'package:myAppBills/app/models/contract_detail_model.dart';
import 'package:myAppBills/app/models/contract_model.dart';
import 'package:myAppBills/app/models/input/client_input.dart';
import 'package:myAppBills/app/models/input/invoice_input.dart';
import 'package:myAppBills/app/models/invoice_model.dart';
import 'package:myAppBills/app/models/login_model.dart';
import 'package:myAppBills/app/models/meters_model.dart';
import 'package:myAppBills/app/services/contract_service.dart';
import 'package:myAppBills/app/services/invoice_service.dart';
import 'package:myAppBills/app/services/login_service.dart';
import 'package:myAppBills/app/services/meters_service.dart';
import 'package:myAppBills/app/services/service_locator.dart';

class HomeController {
  LoginModel _loginModel;
  ContractDetailModel _contractDetailModel;
  List<ContractDetailModel> _contractDetailModelList;

  HomeController() {
    _loginModel = new LoginModel(company: "");
  }

  Future<LoginModel> getLoginBD() {
    return getIt<LoginService>().getLoginBD();
  }

  Future<void> logout() {
    return getIt<LoginService>().deleteAll();
  }

  Future<List<ContractModel>> listContracts() {
    return getIt<ContractService>().listContracts(_loginModel.token);
  }

  Future<ContractDetailModel> getContractDetail(ContractModel model) async {
    ClientInput input =
        new ClientInput(clientNumber: model.clientNumber, accountNumber: model.accountNumber, cil: model.cil);
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

  List<ContractDetailModel> get getContractDetailModelList => _contractDetailModelList;

  set setLoginModel(value) => _loginModel = value;

  set setContractDetailModel(value) => _contractDetailModel = value;

  set setContractDetailModelList(List<ContractDetailModel> value) => _contractDetailModelList = value;
}
