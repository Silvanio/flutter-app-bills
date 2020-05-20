import 'package:myAppBills/app/controllers/company_controller.dart';
import 'package:myAppBills/app/models/consumption_model.dart';
import 'package:myAppBills/app/models/contract_detail_model.dart';
import 'package:myAppBills/app/models/input/client_input.dart';
import 'package:myAppBills/app/models/input/consumption_input.dart';
import 'package:myAppBills/app/models/input/invoice_input.dart';
import 'package:myAppBills/app/models/invoice_model.dart';
import 'package:myAppBills/app/models/login_model.dart';
import 'package:myAppBills/app/models/meters_model.dart';
import 'package:myAppBills/app/pages/dashbord/chart_trend_consumption.dart';
import 'package:myAppBills/app/services/consumption_service.dart';
import 'package:myAppBills/app/services/invoice_service.dart';
import 'package:myAppBills/app/services/service_locator.dart';
import 'package:myAppBills/utils/convert.dart';
import 'package:myAppBills/utils/type_unit.dart';

class ConsumptionController {
  LoginModel _loginModel;
  ContractDetailModel _contractDetailModel;
  MetersModel _metersModel;

  Future<List<Chart>> buildDataChartConsumption(int month) async {
    int countStartPage = 0;
    int countPageInvoices = month;

    List<Chart> chartList = new List<Chart>();

    String currency = CompanyController.currentCompany.currency;
    List<ConsumptionModel> consumptionList = await getConsumptionCountMonth(month);
    if (consumptionList != null && consumptionList.isNotEmpty) {
      countPageInvoices = consumptionList.length > month ? consumptionList.length : month;
      List<InvoiceModel> invoiceList = await getAllPaymentsBy(
          consumptionList.last.invoiceDate, countStartPage.toString(), countPageInvoices.toString());
      if ((consumptionList != null && consumptionList.isNotEmpty) && (invoiceList != null && invoiceList.isNotEmpty)) {
        List<ChartLine> lineConsumptionList = mountConsumptionLine(consumptionList);
        List<ChartLine> lineInvoiceList = mountInvoiceLine(invoiceList, currency);
        chartList = mountTrend(lineConsumptionList, lineInvoiceList);
        calculateLineSize(chartList);
      }
    }

    return chartList;
  }

  void calculateLineSize(List<Chart> trendList) {
    double higherInvoice = 0.0;
    double higherConsumption = 0.0;
    for (Chart chart in trendList) {
      if (chart.lineInvoice.value > higherInvoice) {
        higherInvoice = chart.lineInvoice.value.roundToDouble();
      }
      if (chart.lineConsumption.value > higherConsumption) {
        higherConsumption = chart.lineConsumption.value.roundToDouble();
      }
    }
    for (Chart chart in trendList) {
      int percentageInvoice = chart.lineInvoice.value.toInt() * 100;
      chart.lineInvoice.percentageValue = percentageInvoice ~/ higherInvoice;

      int percentageConsumption = chart.lineConsumption.value.toInt() * 100;
      chart.lineConsumption.percentageValue = percentageConsumption ~/ higherConsumption;
    }
  }

  List<Chart> mountTrend(List<ChartLine> lineConsumptionList, List<ChartLine> lineInvoiceList) {
    List<Chart> trendList = new List<Chart>();

    Map<String, ChartLine> groupConsumption = groupTrendLineByMonth(lineConsumptionList);
    Map<String, ChartLine> groupInvoices = groupTrendLineByMonth(lineInvoiceList);

    List<String> monthYearList = groupConsumption.keys.toList();

    for (String monthYear in monthYearList) {
      ChartLine lineConsumption = groupConsumption[monthYear];
      ChartLine lineInvoice = groupInvoices[monthYear];

      Chart trend = new Chart();
      trend.date = lineConsumption.date;
      trend.lineConsumption = lineConsumption;
      trend.lineInvoice = lineInvoice;

      if (lineInvoice != null) {
        trendList.add(trend);
      }
    }

    if (trendList.isNotEmpty) {
      trendList.sort((b, a) => -a.date.compareTo(b.date));
    }
    return trendList;
  }

  ///Metodo responsavel por agrupar e somar  as faturas do mesmo mes de acordo com o mes do consumo.
  Map<String, ChartLine> groupTrendLineByMonth(List<ChartLine> trendLine) {
    Map<String, ChartLine> group = new Map<String, ChartLine>();
    for (ChartLine item in trendLine) {
      String monthYear = MyConvert.formatDatePattern(item.date, "MM/yyyy");

      if (group.containsKey(monthYear)) {
        ChartLine itemOld = group[monthYear];
        item.value = itemOld.value + item.value;
        group.update(monthYear, (existingValue) => item, ifAbsent: () => item);
      } else {
        group.putIfAbsent(monthYear, () => item);
      }
    }
    return group;
  }

