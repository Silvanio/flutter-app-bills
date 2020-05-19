import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myutility/app/controllers/home_controller.dart';
import 'package:myutility/app/models/company_model.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/style/contact&warning_style.dart';

class LegalWarnings extends StatefulWidget {
  @override
  _LegalWarningsState createState() => _LegalWarningsState();
}

class _LegalWarningsState extends State<LegalWarnings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeController homeController;
  CompanyModel company;
  String _legalWarning;

  @override
  void initState() {
    super.initState();
    homeController = new HomeController();
    homeController.getLegalWarningByLang().then((warning) => {_setLegalWarning(warning)});
  }

  void _setLegalWarning(String warning) {
    setState(() {
      _legalWarning = homeController.getLegalWarning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.black, statusBarBrightness: Brightness.light),
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Container(
              decoration: kBoxRoundShadow,
              child: ListView(children: <Widget>[
                SizedBox(height: 10.0),
                _buildHeader(context),
                //SizedBox(height: 10.0),
                _buildBody(context),
                SizedBox(height: 10.0),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          new MyLabel(label: S.of(context).lbl_legal_warnings.toUpperCase(), fontFamily: MyLabel.REGULAR, fontSize: 18, fontWeight: FontWeight.w300),
          new IconButton(
            icon: ImageIcon(
              new AssetImage("assets/images/ic_close.png"),
              color: Colors.black,
              size: 40,
            ),
            tooltip: 'Return',
            onPressed: () => Navigator.pop(context),
          )
        ]),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: new SingleChildScrollView(
        child: _legalWarning != null ? new  MyLabel(label: _legalWarning, fontFamily: MyLabel.REGULAR, fontSize: 12, fontWeight:FontWeight.w300, height: 1.5,) : new Container(),
      ),
    );
  }
}
