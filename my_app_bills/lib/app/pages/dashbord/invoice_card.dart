import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myutility/app/models/invoice_model.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/style/home_style.dart';
import 'package:myutility/utils/convert.dart';

class InvoiceCard extends Container {

  final InvoiceModel invoiceModel;
  final String title;
  final GestureTapCallback onTap;

  InvoiceCard({this.invoiceModel, this.onTap, this.title});

  @override
  Widget build(BuildContext context) {

    Color color = invoiceModel.isLiquidated ? Colors.green : Color.fromRGBO(249, 162, 2, 1);
    double value = invoiceModel.paymentData.value;
    String liquidated = invoiceModel.isLiquidated ? S.of(context).lbl_paid : S.of(context).lbl_waiting_payment;
    String issueDate = MyConvert.formatDate(invoiceModel.issueDate);
    String lblPayment = invoiceModel.isLiquidated ? S.of(context).lbl_payment_date : S.of(context).lbl_payment_deedLine;
    DateTime datePayment = invoiceModel.isLiquidated ? invoiceModel.paymentData.finishDate : invoiceModel.deedLinePayment;
    String datePaymentFormat = MyConvert.formatDate(datePayment);

    return Container(
        height: 120,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          child: InkWell(
            onTap: onTap,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: color,
                    width: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        _getTitle(context),
                        _getDividerTitle(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(S.of(context).lbl_issue_date + ": ",
                                style: TextStyle(
                                  fontSize: 10.0,fontWeight: FontWeight.bold,
                                  color: kDefaultColorHome,
                                )),
                            Text(issueDate,
                                style: TextStyle(
                                  fontSize: 10.0,fontWeight: FontWeight.bold,
                                  color: kDefaultColorHome,
                                )),
                            SizedBox(width: 10.0),
                          ],),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(MyConvert.formatMoney(value), style: TextStyle(fontSize: 26.0, fontFamily: 'OpenSans', color: Colors.blue)),
                            Icon(Icons.euro_symbol, color: Colors.blue,size: 12,),
                            SizedBox(width: 10.0),
                            ClipOval(
                                child: Container(
                              color: color,
                              height: 8.0, // height of the button
                              width: 8.0, // width of the button
                            )),
                            SizedBox(width:4.0),
                            Text(
                              liquidated,
                              style: TextStyle(
                                color: color,
                                fontFamily: 'OpenSans',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(lblPayment + ": ",
                                style: TextStyle(
                                  fontSize: 10.0,fontWeight: FontWeight.bold,
                                  color: kDefaultColorHome,
                                )),
                            Text(datePaymentFormat,
                                style: TextStyle(
                                  fontSize: 10.0,fontWeight: FontWeight.bold,
                                  color: kDefaultColorHome,
                                )),
                            SizedBox(width: 10.0),
                          ],
                        ),
                      ],
                    ),
                    flex: 3,
                  ),
                  Container(
                    child:    Icon(Icons.arrow_forward_ios, color: Colors.blue,size: 10,),
                    width: 13,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
  Widget _getDividerTitle(){
    if(this.title == null || this.title.isEmpty){
      return Column();
    }
    return Divider();
  }

  Widget _getTitle(BuildContext context){

    if(this.title == null || this.title.isEmpty){
      return Column();
    }

    return   Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.payment, color: Colors.blue),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            color: Colors.black26,
            fontFamily: 'OpenSans',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

}
