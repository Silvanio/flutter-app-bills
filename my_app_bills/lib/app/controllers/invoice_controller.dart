import 'package:myAppBills/app/models/contract_detail_model.dart';
import 'package:myAppBills/app/models/contract_model.dart';
import 'package:myAppBills/app/models/input/client_input.dart';
import 'package:myAppBills/app/models/input/invoice_input.dart';
import 'package:myAppBills/app/models/invoice_model.dart';
import 'package:myAppBills/app/models/login_model.dart';
import 'package:myAppBills/app/services/invoice_service.dart';
import 'package:myAppBills/app/services/service_locator.dart';

class InvoiceController {
  ContractDetailModel _contractDetailModel;
  LoginModel _loginModel;
  InvoiceModel _invoiceModel;
  String _currency;

  Future<List<InvoiceModel>> getAPIInvoices(int numberOfElements) {
    ContractModel contract = _contractDetailModel.contract;
    InvoiceInput invoiceInput = InvoiceInput(
        ascending: "false",
        firstIndex: "0",
        numberOfElements: numberOfElements.toString(),
        orderByColumn: "1",
        token: _loginModel.token,
        client: ClientInput(clientNumber: contract.clientNumber, accountNumber: contract.accountNumber, cil: contract.cil));

    return getIt<InvoiceService>().getInvoices(invoiceInput);
  }


  ContractDetailModel get getContractDetailModel => _contractDetailModel;

  LoginModel get getLoginModel => _loginModel;

  InvoiceModel get getInvoiceModel => _invoiceModel;

  String get getCurrency => _currency;

  set setLoginModel(value) => _loginModel = value;

  set setContractDetailModel(value) => _contractDetailModel = value;

  set setInvoiceModel(value) => _invoiceModel = value;

  set setCurrency(String value) => _currency = value;
}
