import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myutility/app/controllers/company_controller.dart';
import 'package:myutility/app/models/company_model.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/style/contact&warning_style.dart';
import 'package:myutility/style/login_style.dart';

class Contacts extends StatefulWidget {
  final CompanyController companyController;
  Contacts({this.companyController});

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  CompanyController companyController;
  List<CompanyContactModel> _companyContactList;

  @override
  void initState() {
    super.initState();

    companyController = new CompanyController();
    companyController.getCompanyContactListBD().then((_companyContactList) =>
        {_processCompanyContactData(_companyContactList)});
  }

  void _processCompanyContactData(
      List<CompanyContactModel> companyContactList) async {
    if (companyContactList != null) {
      setState(() {
        _companyContactList = companyContactList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: _titleBar(),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: _companyContactList != null
                      ? _contactList(context, _companyContactList)
                      : Container()),
              //SizedBox(height: 10.0),
              /// para inserir depois
              /*Expanded(
                      child: _mapContainer(context)
                  ),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactList(BuildContext context,
      [List<CompanyContactModel> _companyContactList]) {
    return Container(
        decoration: kBoxRoundShadow,
        child: ListView(
          children: <Widget>[
            //_buildHeader(context),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _companyContactList.length,
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ImageIcon(new AssetImage("assets/images/ic_localization.png"), size: 40, color: Colors.black,),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                              MyLabel(
                                label: S.of(context).lbl_sPhone + ': ' + _companyContactList[index].contact,
                                fontFamily: MyLabel.REGULAR,
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.2,
                              ),
                              MyLabel(
                                label: S.of(context).lbl_contracts_email + ': ' + _companyContactList[index].email,
                                fontFamily: MyLabel.REGULAR,
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.2,
                              ),
                              MyLabel(
                                label: S.of(context).lbl_opening_hours + ': ' + _companyContactList[index].opening_hours,
                                fontFamily: MyLabel.REGULAR,
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.2,
                              ),
                              MyLabel(
                                label: S.of(context).lbl_contracts_address + ': ' + _companyContactList[index].address.replaceAll('|', '\n'),
                                fontFamily: MyLabel.REGULAR,
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.2,
                              ),

                              /*Text(
                                S.of(context).lbl_sPhone + ': ' + _companyContactList[index].contact + '\n' +
                                    S.of(context).lbl_contracts_email + ': ' + _companyContactList[index].email + '\n' +
                                    S.of(context).lbl_opening_hours + ': ' + _companyContactList[index].opening_hours + '\n' +
                                    S.of(context).lbl_contracts_address + ': ' + _companyContactList[index].address.replaceAll('|', '\n'),
                                style:kTextSyleBlack),*/
                            ],
                          ),


                            ],
                          )


                        /*ListTile(
                          leading: ImageIcon(new AssetImage("assets/images/ic_localization.png"), size: 40,),
                          /*title: Text(
                            S.of(context).lbl_store + (index+1).toString(),
                            style:kTextSyleGreyTitle),*/
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              MyLabel(
                                label: S.of(context).lbl_sPhone + ': ' + _companyContactList[index].contact,
                                fontFamily: MyLabel.REGULAR,
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.2,
                              ),
                              MyLabel(
                                label: S.of(context).lbl_contracts_email + ': ' + _companyContactList[index].email,
                                fontFamily: MyLabel.REGULAR,
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.2,
                              ),
                              MyLabel(
                                label: S.of(context).lbl_opening_hours + ': ' + _companyContactList[index].opening_hours,
                                fontFamily: MyLabel.REGULAR,
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.2,
                              ),
                              MyLabel(
                                label: S.of(context).lbl_contracts_address + ': ' + _companyContactList[index].address.replaceAll('|', '\n'),
                                fontFamily: MyLabel.REGULAR,
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.2,
                              ),

                              /*Text(
                                S.of(context).lbl_sPhone + ': ' + _companyContactList[index].contact + '\n' +
                                    S.of(context).lbl_contracts_email + ': ' + _companyContactList[index].email + '\n' +
                                    S.of(context).lbl_opening_hours + ': ' + _companyContactList[index].opening_hours + '\n' +
                                    S.of(context).lbl_contracts_address + ': ' + _companyContactList[index].address.replaceAll('|', '\n'),
                                style:kTextSyleBlack),*/
                            ],
                          ),
                        ),*/


                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }

  Widget _mapContainer(BuildContext context) {
    return Container(
      decoration: kBoxRoundShadow,
      child: Center(
        child: Text('Coming Soon', style: kTextSyleGreyTitle),
      ),
    );
  }

  /*Widget _buildHeader(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          new Text(
            S.of(context).lbl_contacts.toUpperCase(),
            maxLines: 1,
            style: kTextStyleBoldBlackTitle,
          ),
          new IconButton(
            icon: ImageIcon(new AssetImage("assets/images/ic_close.png"),color: Color(0xAAAAAAAA),),
            tooltip: 'Return',
            onPressed: () => Navigator.pop(context),
          )
        ]),
      ),
    );
  }*/

  Widget _titleBar() {
    return MyLabel(
      label: S.of(context).lbl_contacts.toUpperCase(),
      fontFamily: MyLabel.MEDIUM,
      fontWeight: FontWeight.w300,
      fontSize: 20,
      color: Colors.black,
      height: 1.2,
    );
  }
}
