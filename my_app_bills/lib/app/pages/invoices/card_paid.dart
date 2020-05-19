import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutility/app/models/invoice_model.dart';
import 'package:myutility/components/my_expansion_card.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/utils/convert.dart';

// ignore: must_be_immutable
class CardPaid extends Container {
  final InvoiceModel invoiceModel;
  BuildContext _context;
  String currency;

  CardPaid({this.invoiceModel, this.currency});

  @override
  Widget build(BuildContext context) {
    this._context = context;
    if (invoiceModel == null || !invoiceModel.isLiquidated) {
      return Container();
    }
    return _getCardInvoice();
  }

  Widget _getCardInvoice() {
    return MyExpansionCard(
      header: _getHeader(),
      isCard: false,
      headerExpanded: _getHeaderExpanded(),
      bodyChildren: <Widget>[_getBody()],
    );
  }

  Widget _getHeader() {

    String dataFormat = MyConvert.formatDatePattern(invoiceModel.issueDate, "MMMM");
    if(dataFormat != null){
      dataFormat = dataFormat.toUpperCase();
    }
    return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MyLabel(label: dataFormat, fontFamily: MyLabel.LIGHT, fontSize: 20, fontWeight: FontWeight.w300),
                Row(
                  children: <Widget>[
                    MyLabel(label: MyConvert.formatMoney(invoiceModel.paymentData.value), fontFamily: MyLabel.MEDIUM, fontSize: 24, fontWeight: FontWeight.w500),
                    MyLabel(label: currency, fontFamily: MyLabel.MEDIUM, fontSize: 25, fontWeight: FontWeight.w500),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MyLabel(label: S.of(_context).lbl_paid, fontFamily: MyLabel.REGULAR, fontWeight: FontWeight.w500 ,fontSize: 14, color: Color(0xff219653))
              ],
            )
          ],
        ),
    );
  }

  Widget _getHeaderExpanded() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyLabel(label: S.of(_context).lbl_last_bill.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 18, fontWeight: FontWeight.w300),
              Row(
                children: <Widget>[
                  MyLabel(label: MyConvert.formatMoney(invoiceModel.paymentData.value), fontFamily: MyLabel.MEDIUM, fontSize: 18, fontWeight: FontWeight.w500),
                  MyLabel(label: currency, fontFamily: MyLabel.MEDIUM, fontSize: 18, fontWeight: FontWeight.w500),
                ],
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyLabel(
                  label: S.of(_context).msg_pay_in(MyConvert.formatDate(invoiceModel.paymentData.finishDate)),
                  fontFamily: MyLabel.LIGHT,
                  fontSize: 10.5),
              MyLabel(label: S.of(_context).lbl_paid, fontFamily: MyLabel.REGULAR, fontSize: 14, color: Color(0xff219653))
            ],
          )
        ],
      ));
  }

  Widget _getBody() {
    return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              MyLabel(label: S.of(_context).lbl_invoice_n_reference + ":", fontFamily: MyLabel.LIGHT, fontSize: 15),
              SizedBox(height: 10),
              MyLabel(label: S.of(_context).lbl_issue_date + ":", fontFamily: MyLabel.LIGHT, fontSize: 15),
              SizedBox(height: 10),
            ]),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              MyLabel(label: invoiceModel.invoiceNumber, fontFamily: MyLabel.REGULAR, fontSize: 15),
              SizedBox(height: 10),
              MyLabel(label: MyConvert.formatDate(invoiceModel.issueDate), fontFamily: MyLabel.REGULAR, fontSize: 15),
              SizedBox(height: 10),
            ])
          ],
        ));
  }
}
