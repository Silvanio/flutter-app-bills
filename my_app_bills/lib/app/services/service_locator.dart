import 'package:get_it/get_it.dart';
import 'package:myutility/app/services/reading_service.dart';
import 'package:myutility/utils/rest_api.dart';
import 'package:myutility/app/services/company_service.dart';
import 'package:myutility/app/services/login_service.dart';
import 'package:myutility/app/services/contract_service.dart';
import 'package:myutility/app/services/invoice_service.dart';
import 'package:myutility/app/services/meters_service.dart';
import 'package:myutility/app/services/consumption_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<RestAPI>(RestAPI());
  getIt.registerSingleton<CompanyService>(CompanyService());
  getIt.registerSingleton<LoginService>(LoginService());
  getIt.registerSingleton<ContractService>(ContractService());
  getIt.registerSingleton<InvoiceService>(InvoiceService());
  getIt.registerSingleton<MetersService>(MetersService());
  getIt.registerSingleton<ConsumptionService>(ConsumptionService());
  getIt.registerSingleton<ReadingService>(ReadingService());
}


