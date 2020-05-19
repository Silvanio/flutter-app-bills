import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myutility/app/controllers/reading_controller.dart';
import 'package:myutility/app/models/contract_detail_model.dart';
import 'package:myutility/app/models/meters_model.dart';
import 'package:myutility/app/models/reading_model.dart';
import 'package:myutility/app/pages/readings/card_reading_history.dart';
import 'package:myutility/components/my_button.dart';
import 'package:myutility/components/my_card.dart';
import 'package:myutility/components/my_label.dart';
import 'package:myutility/generated/l10n.dart';
import 'package:myutility/utils/convert.dart';
import 'package:myutility/utils/dialog_util.dart';
import 'package:myutility/utils/type_unit.dart';

class Readings extends StatefulWidget {
  final ReadingController readingController;

  Readings({this.readingController});

  @override
  _ReadingsState createState() => _ReadingsState();
}

class _ReadingsState extends State<Readings> {
  ReadingController readingController;
  StreamController<MetersModel> _eventsMeters;
  StreamController<MetersModel> _eventsReading;
  String dateLastReading;

  List<TextEditingController> _controllers = new List();

  BuildContext _context;
  ContractDetailModel _lastContract;

  @override
  void initState() {
    super.initState();
    _createState();
  }

  void _createState() {
    _eventsMeters = new StreamController<MetersModel>();
    _eventsReading = new StreamController<MetersModel>();
    readingController = widget.readingController;
    _lastContract = readingController.getContractDetailModel;
    readingController
        .listAllMeters()
        .then((metersList) => {_eventsMeters.add(metersList.first), _eventsReading.add(metersList.first), _getListReadings(metersList.first)});
  }

  void _getListReadings(MetersModel metersModel) {
    readingController.listReadingsByMeters(12, metersModel).then((readingsList) => {_getInfoLastReading(readingsList)});
  }

  void _getInfoLastReading(List<ReadingModel> readings) {
    if (readings != null && readings.isNotEmpty) {
      ReadingModel model = readings.first;
      String dateLastReading = MyConvert.formatDatePattern(model.readingDate, "dd/MM/yyyy");
      setState(() {
        dateLastReading = MyConvert.stringToCamelCase(dateLastReading);
      });
    }
  }

