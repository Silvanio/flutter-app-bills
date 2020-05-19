import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myutility/app/controllers/contracts_controller.dart';
import 'package:myutility/app/controllers/home_controller.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/my_navigator.dart';
import 'package:myutility/style/login_style.dart';
import 'package:myutility/utils/convert.dart';

class Menu extends Drawer {
  final HomeController homeController;

  Menu({this.homeController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: const Radius.circular(10.0), bottomRight: const Radius.circular(10.0)),
        child: new Drawer(
          child: Column(
            children: <Widget>[
              new SizedBox(
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(homeController.getCompanyModel.dashboardImg)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  accountName: Text(
                    homeController.getCompanyModel.companyName,
                    style: kTextStyleBoldBlackTitle,
                  ),
                  //accountName: Text(this.homeController.getContractDetailModel.client.name),
                  accountEmail: Text(this.homeController.getLoginModel.company),
                  /*currentAccountPicture:
                  CircleAvatar(
                    radius: 1,
                    backgroundColor: Colors.white,
                    child: Text(
                      this.homeController.getContractDetailModel.client.name.substring(0, 1),
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),*/
                ),
                height: 100,
              ),
              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    new ListTile(
                      leading: ImageIcon((new AssetImage("assets/images/ic_profile.png"))),
                      title: Text(MyConvert.stringToCamelCase(S.of(context).lbl_hi) +
                          MyConvert.stringToCamelCase(this
                              .homeController
                              .getContractDetailModel
                              .client
                              .name
                              .substring(0, this.homeController.getContractDetailModel.client.name.indexOf(' ')))),
                      //onTap: () => _openContracts(context)
                    ),
                    Divider(),
                    new ListTile(
                        leading: ImageIcon((new AssetImage("assets/images/ic_contract.png"))),
                        title: Text(S.of(context).lbl_speel_contracts.toUpperCase()),
                        onTap: () => _openContracts(context)),
                    //Divider(),
                    new ListTile(
                        leading: ImageIcon((new AssetImage("assets/images/ic_contact.png"))),
                        title: Text(S.of(context).lbl_contacts.toUpperCase()),
                        onTap: () => _openContacts(context)),
                    //Divider(),
                    //new ListTile(leading: ImageIcon(new AssetImage("assets/images/ic_aviso_legal.png")), title: Text(S.of(context).lbl_legal_warnings.toUpperCase()), onTap: () => _openLegalWarnings(context)),
                    //Divider(),
                    new ListTile(
                        leading: ImageIcon((new AssetImage("assets/images/ic_settings.png"))),
                        title: Text(S.of(context).lbl_settings.toUpperCase()),
                        onTap: () => _openSettings(context)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(
                      height: 200,
                    ),
                    InkWell(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageIcon(
                              new AssetImage("assets/images/ic_close.png"),
                              color: Color(0xAAAAAAAA),
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              S.of(context).lbl_logout.toUpperCase(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        onTap: () => {
                              homeController.logout().then((ok) => {MyNavigator.goToLogin(context)})
                            }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openContracts(BuildContext context) {
    ContractsController controller = new ContractsController();
    controller.setLoginModel = homeController.getLoginModel;
    controller.setContractDetailModelList = homeController.getContractDetailModelList;
    Navigator.pop(context);
    MyNavigator.goToContractList(context, contractsController: controller);
  }

  void _openContacts(BuildContext context) {
    Navigator.pop(context);
    MyNavigator.goToContacts(context);
  }

  void _openSettings(BuildContext context) {
    ContractsController controller = new ContractsController();
    controller.setLoginModel = homeController.getLoginModel;
    controller.setContractDetailModelList = homeController.getContractDetailModelList;
    Navigator.pop(context);
    MyNavigator.goToSettings(context, contractsController: controller);
  }
}
