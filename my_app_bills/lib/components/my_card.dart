import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCard extends Card {
  final String title;
  final String subTitle;
  final Color colorTitle;
  final Icon icon;
  final Widget body;
  final Image image;

  final GestureTapCallback onTap;

  MyCard({this.title, this.subTitle, this.body, this.onTap, this.colorTitle, this.icon, this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: InkWell(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _getTitle(),
                      _getDividerTitle(),
                      body
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
  Widget _getDividerTitle(){
    if(title == null || title.isEmpty){
      return Column();
    }
    return Divider();
  }

  Widget _getTitle(){
    if(title == null || title.isEmpty){
      return Column();
    }
    Color color = Colors.black26;
    if(color != null){
       color = colorTitle;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 5.0),
        _getIconOrImage(),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontFamily: 'OpenSans',
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _getIconOrImage(){
    if(icon != null){
      return icon;
    }else if(image != null){
      return image;
    }else{
      return Container();
    }
  }
}
