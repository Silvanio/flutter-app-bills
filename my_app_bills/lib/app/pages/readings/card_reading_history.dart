import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutility/app/controllers/reading_controller.dart';
import 'package:myutility/app/models/month_select_model.dart';
import 'package:myutility/app/models/reading_model.dart';
import 'package:myutility/components/my_month_drop_down.dart';
import 'package:myutility/components/my_expansion_card.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/utils/convert.dart';
import 'package:myutility/utils/type_unit.dart';

class CardReadingHistory extends StatefulWidget {
  final ReadingController readingController;
  final ValueChanged<List<ReadingModel>> onChanged;

  CardReadingHistory({this.readingController,this.onChanged});

  @override
  CardReadingHistoryState createState() {
    return new CardReadingHistoryState();
  }
}

class CardReadingHistoryState extends State<CardReadingHistory> {
  List<ReadingModel> readingList;
  double heightContainer;

  @override
  void initState() {
    super.initState();
    _initContext();
  }

  void _initContext() {
    new Future.delayed(Duration.zero, () {
      _getReading(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getCardReadingHistory(context);
  }

  Widget _getCardReadingHistory(BuildContext context) {
    return MyExpansionCard(
      header: _buildHeader(context),
      bodyChildren: <Widget>[_buildDropDown(), _buildReadings()],
    );
  }

  void _getReading(int countMonth) {
    widget.readingController.listReadings(countMonth).then((readings) => {
      onChange(readings),
      setState(() => readingList = readings)
    }).catchError((error, stackTrace) {
      setState(() => readingList = new List<ReadingModel>());
    });
  }

  void onChange(List<ReadingModel> readings){
    if(widget.onChanged != null){
      widget.onChanged(readings);
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child:
                MyLabel(label: S.of(context).lbl_reading_history.toUpperCase(), fontFamily: MyLabel.LIGHT, fontSize: 18, fontWeight: FontWeight.w500))
      ],
    );
  }

  Widget _buildDropDown() {
    return Padding(
      padding: const EdgeInsets.only(left:10.0, right: 20.0),
      child: MyMonthDropDown(
        fontSize: 14,
        isDense: false,
        onChanged: (MonthSelectModel newValue) {
          setState(() {
            FocusScope.of(context).requestFocus(new FocusNode());
            readingList = null;
          });
          _getReading(newValue.countMonth);
        },
      ),
    );
  }

  Widget _buildReadings() {
    if (readingList == null) {
      return _buildCircularProgress();
    }
    if (readingList.isEmpty) {
      heightContainer = 270;
      return Container(height: heightContainer);
    }
    return _buildContainerReadings();
  }

  Widget _buildCircularProgress() {
    return Container(
      height: heightContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xffa1c4d0)),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerReadings() {
    heightContainer = readingList.length <= 3 ? 270 : 370;
    return Container(
        height: heightContainer,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, position) {
            ReadingModel model = readingList.elementAt(position);
            return _buildInfoReading(model);
          },
          separatorBuilder: (context, position) {
            return Divider(endIndent: 15, indent: 15, color: Color(0xffe0e0e0));
          },
          itemCount: readingList.length,
        ));
  }

  Widget _buildInfoReading(ReadingModel model) {
    String dataFormat = MyConvert.formatDatePattern(model.readingDate, "dd MMMM");
    int valueReading = 0;
    if (model.value != null) {
      valueReading = model.value.toInt();
    }
    return ListTile(
        dense: true,
        isThreeLine: true,
        title: Padding(
            padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              MyLabel(label: dataFormat.toUpperCase(), fontFamily: MyLabel.REGULAR, fontSize: 18),
              MyLabel(
                  //label: model.estimate ? S.of(context).lbl_client : S.of(context).lbl_distributor,
                  label: model.source,
                  fontFamily: MyLabel.LIGHT,
                  color: Color(0xff6ba1b3),
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ])),
        subtitle: Row(children: <Widget>[
          MyLabel(label: S.of(context).lbl_reading + ":", fontFamily: MyLabel.LIGHT, fontSize: 16, fontWeight: FontWeight.normal),
          SizedBox(width: 5),
          MyLabel(label: valueReading.toString(), fontFamily: MyLabel.LIGHT, fontSize: 16, fontWeight: FontWeight.w300),
          SizedBox(width: 2),
          _buildUnit(widget.readingController.getMetersModel.unit)
        ]));
  }

  Widget _buildUnit(String unit) {
    String icon = TypeUnit.getIcon(unit);
    String label = TypeUnit.getUnit(unit);
    return Row(
      children: <Widget>[
        icon != null ? ImageIcon(new AssetImage(icon), size: 9, color: Color(0xff1f414d)) : Container(),
        MyLabel(label: label, fontFamily: MyLabel.MEDIUM, fontSize: 12, fontWeight: FontWeight.w500),
      ],
    );
  }
}
