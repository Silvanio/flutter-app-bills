import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myAppBills/app/controllers/contracts_controller.dart';
import 'package:myAppBills/app/models/contract_detail_model.dart';
import 'package:myAppBills/components/my_label.dart';
import 'package:myAppBills/generated/l10n.dart';
import 'package:myAppBills/my_navigator.dart';
import 'package:myAppBills/style/contact&warning_style.dart';
import 'package:myAppBills/utils/convert.dart';
import 'package:myAppBills/utils/type_contract.dart';

class ContractsList extends StatefulWidget {
  @override
  _ContractsListState createState() => _ContractsListState();
}

class _ContractsListState extends State<ContractsList> {
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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: _titleBar(),
      ),
      body: SafeArea(
        child: Container(padding: EdgeInsets.all(10.0), child: _buildContractListCard()),
      ),
    );
  }

  Widget _buildContractListCard() {
    var list = contractsController.getContractDetailModelList;
    return Container(
        decoration: kBoxRoundShadow,
        child: ListView(
          children: <Widget>[
            //_buildHeader(context), -- não existe header da lista nesta
            ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    child: _buildContractItem(context, list[index], list[index] == list.last, list[index] == list.first),
                  ),
                  onTap: () => _openContractDetail(list[index]),
                );
              },
            ),
          ],
        ));
  }

  Widget _buildContractItem(BuildContext context, ContractDetailModel model, bool isLast, bool isFirst) {
    String cil = S.of(context).lbl_place_consumption + ": " + model.contract.cil;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      SizedBox(height: 10),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageIcon(TypeContract.getImage(model.contract.productCode), size: 40),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: MyLabel(label: MyConvert.stringToCamelCase(model.client.name), fontWeight: FontWeight.w300, fontSize: 14)),
              MyLabel(label: cil, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w300, fontSize: 13),
              MyLabel(label: model.address.getStreetComplete(), fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w300, fontSize: 13),
            ],
          ),
        ],
      ),
      isLast ? Divider(color: Colors.transparent) : Divider(),
    ]);
  }

  void _openContractDetail(ContractDetailModel model) {
    //globalProgressDialog.show();
    ContractsController contractController = new ContractsController();
    contractController.setLoginModel = contractsController.getLoginModel;
    contractController.setContractDetailModel = model;
    MyNavigator.goToContractDetail(context, contractsController: contractController);
  }

  Widget _titleBar() {
    return MyLabel(
      label: S.of(context).lbl_speel_contracts.toUpperCase(),
      fontFamily: MyLabel.MEDIUM,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Colors.black,
    );
  }
}
