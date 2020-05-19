import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutility/app/controllers/contracts_controller.dart';
import 'package:myutility/components/my_expansion_card.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/utils/convert.dart';

class CardAdditionalData extends StatefulWidget {
  final ContractsController contractsController;

  CardAdditionalData({this.contractsController});

  @override
  CardAdditionalDataState createState() {
    return new CardAdditionalDataState(contractsController: contractsController);
  }
}

class CardAdditionalDataState extends State<CardAdditionalData> {
  final ContractsController contractsController;
  CardAdditionalDataState({this.contractsController});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyExpansionCard(
      header: _getHeader(),
      headerExpanded: _getHeaderExpanded(),
      bodyChildren: <Widget>[_getBody()],
    );
  }

  Widget _getHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyLabel(
                  label: S.of(context).lbl_additional_options.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 18, fontWeight: FontWeight.w300),
              //MyLabel(label: S.of(context).lbl_paid, fontFamily: MyLabel.REGULAR, fontSize: 14, color: Color(0xff219653))
            ],
          ),
        ],
      ),
    );
  }

  Widget _getHeaderExpanded() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyLabel(
                  label: S.of(context).lbl_additional_options.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 18, fontWeight: FontWeight.w300),
              //MyLabel(label: S.of(context).lbl_paid, fontFamily: MyLabel.REGULAR, fontSize: 14, color: Color(0xff219653))
            ],
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 10, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyLabel(
                          label: MyConvert.stringToCamelCase(S.of(context).lbl_contracts_contract_direct_debit),
                          fontFamily: MyLabel.LIGHT,
                          fontSize: 15),
                      Row(
                        children: <Widget>[
                          contractsController.getContractDetailModel.directDebit == true
                              ? MyLabel(label: MyConvert.stringToCamelCase(S.of(context).lbl_active), fontFamily: MyLabel.LIGHT, fontSize: 15)
                              : MyLabel(label: MyConvert.stringToCamelCase(S.of(context).lbl_inactive), fontFamily: MyLabel.LIGHT, fontSize: 15),
                          /// para colocar depois
                          //new Switch(value: contractsController.getContractDetailModel.directDebit, onChanged: null),
                          /// para colocar depois
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(endIndent: 15, indent: 15, color: Color(0xffe0e0e0)),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyLabel(
                          label: MyConvert.stringToCamelCase(S.of(context).lbl_contracts_electronic_invoice),
                          fontFamily: MyLabel.LIGHT,
                          fontSize: 15),
                      Row(
                        children: <Widget>[
                          contractsController.getContractDetailModel.electronicInvoice == true
                              ? MyLabel(label: MyConvert.stringToCamelCase(S.of(context).lbl_active), fontFamily: MyLabel.LIGHT, fontSize: 15)
                              : MyLabel(label: MyConvert.stringToCamelCase(S.of(context).lbl_inactive), fontFamily: MyLabel.LIGHT, fontSize: 15),
                          /// para colocar depois
                          //new Switch(value: contractsController.getContractDetailModel.electronicInvoice, onChanged: null),
                          /// para colocar depois
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(endIndent: 15, indent: 15, color: Color(0xffe0e0e0)),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyLabel(label: MyConvert.stringToCamelCase(S.of(context).lbl_contracts_social_tariff), fontFamily: MyLabel.LIGHT, fontSize: 15),
                      Row(
                        children: <Widget>[
                          contractsController.getContractDetailModel.socialTariff == true
                              ? MyLabel(label: MyConvert.stringToCamelCase(S.of(context).lbl_active), fontFamily: MyLabel.LIGHT, fontSize: 15)
                              : MyLabel(label: MyConvert.stringToCamelCase(S.of(context).lbl_inactive), fontFamily: MyLabel.LIGHT, fontSize: 15),
                          /// para colocar depois
                          //new Switch(value: contractsController.getContractDetailModel.socialTariff, onChanged: null),
                          /// para colocar depois
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
