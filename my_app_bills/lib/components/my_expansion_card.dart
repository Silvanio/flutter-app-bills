import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyExpansionCard extends StatefulWidget {
  @required
  final Widget header;
  @required
  final List<Widget> bodyChildren;
  final Widget headerExpanded;
  final bool isExpanded;
  final bool isCard;

  MyExpansionCard({this.header, this.bodyChildren, this.headerExpanded, this.isExpanded = false, this.isCard = true});

  @override
  MyExpansionCardState createState() {
    return new MyExpansionCardState();
  }
}

class MyExpansionCardState extends State<MyExpansionCard> {
  bool isExpanded;
  Widget headerExpanded;

  @override
  void initState() {
    super.initState();
    this.isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    headerExpanded = widget.headerExpanded == null ? widget.header : widget.headerExpanded;
    Widget widgetExpand = widget.isCard ? _buildCard() : _buildTile();
    return Theme(data: themeData, child: widgetExpand);
  }

  Widget _buildCard() {
    return Card(
        elevation: 2, clipBehavior: Clip.antiAlias, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)), child: _buildTile());
  }

  Widget _buildTile() {
    return ExpansionTile(
        initiallyExpanded: isExpanded,
        trailing: Padding(
            padding: EdgeInsets.all(0),
            child: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Color(0xff1f414d), size: 25)),
        title: Padding(padding: EdgeInsets.only(top: 5, bottom: 10), child: isExpanded ? headerExpanded : widget.header),
        children: widget.bodyChildren,
        onExpansionChanged: (value) {
          setState(() {
            this.isExpanded = value;
          });
        });
  }
}
