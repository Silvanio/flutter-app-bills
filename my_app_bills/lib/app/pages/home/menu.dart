import 'package:flutter/material.dart';
import 'package:myAppBills/app/controllers/company_controller.dart';
import 'package:myAppBills/app/controllers/contracts_controller.dart';
import 'package:myAppBills/app/controllers/home_controller.dart';
import 'package:myAppBills/generated/l10n.dart';
import 'package:myAppBills/my_navigator.dart';
import 'package:myAppBills/style/login_style.dart';
import 'package:myAppBills/utils/convert.dart';

class Menu extends Drawer {
  final HomeController homeController;

  Menu({this.homeController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius:
            BorderRadius.only(topRight: const Radius.circular(10.0), bottomRight: const Radius.circular(10.0)),
        child: new Drawer(
          child: Column(
            children: <Widget>[
              new SizedBox(
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/banner.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  accountName: Text(
                    CompanyController.currentCompany.companyName,
                    style: kTextStyleBoldBlackTitle,
                  ),
                  accountEmail: Text(this.homeController.getLoginModel.company),
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
                    ),
                    Divider(),
                    new ListTile(
                        leading: ImageIcon((new AssetImage("assets/images/ic_contract.png"))),
                        title: Text(S.of(context).lbl_speel_contracts.toUpperCase()),
                        onTap: () => _openContracts(context)),
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

  void _openSettings(BuildContext context) {
    ContractsController controller = new ContractsController();
    controller.setLoginModel = homeController.getLoginModel;
    controller.setContractDetailModelList = homeController.getContractDetailModelList;
    Navigator.pop(context);
    MyNavigator.goToSettings(context, contractsController: controller);
  }
}
