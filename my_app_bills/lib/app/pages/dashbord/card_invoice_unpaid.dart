import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutility/app/models/invoice_model.dart';
import 'package:myutility/components/my_expansion_card.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/utils/convert.dart';

// ignore: must_be_immutable
class CardInvoiceUnPaid extends Container {
  final InvoiceModel invoiceModel;
  BuildContext _context;
  String currency;

  CardInvoiceUnPaid({this.invoiceModel, this.currency});

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
      bodyChildren: <Widget>[
        _getBody(),
      ],
    );
  }

  Widget _getHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 0),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MyLabel(label: S.of(_context).lbl_open_value.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 18, fontWeight: FontWeight.w300),
          MyLabel(label: S.of(_context).msg_payment_until(MyConvert.formatDate(invoiceModel.deedLinePayment)), fontFamily: MyLabel.LIGHT,
              fontSize: 12, fontWeight: FontWeight.w300),
          Row(
            children: <Widget>[
              MyLabel(label: MyConvert.formatMoney(invoiceModel.paymentData.value), fontFamily: MyLabel.MEDIUM, fontSize: 30, fontWeight: FontWeight.w500),
              MyLabel(label: currency, fontFamily: MyLabel.MEDIUM, fontSize: 25, fontWeight: FontWeight.w500),
            ],
          )
        ],
      ));
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
                    label: S.of(_context).msg_payment_until(MyConvert.formatDate(invoiceModel.deedLinePayment)), fontFamily: MyLabel.LIGHT, fontSize: 10.5, fontWeight: FontWeight.w300)
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
