import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myAppBills/app/models/month_select_model.dart';
import 'package:myAppBills/components/my_label.dart';
import 'package:myAppBills/generated/l10n.dart';

class MyMonthDropDown extends StatefulWidget {
  final ValueChanged<MonthSelectModel> onChanged;
  final bool shortText;
  final bool showTitle;
  final double fontSize;
  final Color underlineColor;
  final bool isDense;
  final MonthSelectModel initialSelection;

  MyMonthDropDown({this.onChanged, this.shortText, this.showTitle, this.fontSize, this.underlineColor, this.isDense = false, this.initialSelection});

  @override
  MyMonthDropDownState createState() {
    return new MyMonthDropDownState();
  }
}

class MyMonthDropDownState extends State<MyMonthDropDown> {
  List<MonthSelectModel> monthSelectModelList;
  MonthSelectModel selected;
  bool shortText;
  bool showTitle;
  double fontSize;
  Color underlineColor;
  MonthSelectModel initialSelection;

  @override
  void initState() {
    super.initState();
    _initContext();
  }

  void _initContext() {
    this.monthSelectModelList = new List<MonthSelectModel>();
    this.shortText = widget.shortText == null ? false : widget.shortText;
    this.showTitle = widget.showTitle == null ? true : widget.showTitle;
    this.fontSize = widget.fontSize == null ? 16.0 : widget.fontSize;
    this.underlineColor = widget.underlineColor == null ? Color(0xfff5f5f7) : widget.underlineColor;
    new Future.delayed(Duration.zero, () {
      setState(() {
        MonthSelectModel threeMonths = MonthSelectModel(convertShortText(S.of(context).lbl_last_3_months), 3);
        MonthSelectModel sixMonths = MonthSelectModel(convertShortText(S.of(context).lbl_last_6_months), 6);
        MonthSelectModel twelveMonths = MonthSelectModel(convertShortText(S.of(context).lbl_last_12_months), 12);
        monthSelectModelList.add(threeMonths);
        monthSelectModelList.add(sixMonths);
        monthSelectModelList.add(twelveMonths);
        setSelectedMonth();
      });
    });
  }

  void setSelectedMonth() {
     if (widget.initialSelection == null) {
      initialSelection = monthSelectModelList.first;
    } else {
      for (MonthSelectModel month in monthSelectModelList) {
        if (month.countMonth == widget.initialSelection.countMonth) {
          initialSelection = month;
        }
      }
    }
    this.selected = this.selected == null ? initialSelection : this.selected;
  }

  @override
  Widget build(BuildContext context) {
    if(this.selected == null || this.monthSelectModelList == null || this.monthSelectModelList.isEmpty){
      return Container();
    }
    return _buildDropDown();
  }

  Widget _buildDropDown() {
    return Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        child: DropdownButtonFormField<MonthSelectModel>(
          value: this.selected,
          isExpanded: true,
          isDense: widget.isDense,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xff1f414d),
            size: 20,
          ),
          onChanged: (MonthSelectModel newValue) {
            setState(() {
              FocusScope.of(context).requestFocus(new FocusNode());
              this.selected = newValue;
            });
            widget.onChanged(newValue);
          },
          decoration: InputDecoration(
            isDense: widget.isDense,
            labelText: showTitle ? S.of(context).lbl_filter_by : null,
            labelStyle: TextStyle(fontSize: showTitle ? 12 : 0, color: Color.fromRGBO(0, 0, 0, 0.54), fontFamily: MyLabel.MEDIUM),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: underlineColor)),
            contentPadding: EdgeInsets.all(0),
          ),
          items: monthSelectModelList.map<DropdownMenuItem<MonthSelectModel>>((MonthSelectModel model) {
            return DropdownMenuItem<MonthSelectModel>(
              value: model,
              child: MyLabel(
                label: model.description,
                fontSize: fontSize,
                fontFamily: MyLabel.MEDIUM,
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList(),
        ));
  }

  String convertShortText(String value) {
    var arr = value.split(" ");
    if (this.shortText && arr.length >= 3) {
      value = arr[1] + " " + arr.last;
    }
    return value;
  }
}
