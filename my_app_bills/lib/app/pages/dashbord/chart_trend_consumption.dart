import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myAppBills/components/my_divider_dotted.dart';
import 'package:myAppBills/components/my_label.dart';
import 'package:myAppBills/utils/convert.dart';
import 'package:myAppBills/utils/type_unit.dart';

class ChartTrendConsumption extends StatefulWidget {
  final List<Chart> trendList;
  final double heightContainer;

  ChartTrendConsumption({this.trendList, this.heightContainer});

  @override
  ChartTrendConsumptionState createState() {
    return new ChartTrendConsumptionState();
  }
}

class ChartTrendConsumptionState extends State<ChartTrendConsumption> {
  List<Chart> trendList;
  double heightContainer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.trendList = widget.trendList;

    heightContainer = widget.heightContainer== null? 190: widget.heightContainer;

    if (trendList == null) {
      return _buildCircularProgress();
    }

    if (trendList.isEmpty) {
      return  Container(height: heightContainer);
    }

    return Container(
        height: heightContainer,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, position) {
            return _buildContainer(trendList.elementAt(position));
          },
          separatorBuilder: (context, position) {
            return SizedBox(height: 15);
          },
          itemCount: trendList.length,
        ));
  }

  Widget _buildContainer(Chart model) {
    String month = MyConvert.formatDatePattern(model.date, "MMM").toUpperCase();

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double boxWidth = constraints.constrainWidth()/2;
      double boxDotted = boxWidth + 100;
      return Container(
        child: Row(
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[MyLabel(label: month, fontSize: 10)]),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildLineInvoice(model, boxWidth),
                SizedBox(height: 10),
                _buildLinesConsumption(model, boxWidth),
                SizedBox(height: 10),
                Container(
                  width: boxDotted,
                  child: MyDividerDotted(
                    color: Colors.grey,
                    height: 0.3,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
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

  Widget _buildLineInvoice(Chart model, double boxWidth) {
    if (!model.lineInvoice.visible) {
      return Container();
    }
    double width = (model.lineInvoice.percentageValue * boxWidth) / 100;
    width = width.roundToDouble();
    String moneyValue = MyConvert.formatMoney(model.lineInvoice.value);
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Color(0xffa1c4d0),
            borderRadius: BorderRadius.circular(16.0),
          ),
          width: width,
          height: model.lineInvoice.height,
        ),
        SizedBox(width: 4),
        MyLabel(label: moneyValue, fontSize: 10, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w500, color: Color(0xff6ba1b3)),
        SizedBox(width: 1),
        MyLabel(label: model.lineInvoice.suffixValue, fontSize: 10, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w500, color: Color(0xff6ba1b3))
      ],
    );
  }

  Widget _buildLinesConsumption(Chart model, double boxWidth) {
    if (!model.lineConsumption.visible) {
      return Container();
    }
    return _buildLineConsumption(model.lineConsumption, boxWidth);
  }

  Widget _buildLineConsumption(ChartLine lineConsumption, double boxWidth) {
    double width = (lineConsumption.percentageValue * boxWidth) / 100;
    width = width.roundToDouble();
    String consumptionValue = lineConsumption.value.toInt().toString();
    return Row(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xff1f414d),
        ),
        width: width, //91
        height: lineConsumption.height, //2
      ),
      SizedBox(width: 1),
      ImageIcon(new AssetImage(TypeUnit.getIcon(lineConsumption.suffixImage)), size: 9, color: Color(0xff1f414d)),
      SizedBox(width: 4),
      MyLabel(label: consumptionValue, fontSize: 10, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w500),
      SizedBox(width: 1),
      MyLabel(label: TypeUnit.getUnit(lineConsumption.suffixValue), fontSize: 10, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w500)
    ]);
  }
}

class ChartLine {
  double height;
  String suffixImage;
  int percentageValue;
  double value;
  String suffixValue;
  Color color;
  bool visible;
  DateTime date;
}

class Chart {
  DateTime date;
  ChartLine lineInvoice;
  ChartLine lineConsumption;
}
