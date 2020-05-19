import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutility/app/controllers/contracts_controller.dart';
import 'package:myutility/components/my_expansion_card.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/utils/type_contract.dart';

class CardContractData extends StatefulWidget {
  final ContractsController contractsController;

  CardContractData({this.contractsController});

  @override
  CardContractDataState createState() {
    return new CardContractDataState(contractsController: contractsController);
  }
}

class CardContractDataState extends State<CardContractData> {
  final ContractsController contractsController;
  CardContractDataState({this.contractsController});

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
      isExpanded: true,
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
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: MyLabel(label: S.of(context).lbl_contract_info.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 18, fontWeight: FontWeight.w300)),
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
              MyLabel(label: S.of(context).lbl_contract_info.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 18, fontWeight: FontWeight.w300),
              //MyLabel(label: S.of(context).lbl_paid, fontFamily: MyLabel.REGULAR, fontSize: 14, color: Color(0xff219653))
            ],
          ),
        ],
      ),
    );
  }

  /// TODO: pode-se seprar as rows para ser de melhor perceção
  Widget _getBody() {
    return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 10, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyLabel(label: S.of(context).lbl_contracts_address, fontFamily: MyLabel.LIGHT, fontSize: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: MyLabel(
                                  label: contractsController.getContractDetailModel.address.getStreetComplete() +
                                      '\n' +
                                      contractsController.getContractDetailModel.address.cp4 +
                                      '-' +
                                      contractsController.getContractDetailModel.address.cp3 +
                                      ' ' +
                                      contractsController.getContractDetailModel.address.city,
                                  fontFamily: MyLabel.REGULAR,
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(TypeContract.getImage(contractsController.getContractDetailModel.contract.productCode), size: 40),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyLabel(label: S.of(context).lbl_nr_contract, fontFamily: MyLabel.LIGHT, fontSize: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: MyLabel(
                                  label: contractsController.getContractDetailModel.contract.contractNumber,
                                  fontFamily: MyLabel.REGULAR,
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                            fit: BoxFit.fitWidth,
                            child: MyLabel(label: S.of(context).lbl_place_consumption, fontFamily: MyLabel.LIGHT, fontSize: 15)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: MyLabel(label: contractsController.getContractDetailModel.contract.cil, fontFamily: MyLabel.REGULAR, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyLabel(label: S.of(context).lbl_contracts_tariff, fontFamily: MyLabel.LIGHT, fontSize: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: MyLabel(
                                  label: contractsController.getContractDetailModel.contract.tariffCode, fontFamily: MyLabel.REGULAR, fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MyLabel(label: S.of(context).lbl_contracts_start_date, fontFamily: MyLabel.LIGHT, fontSize: 15),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: MyLabel(
                              label: contractsController.getContractDetailModel.contract.startDate.day.toString() +
                                  ' / ' +
                                  contractsController.getContractDetailModel.contract.startDate.month.toString() +
                                  ' / ' +
                                  contractsController.getContractDetailModel.contract.startDate.year.toString(),
                              fontFamily: MyLabel.REGULAR,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
