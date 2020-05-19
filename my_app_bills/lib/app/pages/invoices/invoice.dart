import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myutility/app/controllers/invoice_controller.dart';
import 'package:myutility/app/models/contract_detail_model.dart';
import 'package:myutility/app/models/invoice_model.dart';
import 'package:myutility/app/models/month_select_model.dart';
import 'package:myutility/app/pages/invoices/card_paid.dart';
import 'package:myutility/app/pages/invoices/card_unpaid.dart';
import 'package:myutility/components/my_month_drop_down.dart';
import 'package:myutility/components/my_card.dart';
import 'package:myutility/generated/l10n.dart';

class Invoice extends StatefulWidget {
  final InvoiceController invoiceController;

  Invoice({this.invoiceController});

  InvoiceState createState() => new InvoiceState();
}

class InvoiceState extends State<Invoice> {
  InvoiceController invoiceController;    /// proveniente da class menu e MyNavigator, é passado por argumento
  ContractDetailModel lastContract;
  StreamController<List<InvoiceModel>> _eventsInvoicesTimeLine;
  InvoiceModel invoiceSelected;
  double heightContainer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createStateInvoices();

    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: MyCard(
            body: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Column(children: <Widget>[SizedBox(height: 5),_buildHeader(), SizedBox(height: 5),_buildInvoices()]))));
  }

  void _createStateInvoices() {
    invoiceController = widget.invoiceController;
    invoiceController.getCompanyCurrency();
    //heightContainer = 390;
    heightContainer = MediaQuery.of(context).size.height * 0.5;
    if (_isRebuild()) {
      lastContract = invoiceController.getContractDetailModel;
      _eventsInvoicesTimeLine = new StreamController<List<InvoiceModel>>();
      _getInvoices(12);
    }
  }

  void _getInvoices(int numberOfElements) {
    invoiceController.getAPIInvoices(numberOfElements).then((invoices) => {
          _eventsInvoicesTimeLine.add(invoices),
        });
  }

  bool _isRebuild() {
    return (lastContract == null || invoiceController.getContractDetailModel.contract.cil != lastContract.contract.cil);
  }

  Widget _buildHeader() {
    return _buildDropDown();
  }

  Widget _buildDropDown() {
    return MyMonthDropDown(
      fontSize: 14,
      isDense: false,
      initialSelection: MonthSelectModel(S.of(context).lbl_last_12_months, 12),
      onChanged: (MonthSelectModel newValue) {
        _eventsInvoicesTimeLine.add(null);
        _getInvoices(newValue.countMonth);
      },
    );
  }


  Widget _buildInvoices() {
    return StreamBuilder(
        stream: _eventsInvoicesTimeLine.stream,
        builder: (BuildContext context, snapshot) {

          if (snapshot.data == null) {
            return _buildCircularProgress();
          }
          List<InvoiceModel> dataList = snapshot.data;
          dataList.sort((b, a) => a.issueDate.compareTo(b.issueDate));
          return Container(
              height: heightContainer,
              child:ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, position) {
                  InvoiceModel model = dataList[position];
                  if (model.isLiquidated) {
                    return CardPaid(invoiceModel: model, currency: invoiceController.getCurrency);
                  } else {
                    return CardUnPaid(invoiceModel: model, currency: invoiceController.getCurrency);
                  }
                },
                separatorBuilder: (context, position) {
                  return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                  child: Container(
                    color: Color(0xfff5f5f7),
                    width: double.infinity,
                    height: 1,
                  ));//Divider(endIndent: 15, indent: 15, color: Color(0xffe0e0e0));
                },
                itemCount: dataList.length,
              ));
        });
  }

  Widget _buildCircularProgress() {

    return Container(
        height: heightContainer,
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xffa1c4d0)),
        ),
      ],
    ));
  }
}
