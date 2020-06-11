import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myAppBills/app/models/invoice_model.dart';
import 'package:myAppBills/components/my_expansion_card.dart';
import 'package:myAppBills/components/my_label.dart';
import 'package:myAppBills/generated/l10n.dart';
import 'package:myAppBills/utils/convert.dart';

// ignore: must_be_immutable
class CardUnPaid extends Container {
  final InvoiceModel invoiceModel;
  BuildContext _context;
  String currency;

  CardUnPaid({this.invoiceModel, this.currency});

  @override
  Widget build(BuildContext context) {
    this._context = context;
    if(invoiceModel == null || invoiceModel.isLiquidated ){
      return Container();
    }
    return _getCardUnPaid();
  }

  Widget _getCardUnPaid() {
    return MyExpansionCard(
      header: _getHeader(),
      headerExpanded: _getHeaderExpanded(),
      isCard: false,
      bodyChildren: <Widget>[
        _getBody(),
      ],
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyLabel(label: S.of(_context).msg_payment_until(MyConvert.formatDate(invoiceModel.deadlinePayment)), fontFamily: MyLabel.LIGHT,
                  fontSize: 12, fontWeight: FontWeight.w300),
              MyLabel(label: S.of(_context).lbl_waiting_payment, fontFamily: MyLabel.REGULAR, fontWeight: FontWeight.w500 ,fontSize: 14, color: Color(0xffe61739))
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
                MyLabel(label: S.of(_context).lbl_open_value.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 15, fontWeight: FontWeight.w500),
                Row(
                  children: <Widget>[
                    MyLabel(label: MyConvert.formatMoney(invoiceModel.paymentData.value), fontFamily: MyLabel.MEDIUM, fontSize: 18, fontWeight: FontWeight.w500),
                    MyLabel(label: currency, fontFamily: MyLabel.MEDIUM, fontSize: 15, fontWeight: FontWeight.w500),
                  ],
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MyLabel(label: S.of(_context).msg_issue_on(MyConvert.formatDate(invoiceModel.issueDate)), fontFamily: MyLabel.LIGHT, fontSize: 10.5, fontWeight: FontWeight.w300),
                MyLabel(
                    label: S.of(_context).msg_pay_until(MyConvert.formatDate(invoiceModel.deadlinePayment)), fontFamily: MyLabel.LIGHT, fontSize: 10.5, fontWeight: FontWeight.w300)
              ],
            )
          ],
        ));
  }

  Widget _getBody() {
    return Padding(
        padding: EdgeInsets.only(top: 0, bottom: 5, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Image(image: AssetImage('assets/images/icon_mb.png'), width: 50),
              SizedBox(height: 40),
            ]),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              MyLabel(label: S.of(_context).lbl_invoice_entity + ":", fontFamily: MyLabel.LIGHT, fontSize: 15, fontWeight: FontWeight.w300),
              SizedBox(height: 10),
              MyLabel(label: S.of(_context).lbl_invoice_reference + ":", fontFamily: MyLabel.LIGHT, fontSize: 15, fontWeight: FontWeight.w300),
              SizedBox(height: 10),
              MyLabel(label: S.of(_context).lbl_invoice_amount + ":", fontFamily: MyLabel.LIGHT, fontSize: 15, fontWeight: FontWeight.w300),
              SizedBox(height: 10)
            ]),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              MyLabel(label: invoiceModel.paymentData.entity, fontFamily: MyLabel.REGULAR, fontSize: 15),
              SizedBox(height: 10),
              MyLabel(label: invoiceModel.paymentData.reference, fontFamily: MyLabel.REGULAR, fontSize: 15),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  MyLabel(
                    label: MyConvert.formatMoney(invoiceModel.paymentData.value),
                    fontFamily: MyLabel.REGULAR,
                    fontSize: 15,
                  ),
                  MyLabel(label: currency, fontFamily: MyLabel.REGULAR, fontSize: 15),
                ],
              ),
              SizedBox(height: 10)
            ])
          ],
        ));
  }
}
