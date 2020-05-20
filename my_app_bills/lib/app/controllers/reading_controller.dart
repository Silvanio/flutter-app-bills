import 'package:flutter/cupertino.dart';
import 'package:myAppBills/app/models/contract_detail_model.dart';
import 'package:myAppBills/app/models/contract_model.dart';
import 'package:myAppBills/app/models/input/client_input.dart';
import 'package:myAppBills/app/models/input/reading_input.dart';
import 'package:myAppBills/app/models/login_model.dart';
import 'package:myAppBills/app/models/meters_model.dart';
import 'package:myAppBills/app/models/reading_model.dart';
import 'package:myAppBills/app/models/send_reading_model.dart';
import 'package:myAppBills/app/services/login_service.dart';
import 'package:myAppBills/app/services/meters_service.dart';
import 'package:myAppBills/app/services/reading_service.dart';
import 'package:myAppBills/app/services/service_locator.dart';
import 'package:myAppBills/utils/constants.dart';
import 'package:myAppBills/utils/convert.dart';

class ReadingController {
  LoginModel _loginModel;
  ContractDetailModel _contractDetailModel;
  MetersModel _metersModel;
  SendReadingModel sendReadingModel;
  String reading;
  String initialDate;
  String finalDate;
  final formKey = GlobalKey<FormState>();
  List<ReadingModel> readingModelList;

  ReadingController(){
    this.initialDate = "22";
    this.finalDate = "24";
  }

  initReadingValues(MetersModel metersModel){
    readingModelList = new List<ReadingModel>();
    for(MetersFunctions function in metersModel.functions){
      ReadingModel model = new ReadingModel();
      model.source = "R";
      model.estimate = false;
      model.readingDate = DateTime.now();
      model.functionCode = function.functionCode;
      model.function = function;
      model.value = 0.0;
     readingModelList.add(model);
    }
  }


  bool validSendReadingValue() {
    bool warning = false;
      for(ReadingModel reading in readingModelList){
        double minReading = reading.function.minReading;
        double maxReading = reading.function.maxReading;
        warning = reading.value < minReading || reading.value > maxReading;
      }
      return warning;
  }

  bool validSendReadingDate() {
    bool warning = false;
    for(ReadingModel reading in readingModelList){
      DateTime now = DateTime.now();
      String day = MyConvert.formatDatePattern(now, "dd");
      int dayInt = MyConvert.parseInt(day, 0);
      int initial = MyConvert.parseInt(initialDate, 0);
      int fim = MyConvert.parseInt(finalDate, 0);
      warning = dayInt < initial || dayInt > fim;
    }
    return warning;
  }

  void getLoginBD() async {
    readingModelList = new List<ReadingModel>();
    _loginModel = await getIt<LoginService>().getLoginBD();
  }

  Future<bool> sendReading() async {
    ContractModel contract = _contractDetailModel.contract;
    sendReadingModel = new SendReadingModel();
    sendReadingModel.token = _loginModel.token;
    sendReadingModel.client = new ClientInput();
    sendReadingModel.client.cil = contract.cil;
    sendReadingModel.client.accountNumber = contract.accountNumber;
    sendReadingModel.client.clientNumber = contract.clientNumber;

    CountersReadings counter = new CountersReadings();
    counter.productCode = _metersModel.productCode;
    counter.counterNumber = _metersModel.counterNumber;
    counter.mark = _metersModel.markCode;
    counter.sourceCode = nameApp;
    counter.readings = readingModelList;

    sendReadingModel.countersReadings = new List<CountersReadings>();
    sendReadingModel.countersReadings.add(counter);

    return await getIt<ReadingService>().sendReading(sendReadingModel);
  }

  Future<List<MetersModel>> listAllMeters() {
    ContractModel contract = _contractDetailModel.contract;
    ClientInput input = new ClientInput(clientNumber: contract.clientNumber, accountNumber: contract.accountNumber, cil: contract.cil);
    return getIt<MetersService>().getMetersList(_loginModel.token, input);
  }

  Future<List<ReadingModel>> listReadings(int countMonth) {
    return listReadingsByMeters(countMonth, _metersModel);
  }

  Future<List<ReadingModel>> listReadingsByMeters(int countMonth, MetersModel modelMeters) {
    ContractModel contract = _contractDetailModel.contract;
    DateTime now = DateTime.now();
    countMonth = countMonth -1;
    DateTime start = new DateTime(now.year, now.month - countMonth, 1);

    ClientInput clientInput = new ClientInput(clientNumber: contract.clientNumber, accountNumber: contract.accountNumber, cil: contract.cil);

    ReadingInput input = new ReadingInput(
        client: clientInput,
        counterNumber: modelMeters.counterNumber,
        mark: modelMeters.markCode,
        productCode: modelMeters.productCode,
        token: _loginModel.token,
        endDate: MyConvert.formatDatePattern(now, "yyyy-MM-dd"),
        startDate: MyConvert.formatDatePattern(start, "yyyy-MM-dd"));


    return getIt<ReadingService>().getReadingList(input);
  }

  LoginModel get getLoginModel => _loginModel;

  ContractDetailModel get getContractDetailModel => _contractDetailModel;

  MetersModel get getMetersModel => _metersModel;

  set setMetersModel(value) => _metersModel = value;

  set setLoginModel(value) => _loginModel = value;

  set setContractModel(value) => _contractDetailModel = value;
}
