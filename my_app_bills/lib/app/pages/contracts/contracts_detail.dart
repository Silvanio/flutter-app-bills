import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myutility/app/controllers/contracts_controller.dart';
import 'package:myutility/app/pages/contracts/card_additional_data.dart';
import 'package:myutility/app/pages/contracts/card_contract_data.dart';
import 'package:myutility/app/pages/contracts/card_holder_data.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';

class ContractsDetail extends StatefulWidget {
  ContractsDetailState createState() => new ContractsDetailState();
}

class ContractsDetailState extends State<ContractsDetail> {
  ContractsController contractsController;  /// proveniente da class menu e MyNavigator, é passado por argumento

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contractsController = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: _titleBar(),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: new SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: <Widget>[
            SizedBox(height: 5),
            CardContractData(contractsController: contractsController),
            CardHolderData(contractsController: contractsController),
            CardAdditionalData(contractsController: contractsController)
          ],
        ),
      )),
    );
  }

  Widget _titleBar() {
    return MyLabel(
        label: S.of(context).lbl_speel_contracts.toUpperCase(),
        fontFamily: MyLabel.MEDIUM,
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w300);
  }
}
