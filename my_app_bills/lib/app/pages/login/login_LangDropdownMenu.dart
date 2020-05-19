import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myutility/components/my_label.dart';

class LoginLangDropDown extends Container {
  final List<String> list;
  final String selected;
  final ValueChanged<String> onChanged;

  LoginLangDropDown({this.list, this.selected, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      iconSize: 40,
      value: selected,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Color(0xff1f414d),
        size: 30,
      ),
      iconEnabledColor: Color(0xff1f414d),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 0, top: 0, left: 20, right: 30),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.transparent)),
      ),
      onChanged: onChanged,
      items: list.map<DropdownMenuItem<String>>((String model) {
        return DropdownMenuItem<String>(
          value: model,
          child: _buildLocaleItem(model, model == list.last, model == list.first),
        );
      }).toList(),
    );
  }

  Widget _buildLocaleItem(String model, bool isLast, bool isFirst) {
    String title = "";
    if (model != null) {
      title = model.toUpperCase();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      SizedBox(height: 10),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              MyLabel(label: title, fontWeight: FontWeight.w300, fontSize: 14),
            ],
          ),
        ],
      ),
      isLast ? Divider(color: Colors.transparent) : Divider(),
    ]);
  }
}
