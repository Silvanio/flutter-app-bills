import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myAppBills/app/controllers/consumption_controller.dart';
import 'package:myAppBills/app/models/contract_detail_model.dart';
import 'package:myAppBills/app/models/month_select_model.dart';
import 'package:myAppBills/app/pages/dashbord/chart_trend_consumption.dart';
import 'package:myAppBills/components/my_month_drop_down.dart';
import 'package:myAppBills/components/my_card.dart';
import 'package:myAppBills/components/my_label.dart';
import 'package:myAppBills/generated/l10n.dart';
import 'package:myAppBills/utils/type_unit.dart';

class CardConsumption extends StatefulWidget {
  final ConsumptionController consumptionController;

  CardConsumption({this.consumptionController});

  @override
  CardConsumptionState createState() {
    return new CardConsumptionState();
  }
}

class CardConsumptionState extends State<CardConsumption> {
  var selected = [true, true];
  BuildContext _context;
  List<Chart> _trendList;
  ConsumptionController _consumptionController;
  ContractDetailModel _contractLast;

  @override
  void initState() {
    super.initState();
  }

  void _reload() {
    this._consumptionController = widget.consumptionController;
    if (_contractLast == null || _contractLast != this._consumptionController.getContractDetailModel) {
      _trendList = null;
      _contractLast = this._consumptionController.getContractDetailModel;
      //necessario pois a api apresenta erro caso chamar outra vez sem delay
      Future.delayed(Duration(seconds: 2)).then((value) {
        _initTrend(3);
      });
    }
  }

  void _initTrend(int countMonth) {
    this._consumptionController.buildDataChartConsumption(countMonth).then((trends) => {
          setState(() {
            _trendList = trends;
          })
        });
  }

  void _assignVisibility() {
    if (_trendList != null && _trendList.isNotEmpty) {
      for (Chart trend in _trendList) {
        trend.lineInvoice.visible = this.selected[0];
        trend.lineInvoice.color = Color(0xffa1c4d0);
        trend.lineInvoice.height = 16.0;
        trend.lineConsumption.visible = this.selected[1];
        trend.lineConsumption.color = Color(0xff1f414d);
        trend.lineConsumption.height = 2.0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    _reload();
    _assignVisibility();
    return MyCard(body: Column(children: <Widget>[_buildHeader(), _buildBody(), SizedBox(height: 10)]));
  }

  Widget _buildHeader() {
    return Padding(
        padding: EdgeInsets.only(top: 15, bottom: 10, left: 15, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyLabel(label: S.of(_context).lbl_consumption.toUpperCase(), fontSize: 18, fontWeight: FontWeight.w300, fontFamily: MyLabel.LIGHT),
            Container(
                height: 32,
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(8.1),
                  fillColor: Color(0xff6ba1b3),
                  children: <Widget>[
                    _buildSymbol(),
                    _buildUnit(_consumptionController.getMetersModel.unit),
                  ],
                  isSelected: selected,
                  onPressed: (int index) {
                    setState(() {
                      this.selected[index] = !this.selected[index];
                      FocusScope.of(context).requestFocus(new FocusNode());
                      //this._trendList = null;
                      //_initTrend();
                    });
                  },
                ))
          ],
        ));
  }

  Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 5),
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Container(
                  child: Row(children: <Widget>[
                MyLabel(label: S.of(_context).lbl_trend.toUpperCase(), fontSize: 12, fontWeight: FontWeight.w300, fontFamily: MyLabel.LIGHT),
                Image(image: new AssetImage("assets/images/ic_trend_down.png"), width: 35, height: 35)
              ])),
              Container(width: 120, child: _buildDropDown()),
            ]),
            SizedBox(height: 20),
            ChartTrendConsumption(trendList: _trendList, heightContainer: 190)
          ],
        ));
  }

  Widget _buildDropDown() {
    return MyMonthDropDown(
      shortText: true,
      showTitle: false,
      isDense: true,
      fontSize: 13,
      underlineColor: Colors.black,
      onChanged: (MonthSelectModel newValue) {
        setState(() {
          FocusScope.of(context).requestFocus(new FocusNode());
          this._trendList = null;
          _initTrend(newValue.countMonth);
        });
      },
    );
  }

  Widget _buildSymbol() {
    bool selectedItem = this.selected[0];
    Color colorText = selectedItem ? Color(0xfff2f2f2) : Color(0xff1f414d);
    return Padding(padding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10), child: MyLabel(label: "EUROS", color: colorText));
  }

  Widget _buildUnit(String unit) {
    String icon = TypeUnit.getIcon(unit);
    String label = TypeUnit.getUnit(unit);
    bool selectedItem = this.selected[1];
    Color colorText = selectedItem ? Color(0xfff2f2f2) : Color(0xff1f414d);
    return Padding(
        padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
        child: Row(
          children: <Widget>[
            icon != null ? ImageIcon(new AssetImage(icon), size: 9, color: colorText) : Container(),
            MyLabel(label: label.toUpperCase(), fontFamily: MyLabel.MEDIUM, fontSize: 12, fontWeight: FontWeight.w500, color: colorText),
          ],
        ));
  }
}
