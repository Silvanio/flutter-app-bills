import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myutility/app/controllers/home_controller.dart';
import 'package:myutility/app/controllers/invoice_controller.dart';
import 'package:myutility/app/controllers/reading_controller.dart';
import 'package:myutility/app/models/contract_detail_model.dart';
import 'package:myutility/app/pages/home/contract_dropdown.dart';
import 'package:myutility/app/pages/dashbord/dashbord.dart';
import 'package:myutility/app/pages/home/menu.dart';
import 'package:myutility/app/pages/invoices/invoice.dart';
import 'package:myutility/app/pages/readings/readings.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog globalProgressDialog;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController;  /// proveniente da class menu e MyNavigator, é passado por argumento
  int _currentIndex;
  Widget _currentWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (homeController == null) {
      _createStateController();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        brightness: Brightness.light,
        flexibleSpace: getImageBanner(),
        backgroundColor: Colors.white,
        title: _titleHome(),
        titleSpacing: 0.0,
        leading: _builderLeading(),
        bottom: _buildContractCard(),
      ),
      drawer: Menu(homeController: homeController),
      body: _currentWidget,
      backgroundColor: Color(0xffF2F2F2),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  void _createStateController() {
    homeController = ModalRoute.of(context).settings.arguments;
    homeController.getCompanyBD();
    _currentIndex = 0;
    _currentWidget = DashBord(homeController: homeController);
    _getProgressBar();
  }

  void onTabTapped(int index) {
    _showProgress();
    setState(() {
      switch (index) {
        case 0:
          {
            _openDashBord(index);
            break;
          }
        case 1:
          {
            _openReadings(index);
            break;
          }
        case 2:
          {
            _openInvoices(index);
            break;
          }
        default:
          {
            _openDashBord(index);
            break;
          }
      }
    });
    _hideProgress();
  }

  void _openDashBord(index) {
    _currentIndex = index;
    _currentWidget = DashBord(homeController: homeController);
  }

  void _openReadings(index) {
    ReadingController readingController = new ReadingController();
    readingController.setLoginModel = homeController.getLoginModel;
    readingController.setContractModel = homeController.getContractDetailModel;
    _currentIndex = index;
    _currentWidget = Readings(readingController: readingController);
  }

  void _openInvoices(index) {
    InvoiceController invoiceController = new InvoiceController();
    invoiceController.setLoginModel = homeController.getLoginModel;
    invoiceController.setContractDetailModel = homeController.getContractDetailModel;
    _currentIndex = index;
    _currentWidget = Invoice(invoiceController: invoiceController);
  }

  void _changeContract(ContractDetailModel contractValue) {
    homeController.setContractDetailModel = contractValue;
    onTabTapped(_currentIndex);
  }

  Widget _titleHome() {

    return MyLabel(
        label: homeController.getCompanyModel.companyName,
        fontFamily: MyLabel.MEDIUM,
        fontSize: 20,
        color: Color(0xff131315),
        fontWeight: FontWeight.w300);
  }

  Widget getImageBanner() {
    return homeController.getCompanyModel != null
        ? Image.memory(
      base64Decode(homeController.getCompanyModel.dashboardImg),
      fit: BoxFit.fill,
      height: 85,
    )
        : new Container();
  }

  Widget _builderLeading() {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Image(
            image: AssetImage('assets/images/ic_menu.png'),
            width: 25,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    );
  }


  Widget _buildContractCardOutside() {
    return Container(
      height: 80.0,
      alignment: Alignment.center,
      child: Padding(
          padding: EdgeInsets.only(left: 5, right: 10),
          child: ContractDropDown(
            list: homeController.getContractDetailModelList,
            selected: homeController.getContractDetailModel,
            onChanged: (ContractDetailModel newValue) {
              FocusScope.of(context).requestFocus(new FocusNode());
              _changeContract(newValue);
            },
          )),
    );
  }

  Widget _buildContractCard() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.white),
        child: Container(
          height: 80.0,
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.only(left: 5, right: 10),
              child: ContractDropDown(
                list: homeController.getContractDetailModelList,
                selected: homeController.getContractDetailModel,
                onChanged: (ContractDetailModel newValue) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  _changeContract(newValue);
                },
              )),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return new Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 13.0, // soften the shadow
            spreadRadius: 8.0, //extend the shadow
            offset: Offset(
              12.0, // Move to right 10  horizontally
              12.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Color(0xff1f414d),
        items: [
          BottomNavigationBarItem(
              title: MyLabel(label: S.of(context).lbl_menu_home, fontFamily: MyLabel.MEDIUM, fontWeight: FontWeight.w500, fontSize: 14),
              icon: ImageIcon(new AssetImage("assets/images/ic_home.png"))),
          BottomNavigationBarItem(
              title: MyLabel(label: S.of(context).lbl_menu_readings, fontFamily: MyLabel.MEDIUM, fontWeight: FontWeight.w500, fontSize: 14),
              icon: ImageIcon(new AssetImage("assets/images/ic_reading.png"))),
          BottomNavigationBarItem(
              title: MyLabel(label: S.of(context).lbl_menu_invoices, fontFamily: MyLabel.MEDIUM, fontWeight: FontWeight.w500, fontSize: 14),
              icon: ImageIcon(new AssetImage("assets/images/ic_invoices.png")))
        ],
      ),
    );
  }

  void _getProgressBar() {
    globalProgressDialog = new ProgressDialog(context, type: ProgressDialogType.Normal);
    globalProgressDialog.style(
        message: S.of(context).msg_please_wait,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }

  void _showProgress() {
    globalProgressDialog.show();
  }

  void _hideProgress() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      globalProgressDialog.hide();
    });
  }

}
