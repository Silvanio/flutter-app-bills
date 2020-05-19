import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myutility/app/models/contract_detail_model.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/utils/convert.dart';
import 'package:myutility/utils/type_contract.dart';

class ContractDropDown extends Container {
  final List<ContractDetailModel> list;
  final ContractDetailModel selected;
  final ValueChanged<ContractDetailModel> onChanged;

  ContractDropDown({this.list, this.selected, this.onChanged});

  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField<ContractDetailModel>(
      value: selected,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Color(0xff1f414d),
        size: 30,
      ),
      iconEnabledColor: Color(0xff1f414d),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.transparent)),
      ),
      onChanged: onChanged,
      items: list.map<DropdownMenuItem<ContractDetailModel>>((ContractDetailModel model) {
        return DropdownMenuItem<ContractDetailModel>(
          value: model,
          child: _buildContractItem(context,model, model == list.last, model == list.first),
        );
      }).toList(),
    );
  }

  Widget _buildContractItem(BuildContext context, ContractDetailModel model, bool isLast, bool isFirst) {
    String cil = S.of(context).lbl_place_consumption + ": "+model.contract.cil;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      //SizedBox(height: 10),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageIcon(TypeContract.getImage(model.contract.productCode), size: 40),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyLabel(label:  MyConvert.stringToCamelCase(model.client.name), fontWeight: FontWeight.w300,fontSize: 14),
              MyLabel(label: cil, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w300,fontSize: 13),
              MyLabel(label: model.address.getStreetComplete(), fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w300,fontSize: 13),
            ],
          ),
        ],
      ),
      isLast ? Divider(color: Colors.transparent) : Divider(),
    ]);
  }
}
