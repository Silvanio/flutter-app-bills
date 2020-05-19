import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myutility/app/controllers/consumption_controller.dart';
import 'package:myutility/app/controllers/home_controller.dart';
import 'package:myutility/app/controllers/reading_controller.dart';
import 'package:myutility/app/models/contract_detail_model.dart';
import 'package:myutility/app/models/invoice_model.dart';
import 'package:myutility/app/models/meters_model.dart';
import 'package:myutility/app/pages/dashbord/card_consumption.dart';
import 'package:myutility/app/pages/dashbord/card_invoice_paid.dart';
import 'package:myutility/app/pages/dashbord/card_invoice_unpaid.dart';
import 'package:myutility/app/pages/readings/card_reading_history.dart';

class DashBord extends StatefulWidget {
  final HomeController homeController;

  DashBord({this.homeController});

  @override
  _DashBordState createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  HomeController homeController;
  ContractDetailModel lastContract;

  StreamController<MetersModel> _eventsReadings;
  StreamController<MetersModel> _eventsConsumptions;
  StreamController<InvoiceModel> _eventsInvoicePaid;
  StreamController<InvoiceModel> _eventsInvoiceUnPaid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createStateDashBord();
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          _buildInvoiceUnPaid(),
          _buildConsumptionChart(),
          _buildInvoicePaid(),
          _buildReadingHistory()
          //_buildGridView()
        ],
      ),
    ));
  }

  void _createStateDashBord() {
    homeController = widget.homeController;
    if (_isRebuild()) {
      lastContract = homeController.getContractDetailModel;
      _eventsReadings = new StreamController<MetersModel>();
      _eventsConsumptions = new StreamController<MetersModel>();
      _eventsInvoicePaid = new StreamController<InvoiceModel>();
      _eventsInvoiceUnPaid = new StreamController<InvoiceModel>();
      homeController.getCompanyCurrency();
      _getMeters();
      _getInvoices();
    }
  }

  bool _isRebuild() {
    return (lastContract == null || homeController.getContractDetailModel.contract.cil != lastContract.contract.cil);
  }

  Widget _buildInvoiceUnPaid() {
    return StreamBuilder(
      stream: _eventsInvoiceUnPaid.stream,
      builder: (BuildContext context, snapshot) {
        return CardInvoiceUnPaid(invoiceModel: snapshot.data, currency: homeController.getCurrency);
      },
    );
  }

  Widget _buildInvoicePaid() {
    return StreamBuilder(
      stream: _eventsInvoicePaid.stream,
      builder: (BuildContext context, snapshot) {
        return CardInvoicePaid(invoiceModel: snapshot.data, currency: homeController.getCurrency);
      },
    );
  }

  Widget _buildConsumptionChart() {
    return StreamBuilder(
      stream: _eventsConsumptions.stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        ConsumptionController consumptionController = new ConsumptionController();
        consumptionController.setMetersModel = snapshot.data;
        consumptionController.setLoginModel = homeController.getLoginModel;
        consumptionController.setContractDetailModel = homeController.getContractDetailModel;
        return  CardConsumption(consumptionController: consumptionController);
      },
    );
  }

  Widget _buildReadingHistory() {
    return StreamBuilder(
      stream: _eventsReadings.stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        ReadingController readingController = new ReadingController();
        readingController.setMetersModel = snapshot.data;
        readingController.setLoginModel = homeController.getLoginModel;
        readingController.setContractModel = homeController.getContractDetailModel;
        return Padding(
            padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5), child: CardReadingHistory(readingController: readingController));
      },
    );
  }

  void _getInvoices() {
    homeController.getLastInvoice().then((invoice) => {
      _eventsInvoicePaid.add(invoice),
      _eventsInvoiceUnPaid.add(invoice),
    });
  }

  void _getMeters() async {
    List<MetersModel> metersList = await homeController.getMetersList();
    _eventsReadings.add(metersList.first);
    _eventsConsumptions.add(metersList.first);
  }
}
