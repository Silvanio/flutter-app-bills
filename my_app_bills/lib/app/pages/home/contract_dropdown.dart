import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myAppBills/app/models/contract_detail_model.dart';
import 'package:myAppBills/components/my_label.dart';
import 'package:myAppBills/generated/l10n.dart';
import 'package:myAppBills/utils/convert.dart';
import 'package:myAppBills/utils/type_contract.dart';

class ContractDropDown extends Container {
  final List<ContractDetailModel> list;
  final ContractDetailModel selected;
  final ValueChanged<ContractDetailModel> onChanged;

  ContractDropDown({this.list, this.selected, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ContractDetailModel>(
      value: selected,
      isExpanded: true,
      isDense: false,
      selectedItemBuilder: (BuildContext context) {
        return list.map<DropdownMenuItem<ContractDetailModel>>((ContractDetailModel model) {
          return DropdownMenuItem<ContractDetailModel>(
              value: model, child: _buildContractItem(context, model, model == list.last, true));
        }).toList();
      },
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Color(0xff1f414d),
        size: 30,
      ),
      decoration: InputDecoration(
        isDense: false,
        contentPadding: EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.transparent)),
      ),
      onChanged: onChanged,
      items: list.map<DropdownMenuItem<ContractDetailModel>>((ContractDetailModel model) {
        return DropdownMenuItem<ContractDetailModel>(
            value: model, child: _buildContractItem(context, model, model == list.last, false));
      }).toList(),
    );
  }

  Widget _buildContractItem(BuildContext context, ContractDetailModel model, bool isLast, bool isSelected) {
    String cil = S.of(context).lbl_place_consumption + ": " + model.contract.cil;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageIcon(TypeContract.getImage(model.contract.productCode), size: 40),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyLabel(label: MyConvert.stringToCamelCase(model.client.name), fontWeight: FontWeight.w300, fontSize: 14),
              MyLabel(label: cil, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w300, fontSize: 13),
              MyLabel(
                  label: model.address.getStreetComplete(),
                  fontFamily: MyLabel.LIGHT,
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
            ],
          ),
        ],
      ),
      isLast || isSelected ? Divider(color: Colors.transparent, height: 0) : Divider(),
    ]);
  }
}
