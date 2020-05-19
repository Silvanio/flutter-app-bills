import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutility/app/controllers/contracts_controller.dart';
import 'package:myutility/components/my_expansion_card.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/utils/convert.dart';

class CardHolderData extends StatefulWidget {
  final ContractsController contractsController;

  CardHolderData({this.contractsController});

  @override
  CardHolderDataState createState() {
    return new CardHolderDataState(contractsController: contractsController);
  }
}

class CardHolderDataState extends State<CardHolderData> {
  final ContractsController contractsController;
  CardHolderDataState({this.contractsController});

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
              MyLabel(label: S.of(context).lbl_holder_info.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 18, fontWeight: FontWeight.w300),
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
              MyLabel(label: S.of(context).lbl_holder_info.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 18, fontWeight: FontWeight.w300),
            ],
          ),
        ],
      ),
    );
  }

  /// TODO: pode-se seprar as rows para ser de melhor perceção
  Widget _getBody() {
    String cli_snome, cli_lnome;
    cli_snome =
        (contractsController.getContractDetailModel.client.name.substring(0, contractsController.getContractDetailModel.client.name.indexOf(' ')));
    cli_lnome = (contractsController.getContractDetailModel.client.name
        .substring(1 + contractsController.getContractDetailModel.client.name.lastIndexOf(' ')));

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
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              MyLabel(label: S.of(context).lbl_first_last_names, fontFamily: MyLabel.LIGHT, fontSize: 15),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child:
                                    MyLabel(label: MyConvert.stringToCamelCase(cli_snome + ' ' + cli_lnome), fontFamily: MyLabel.REGULAR, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MyLabel(label: S.of(context).lbl_contracts_nif, fontFamily: MyLabel.LIGHT, fontSize: 15),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: MyLabel(label: contractsController.getContractDetailModel.client.nif, fontFamily: MyLabel.REGULAR, fontSize: 15),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyLabel(label: S.of(context).lbl_contracts_email, fontFamily: MyLabel.LIGHT, fontSize: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: MyLabel(
                                  label: contractsController.getContractDetailModel.client.email != null
                                      ? contractsController.getContractDetailModel.client.email
                                      : '-',
                                  fontFamily: MyLabel.REGULAR,
                                  fontSize: 15),
                            )
                          ],
                        ),
                        /// para colocar depois
                        /*new IconButton(
                          icon: new Icon(Icons.edit),
                          tooltip: 'modify_email',
                          onPressed: null,
                          // onPressed: () => _modifyEmail( colocar focus e resto da logica),
                        )*/
                        /// para colocar depois
                      ],
                    ),
                  ),

                  /// para dar o fill correto do espaço
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MyLabel(label: '', fontFamily: MyLabel.LIGHT, fontSize: 15),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: MyLabel(label: '', fontFamily: MyLabel.REGULAR, fontSize: 15),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyLabel(label: S.of(context).lbl_contracts_phone, fontFamily: MyLabel.LIGHT, fontSize: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: MyLabel(
                                  label: contractsController.getContractDetailModel.client.phone != null
                                      ? contractsController.getContractDetailModel.client.phone
                                      : '-',
                                  fontFamily: MyLabel.REGULAR,
                                  fontSize: 15),
                            )
                          ],
                        ),
                        /// para colocar depois
                        /*new IconButton(
                          icon: new Icon(Icons.edit),
                          tooltip: 'modify_telephone',
                          onPressed: null,
                          // onPressed: () => _modifyTelephone( colocar focus e resto da logica),
                        )*/
                        /// para colocar depois
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyLabel(label: S.of(context).lbl_contracts_mobile_phone, fontFamily: MyLabel.LIGHT, fontSize: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: MyLabel(
                                  label: contractsController.getContractDetailModel.client.phone != null
                                      ? contractsController.getContractDetailModel.client.phone
                                      : '-',
                                  fontFamily: MyLabel.REGULAR,
                                  fontSize: 15),
                            )
                          ],
                        ),
                        /// para colocar depois
                        /*new IconButton(
                          icon: new Icon(Icons.edit),
                          tooltip: 'modify_mobile_phone',
                          onPressed: null,
                          // onPressed: () => _modifyMobilephone( colocar focus e resto da logica),
                        )*/
                        /// para colocar depois
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
