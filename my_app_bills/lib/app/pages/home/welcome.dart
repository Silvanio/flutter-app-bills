import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myutility/app/controllers/home_controller.dart';
import 'package:myutility/app/models/contract_detail_model.dart';
import 'package:myutility/app/models/contract_model.dart';
import 'package:myutility/app/models/login_model.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/my_navigator.dart';
import 'package:myutility/utils/convert.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  HomeController homeController;
  Uint8List _ImageLogo;
  String _welcomeMsg, _clientName;

  @override
  void initState() {
    super.initState();
    _initWelcome();
  }

  void _initWelcome() {
    homeController = new HomeController();
    homeController.getLoginBD().then((loginModel) => {_processWelcome(loginModel)});
    homeController.getWelcomeMsgByLang();
  }

  void _processWelcome(LoginModel loginModel) {
    homeController.setLoginModel = loginModel;
    homeController.listContracts().then((contractList) => {processContracts(contractList)});
  }

  void processContracts(List<ContractModel> contractList) async {
    List<ContractDetailModel> contractDetailList = new List<ContractDetailModel>();
    for (ContractModel model in contractList) {
      ContractDetailModel contractDetailModel = await homeController.getContractDetail(model);
      contractDetailModel.contract.accountNumber = model.accountNumber;
      contractDetailModel.contract.cil = model.cil;
      contractDetailModel.contract.clientName = model.clientName;
      contractDetailModel.contract.clientNumber = model.clientNumber;
      contractDetailModel.contract.address = model.address;
      contractDetailList.add(contractDetailModel);
    }
    homeController.setContractDetailModelList = contractDetailList;
    homeController.setContractDetailModel = contractDetailList.first;
    homeController.getCompanyBD().then((ok) => {_processScreenInfo()});
    Timer(Duration(seconds: 2), () => MyNavigator.goToHome(context, homeController: homeController));
  }

  void _processScreenInfo() async {
    setState(() {
      _ImageLogo = base64Decode(homeController.getCompanyModel.companyLogo);
      _welcomeMsg = homeController.getWelcomeMsg;
      _clientName = MyConvert.stringToCamelCase(
          this.homeController.getContractDetailModel.client.name.substring(0, this.homeController.getContractDetailModel.client.name.indexOf(' ')));
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: new Container(),
        )
      ],
    );

    double absoluteHeight = MediaQuery.of(context).size.height - appBar.preferredSize.height;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 40.0,
                ),
                height: absoluteHeight,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //SizedBox(height: 20.0),
                      _ImageLogo != null ? Image.memory(_ImageLogo, width: 220, alignment: Alignment.center) : new Container(),
                      SizedBox(height: 20.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _welcomeMsg != null
                              ? FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Center(
                                    child: new MyLabel(
                                        label: _welcomeMsg != null ? _welcomeMsg : '',
                                        fontFamily: MyLabel.MEDIUM,
                                        fontSize: 40,
                                        color: Color(0xff131315),
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              : Container(),
                          _clientName != null
                              ? FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Center(
                                    child: new MyLabel(
                                        label: _clientName != null ? _clientName : '',
                                        fontFamily: MyLabel.MEDIUM,
                                        fontSize: 40,
                                        color: Color(0xff131315),
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(height: 200.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/login_background.png"), fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
