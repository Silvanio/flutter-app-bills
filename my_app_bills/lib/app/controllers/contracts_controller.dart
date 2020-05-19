import 'package:myutility/app/models/contract_detail_model.dart';
import 'package:myutility/app/models/login_model.dart';
import 'package:myutility/app/services/login_service.dart';
import 'package:myutility/app/services/service_locator.dart';

class ContractsController {
  LoginModel _loginModel;
  ContractDetailModel _contractDetailModel;
  List<ContractDetailModel> _contractDetailModelList;

  void getLoginBD() async {
    _loginModel = await getIt<LoginService>().getLoginBD();
  }

  ContractDetailModel get getContractDetailModel => _contractDetailModel;

  List<ContractDetailModel> get getContractDetailModelList => _contractDetailModelList;

  LoginModel get getLoginModel => _loginModel;

  set setLoginModel(value) => _loginModel = value;

  set setContractDetailModel(value) => _contractDetailModel = value;

  set setContractDetailModelList(List<ContractDetailModel> value) => _contractDetailModelList = value;
}
