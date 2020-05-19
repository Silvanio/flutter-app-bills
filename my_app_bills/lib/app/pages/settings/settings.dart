import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myutility/app/controllers/company_controller.dart';
import 'package:myutility/app/controllers/contracts_controller.dart';
import 'package:myutility/components/my_card.dart';
import 'package:myutility/components/my_expansion_card.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_navigator.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  CompanyController companyController;
  ContractsController contractsController;/// proveniente da class menu, é passado por argumento

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<Locale> _localeList;
  List<String> _localeLString = [];
  int _groupValueMarketing = 0, _groupValue1ThirdParty = 1;

  String _gdprMarketingText, _gdprThirdPartyText;
  bool _gdprMarketingVal, _gdprThirdPartyVal;

  @override
  void initState() {
    super.initState();

    companyController = new CompanyController();

    _populateLocaleValues();
    //_getPrivacyTexts(); /// colocado no build para dar refresh sempre que se troca a linguagem neste ecra
    _initPackageInfo();/// versao da app
  }

  void _populateLocaleValues() {
    _localeList = S.delegate.supportedLocales;
    for (int i = 0; i < _localeList.length; i++) {
      _localeLString.add(S.delegate.supportedLocales[i].languageCode.toString());
    }
  }

  void _getPrivacyTexts() {
    companyController.getGdprMarketingText().then((text) => {

          setState(() {
            _gdprMarketingText = companyController.getgdprMarketing;
          })
        });
    companyController.getGdprThirdPartyText().then((text) => {

          setState(() {
            _gdprThirdPartyText = companyController.getgdprThirdParty;
          })
        });
  }


  @override
  Widget build(BuildContext context) {
    contractsController = ModalRoute.of(context).settings.arguments;
    var list = contractsController.getContractDetailModelList;
    _gdprMarketingVal = list[0].gdprMarketing;
    _gdprThirdPartyVal = list[0].gdprThirdParty;

    if (_gdprMarketingVal == false) {
      _groupValueMarketing = 1; // 0 = sim | 1 = não
    } else _groupValueMarketing = 0;

    if (_gdprThirdPartyVal == false) {
      _groupValue1ThirdParty = 1; // 0 = sim | 1 = não
    } else _groupValue1ThirdParty = 0;

    _getPrivacyTexts();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: _titleBar(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: MyCard(
                body: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(children: <Widget>[
                      _buildLanguages(),
                      Divider(endIndent: 15, indent: 15, color: Color(0xffe0e0e0)),
                      _buildPriv(companyController),
                      Divider(endIndent: 15, indent: 15, color: Color(0xffe0e0e0)),
                      _buildLegalWarnings(),
                      Divider(endIndent: 15, indent: 15, color: Color(0xffe0e0e0)),
                      _buildAbout()
                    ])))),
      )),
    );
  }

  Widget _buildLanguages() {
    return MyExpansionCard(
      header: _getHeader(S.of(context).lbl_lang.toUpperCase(), false),
      isCard: false,
      bodyChildren: <Widget>[_getLangBody()],
    );
  }

  Widget _getLangBody() {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: ListView(
        children: _localeLString
            .map((text) => RadioListTile(
                  groupValue: Intl.getCurrentLocale(),
                  activeColor: Colors.black,
                  title: Text(text.toUpperCase()),
                  value: text,
                  onChanged: (val) {
                    setState(() {
                      for (int i = 0; i < _localeLString.length; i++) {
                        if (val == _localeLString[i]) {
                          debugPrint('val : ' + val + ' getCurrentLocale: ' + Intl.getCurrentLocale());
                          S.load(Locale(val));
                          _saveNewLangSP(val);
                            //_getPrivacyTexts();
                        }
                      }
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPriv(CompanyController companyController) {
    String texto1, texto2, texto3;
    texto1 =
        'Lorem ipsum dolor sit amet, amet sint dolores vel in. In option propriae rationibus nec, his cu exerci utroque gubergren. Suas vocent graecis ex sed. Sed ei regione fastidii delicatissimi. Eum in decore deseruisse, nam facilis similique in.';
    texto2 = _gdprMarketingText;
    texto3 = _gdprThirdPartyText;

    return MyExpansionCard(
      header: _getHeader(S.of(context).lbl_privacy.toUpperCase(), false),
      isCard: false,
      bodyChildren: <Widget>[
        /*Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: MyLabel(label: texto1, fontFamily: MyLabel.REGULAR, fontSize: 15),
        ),
        SizedBox(height: 10),*/
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: MyLabel(label: texto2, fontFamily: MyLabel.REGULAR, fontSize: 15),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: _myRadioButton(
                title: S.of(context).lbl_yes,
                value: 0,
                onChanged: null /*(newValue) => setState(() => _groupValue = newValue)*/,
              ),
            ),
            Expanded(
              child: _myRadioButton(
                title: S.of(context).lbl_no,
                value: 1,
                onChanged: null /*(newValue) => setState(() => _groupValue = newValue)*/,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: MyLabel(label: texto3, fontFamily: MyLabel.REGULAR, fontSize: 15),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: _myRadioButton1(
                title: S.of(context).lbl_yes,
                value: 0,
                onChanged: null /*(newValue) => setState(() => _groupValue1 = newValue)*/,
              ),
            ),
            Expanded(
              child: _myRadioButton1(
                title: S.of(context).lbl_no,
                value: 1,
                onChanged: null /*(newValue) => setState(() => _groupValue1 = newValue)*/,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      activeColor: Colors.black,
      groupValue: _groupValueMarketing,
      onChanged: onChanged,
      title: MyLabel(label: title, fontFamily: MyLabel.REGULAR, fontSize: 15),
    );
  }

  Widget _myRadioButton1({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      activeColor: Colors.black,
      groupValue: _groupValue1ThirdParty,
      onChanged: onChanged,
      title: MyLabel(label: title, fontFamily: MyLabel.REGULAR, fontSize: 15),
    );
  }

  Widget _buildLegalWarnings() {
    return ExpansionTile(
        initiallyExpanded: false,
        trailing: Padding(padding: EdgeInsets.all(0), child: Icon(null)),
        title: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 10),
          child: _getHeader(S.of(context).lbl_legal_warnings.toUpperCase(), true),
        ),
        onExpansionChanged: (value) {
          setState(() {
            Navigator.pop(context);
            MyNavigator.goToLegalWarnings(context);
          });
        });
  }

  Widget _buildAbout() {
    return MyExpansionCard(
      header: _getHeader(S.of(context).lbl_about.toUpperCase(), false),
      isCard: false,
      bodyChildren: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Align(
              alignment: Alignment.centerLeft,
              child: MyLabel(label: 'v.' + _packageInfo.version, fontFamily: MyLabel.REGULAR, fontSize: 15)),
        ),
      ],
    );
  }

  Widget _getHeader(String label, bool isUnderlined) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyLabel(
                label: label,
                fontFamily: MyLabel.LIGHT,
                fontSize: 20,
                fontWeight: FontWeight.w300,
                decoration: isUnderlined == true ? TextDecoration.underline : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _titleBar() {
    return MyLabel(
      label: S.of(context).lbl_settings.toUpperCase(),
      fontFamily: MyLabel.MEDIUM,
      fontWeight: FontWeight.w300,
      fontSize: 20,
      color: Colors.black,
      height: 1.2,
    );
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _saveNewLangSP(String newLang) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("currLang", newLang);
    debugPrint('Value After save SP: ' + newLang);
  }
}