  List<ChartLine> mountConsumptionLine(List<ConsumptionModel> consumptionList) {
    List<ChartLine> lineConsumptionList = new List<ChartLine>();

    for (ConsumptionModel consumption in consumptionList) {
      ChartLine lineConsumption = new ChartLine();
      lineConsumption.date = consumption.invoiceDate;
      lineConsumption.value = consumption.value;
      lineConsumption.suffixValue = TypeUnit.getUnit(_metersModel.unit);
      lineConsumption.suffixImage = TypeUnit.getIcon(_metersModel.unit);

      if (lineConsumption.value == null || lineConsumption.value < 0) {
        lineConsumption.value = 0.0;
      }

      lineConsumptionList.add(lineConsumption);
    }
    return lineConsumptionList;
  }

  List<ChartLine> mountInvoiceLine(List<InvoiceModel> invoiceList, String currency) {
    List<ChartLine> lineInvoiceList = new List<ChartLine>();
    for (InvoiceModel invoice in invoiceList) {
      ChartLine lineInvoice = new ChartLine();
      lineInvoice.date = invoice.issueDate;
      lineInvoice.value = invoice.paymentData.value;
      lineInvoice.suffixValue = currency;
      lineInvoiceList.add(lineInvoice);
      if (lineInvoice.value == null || lineInvoice.value.isNegative) {
        lineInvoice.value = 0.0;
      }
    }
    return lineInvoiceList;
  }

  Future<List<ConsumptionModel>> getConsumptionCountMonth(int countMonth) async {
    DateTime now = DateTime.now();
    DateTime start = new DateTime(now.year, now.month - countMonth, 1);

    ClientInput clientInput = new ClientInput(
        clientNumber: _contractDetailModel.contract.clientNumber,
        accountNumber: _contractDetailModel.contract.accountNumber,
        cil: _contractDetailModel.contract.cil);

    ConsumptionInput consumptionInput = new ConsumptionInput(
        client: clientInput,
        counterNumber: _metersModel.counterNumber,
        mark: _metersModel.markCode,
        productCode: _metersModel.productCode,
        token: _loginModel.token,
        endDate: MyConvert.formatDatePattern(now, "yyyy-MM-dd"),
        startDate: MyConvert.formatDatePattern(start, "yyyy-MM-dd"));

    List<ConsumptionModel> list =
        await getIt<ConsumptionService>().getConsumptionList(consumptionInput).catchError((error, stackTrace) {
      return null;
    });

    return list;
  }

  ///caso o ultimo mes do consumo for depois do invoice ira buscar outra lista de invoice.
  Future<List<InvoiceModel>> getAllPaymentsBy(DateTime lasConsumption, String startIndex, String finishIndex) async {
    DateTime monthYearConsumption = new DateTime(lasConsumption.year, lasConsumption.month, 1);
    List<InvoiceModel> invoiceList = await getInvoices(startIndex, finishIndex);
    if (invoiceList != null && invoiceList.isNotEmpty) {
      InvoiceModel last = invoiceList.first;
      DateTime lastDate = last.issueDate;
      DateTime monthYearInvoice = new DateTime(lastDate.year, lastDate.month, 1);
      if (monthYearInvoice.isBefore(monthYearConsumption)) {
        List<InvoiceModel> invoiceNewList = await getInvoices(finishIndex, finishIndex * 2);
        if (invoiceNewList != null && invoiceNewList.isNotEmpty) {
          invoiceList.addAll(invoiceNewList);
        }
      }
    }

    return invoiceList;
  }

  Future<List<InvoiceModel>> getInvoices(String startIndex, String numberOfElements) async {
    InvoiceInput invoiceInput = InvoiceInput(
        ascending: "false",
        firstIndex: startIndex,
        numberOfElements: numberOfElements,
        orderByColumn: "1",
        token: _loginModel.token,
        client: ClientInput(
            clientNumber: _contractDetailModel.contract.clientNumber,
            accountNumber: _contractDetailModel.contract.accountNumber,
            cil: _contractDetailModel.contract.cil));

    List<InvoiceModel> list = await getIt<InvoiceService>().getInvoices(invoiceInput).catchError((error, stackTrace) {
      return null;
    });

    return list;
  }

  LoginModel get getLoginModel => _loginModel;

  ContractDetailModel get getContractDetailModel => _contractDetailModel;

  MetersModel get getMetersModel => _metersModel;

  set setMetersModel(value) => _metersModel = value;

  set setLoginModel(value) => _loginModel = value;

  set setContractDetailModel(value) => _contractDetailModel = value;
}