  void clearControllers() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_controllers.isNotEmpty) {
      for (TextEditingController controller in _controllers) {
        controller.clear();
      }
    }
  }

  void _reBuild() {
    this._context = context;
    readingController = widget.readingController;
    if (_lastContract.contract.cil != readingController.getContractDetailModel.contract.cil) {
      _createState();
    }
  }

  @override
  Widget build(BuildContext context) {
    _reBuild();
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(children: <Widget>[SizedBox(height: 10), _buildContainer(), _buildReadings()])),
    );
  }

  Widget _buildForm() {
    return StreamBuilder(
        stream: _eventsMeters.stream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          return Form(
              key: readingController.formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  _buildMessageCommunicate(context),
                  SizedBox(height: 20),
                  _buildWidgetCil(context),
                  SizedBox(height: 20),
                  _buildMessageTypeProduct(snapshot.data),
                  SizedBox(height: 40),
                  _buildInputReadings(snapshot.data),
                  SizedBox(height: 15),
                  _buildButtons(context),
                  SizedBox(height: 20),
                  _buildRowLasRealReading(context),
                  SizedBox(height: 10)
                ],
              ));
        });
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: new InkWell(
            child: MyLabel(label: S.of(context).lbl_cancel.toUpperCase(), color: Colors.grey, fontSize: 13, fontFamily: MyLabel.MEDIUM, fontWeight: FontWeight.w500),
            onTap: () => {clearControllers()},
          ),
        ),
        SizedBox(width: 15),
        Container(
            width: 140,
            child: MyButton(
              label: S.of(context).lbl_communicate.toUpperCase(),
              onPressed: () => {validSendReading()},
              buttonColor: Colors.white,
              fontSize: 13,
              borderColor: Color(0xff1f414d),
              labelColor: Color(0xff1f414d),
              elevation: 0.0,
            )),
      ],
    );
  }

  Widget _buildInputReadings(MetersModel model) {
    readingController.initReadingValues(model);
    double heightContainer = readingController.readingModelList.length * 40.0;
    return Container(
      height: heightContainer,
      child: ListView.builder(
          itemCount: readingController.readingModelList.length,
          itemBuilder: (context, index) {
            if (readingController.readingModelList.isEmpty) {
              return CircularProgressIndicator();
            } else {
              TextEditingController controller = new TextEditingController();
              _controllers.add(controller);
              return Padding(
                  padding: EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        cursorColor: Color(0xff1f414d),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color(0xff1f414d), fontSize: 30, fontFamily: MyLabel.LIGHT, fontWeight: FontWeight.w500, letterSpacing: 12),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.only(right: 20),
                          hintText: mountTextPadLeft("", "0", model.digits),
                          hintStyle: TextStyle(
                            color: Color(0xffdddbdd),
                            fontSize: 30,
                            fontFamily: MyLabel.LIGHT,
                            fontWeight: FontWeight.w100,
                            letterSpacing: 12,
                          ),
                          //contentPadding: EdgeInsets.all(0),
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffdddbdd),
                            ),
                          ),
                          focusedBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffdddbdd),
                            ),
                          ),
                        ),

                        textDirection: TextDirection.rtl,
                        onChanged: (value) => changeText(value, controller, model.digits),
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          new LengthLimitingTextInputFormatter(model.digits + 1)
                        ],
                        //keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: validRequiredField,
                        onSaved: (value) => readingController.readingModelList[index].value = MyConvert.parseDouble(value, 0),
                        controller: controller,
                      )),
                      ImageIcon(new AssetImage(TypeUnit.getIcon(model.unit)), size: 10, color: Color(0xff1f414d)),
                      SizedBox(width: 1),
                      MyLabel(label: TypeUnit.getUnit(model.unit), fontSize: 11, fontFamily: MyLabel.MEDIUM, fontWeight: FontWeight.w500)
                    ],
                  ));
            }
          }),
    );
  }

  String mountTextPadLeft(String value, String textComplete, int count) {
    value = value.toString().padLeft(count, textComplete);
    return value;
  }

  void changeText(String value, TextEditingController controller, int digits) {
    int valueInt = MyConvert.parseInt(value, 0);
    value = valueInt.toString();
    if (value.length > digits) {
      value = value.substring(0, value.length - 1);
    }

    value = mountTextPadLeft(value, "0", digits);
    if (value != controller.text) {
      controller.text = value;
      controller.selection = new TextSelection(baseOffset: value.length, extentOffset: value.length);
    }
  }

  Widget _buildMessageTypeProduct(MetersModel model) {
    String value = model.productDesc == null ? "" : S.of(context).msg_insert_reading(model.productDesc);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      MyLabel(label: value, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: MyLabel.REGULAR),
    ]);
  }

  Widget _buildMessageCommunicate(BuildContext context) {
    return MyLabel(
        label: S.of(context).msg_communicate_reading_between(readingController.initialDate, readingController.finalDate),
        fontSize: 12,
        fontFamily: MyLabel.REGULAR,
        color: Colors.grey);
  }

  Widget _buildWidgetCil(BuildContext context) {
    return Row(children: <Widget>[
      MyLabel(label: S.of(context).lbl_place_consumption + " - ", fontSize: 14, fontWeight: FontWeight.w400, fontFamily: MyLabel.REGULAR),
      MyLabel(label: readingController.getContractDetailModel.contract.cil, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: MyLabel.REGULAR),
    ]);
  }

  Widget _buildRowLasRealReading(BuildContext context) {
    if (dateLastReading == null) {
      return Container();
    }

    return Row(
      children: <Widget>[
        MyLabel(label: S.of(context).msg_last_real_reading((dateLastReading)), fontSize: 12, fontFamily: MyLabel.REGULAR, color: Colors.grey),
      ],
    );
  }

  Widget _buildContainer() {
    return MyCard(
        body: Padding(
            padding: EdgeInsets.only(top: 15, bottom: 0, left: 15, right: 15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[_buildHeader(), _buildForm(), SizedBox(height: 10)])));
  }

  Widget _buildHeader() {
    return MyLabel(label: S.of(context).msg_communicate_reading.toUpperCase(), fontSize: 18, fontWeight: FontWeight.w400, fontFamily: MyLabel.LIGHT);
  }

  Widget _buildReadings() {
    return StreamBuilder(
        stream: _eventsReading.stream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          readingController.setMetersModel = snapshot.data;
          return Padding(
              padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5),
              child: CardReadingHistory(
                readingController: readingController,
              ));
        });
  }

  void validSendReading() {
    if (readingController.formKey.currentState.validate()) {
      readingController.formKey.currentState.save();
      bool warningValue = readingController.validSendReadingValue();
      // bool warningDate = readingController.validSendReadingDate();
      bool warningDate = false;
      if (warningValue) {
        _showDialogSendMessage(S.of(context).msg_reading_send_warning_value);
      } else if (warningDate) {
        _showDialogSendMessage(S.of(context).msg_reading_send_warning_value);
      } else {
        _sendReading(false, S.of(context).msg_reading_send_success);
      }
    }
  }

  void _showDialogSendMessage(String message) {
    Widget link = new Center(
      child: new InkWell(
        child:
        MyLabel(label: S.of(context).lbl_cancel.toUpperCase(), color: Colors.grey, fontSize: 13, fontFamily: MyLabel.MEDIUM, fontWeight: FontWeight.w500),
        onTap: () => {Navigator.of(context).pop()},
      ),
    );
    Widget divider = SizedBox(width: 12);
    Widget confirm = Container(
        width: 130,
        child: MyButton(
          label: S.of(context).lbl_communicate.toUpperCase(),
          onPressed: () => {Navigator.of(context).pop(), _sendReading(true, message)},
          buttonColor: Colors.white,
          fontSize: 13,
          borderColor: Color(0xff1f414d),
          labelColor: Color(0xff1f414d),
          elevation: 0.0,
        ));

    List<Widget> actions = new List<Widget>();
    actions.add(link);
    actions.add(divider);
    actions.add(confirm);
    DialogUtil.confirmationMessage(_context, S.of(context).lbl_dialog_confirm_reading, S.of(context).msg_reading_send_confirm, actions: actions);
  }

  void _sendReading(bool warning, String message) async {
    bool ok = await readingController.sendReading().catchError((e) {
      DialogUtil.errorMessage(_context, S.of(context).lbl_dialog_confirm_reading, S.of(context).msg_reading_error_send_reading);
    });
    clearControllers();
    if (ok && warning) {
      DialogUtil.alertMessage(_context, S.of(context).lbl_dialog_confirm_reading, message);
    } else if (ok && !warning) {
      DialogUtil.successMessage(_context, S.of(context).lbl_dialog_confirm_reading, message);
    } else {
      DialogUtil.alertMessage(_context, S.of(context).lbl_dialog_confirm_reading, S.of(context).msg_reading_error_send_reading);
    }
  }

  String validRequiredField(String value) {
    if (value.length == 0) {
      return "";
    }
    if (!MyConvert.isDouble(value)) {
      return "";
    }
    return null;
  }
}
