import 'package:get_it/get_it.dart';
import 'package:myAppBills/app/services/reading_service.dart';
import 'package:myAppBills/utils/rest_api.dart';
import 'package:myAppBills/app/services/company_service.dart';
import 'package:myAppBills/app/services/login_service.dart';
import 'package:myAppBills/app/services/contract_service.dart';
import 'package:myAppBills/app/services/invoice_service.dart';
import 'package:myAppBills/app/services/meters_service.dart';
import 'package:myAppBills/app/services/consumption_service.dart';

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


