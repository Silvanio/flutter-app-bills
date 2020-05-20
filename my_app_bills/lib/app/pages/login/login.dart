import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myAppBills/app/controllers/company_controller.dart';
import 'package:myAppBills/app/controllers/login_controller.dart';
import 'package:myAppBills/app/models/company_model.dart';
import 'package:myAppBills/app/models/login_model.dart';
import 'package:myAppBills/app/pages/login/login_LangDropdownMenu.dart';
import 'package:myAppBills/app/pages/login/login_button.dart';
import 'package:myAppBills/app/pages/login/login_input_component.dart';
import 'package:myAppBills/generated/l10n.dart';
import 'package:myAppBills/my_navigator.dart';
import 'package:myAppBills/style/login_style.dart';
import 'package:myAppBills/utils/convert.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  LoginController loginController;
  CompanyController companyController;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController userNameText = new TextEditingController();
  ProgressDialog progressDialog;

  CompanyModel company;

  String _inputName, _inputPass;
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _isValidLogin = true, _showPassword = true;

  List<Locale> _localeList;
  List<String> _localeLString = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _currLang;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    loginController = new LoginController();
    loginController.getLoginBD().then((loginModel) => {_setSateLogin(loginModel)});


    _prefs.then((SharedPreferences prefs) {
      _currLang = (prefs.getString('currLang') ?? Intl.getCurrentLocale());
    });
    _localeList = S.delegate.supportedLocales;
    for (int i = 0; i < _localeList.length; i++) {
      _localeLString.add(S.delegate.supportedLocales[i].languageCode.toString());
    }
  }


  void _setSateLogin(LoginModel loginModel) {
    if (loginModel != null) {
      setState(() {
        userNameText.text = loginModel.username;
      });
    }
  }

  Future<void> _saveNewLangSP(String newLang) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("currLang", newLang);
  }

  @override
  Widget build(BuildContext context) {
    if (progressDialog == null) {
      _createPopupDialog();
    }

    AppBar appBar = AppBar(

      backgroundColor: Colors.transparent,
      elevation: 0.0,
      brightness: Brightness.light,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Container(
            //color: Colors.red,
              height: 120,
              width: 120,
              child: _localeLString != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom:8.0, left: 8.0, right: 8.0),
                      child: LoginLangDropDown(
                        list: _localeLString,
                        selected: Intl.getCurrentLocale(),
                        //selected: _currLang,
                        onChanged: (String newValue) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          S.load(Locale(newValue));
                          _saveNewLangSP(newValue);
                        },
                      ),
                    )
                  : Container()),

      ],
    );

    double absoluteHeight = MediaQuery.of(context).size.height - appBar.preferredSize.height;

    return Scaffold(
      key: _scaffoldKey,

      resizeToAvoidBottomInset: false, // impedir que a imagem de fundo se mova quando aparece o teclado
      appBar: appBar,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              //layoutLogin,
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
              Container(
                  height: absoluteHeight,

                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 20.0,
                      ),
                      child: Form(
                        key: loginController.formKey,
                        child:
                            Stack(
                              children: <Widget>[


                                new Positioned(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                          child:
                                          Image(image: AssetImage("assets/images/ic_logo_appstore.png"), width: 220, alignment: Alignment.center))
                                    ],
                                  ),
                                ),

                                new Positioned(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        _nameInput(context, _usernameFocusNode),
                                        _passwordInput(context),
                                        SizedBox(height: 10.0),
                                        _buildErrorMsg(context),
                                        ///widgets para ser usado futuramente
                                        //_buildLostPassword(context),
                                        //_buildSignUpButtons(context),
                                      ],
                                    ),
                                ),

                                new Positioned(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        _buildLoginButton(context),
                                      ],
                                    ),
                                )

                              ],
                            )

                      ),
                    ),

              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildErrorMsg(BuildContext context) {
    return Text(MyConvert.stringToCamelCase(S.of(context).lbl_login_err), style: _isValidLogin == true ? kTextSyleTransparent : kTextSyleRed);
  }

  Widget _buildLoginButton(BuildContext context) {
    //if (_isValidLogin == false) _isValidLogin = !_isValidLogin;

    return LoginButton(
      label: S.of(context).lbl_login.toUpperCase(),
      onPressed: ((_inputName == null || _inputName.isEmpty) || (_inputPass == null || _inputPass.isEmpty))
          ? null
          : () {
              if (loginController.formKey.currentState.validate()) {
                loginController.formKey.currentState.save();
                progressDialog.show();
                loginController.executeLogin().then((ok) => {progressDialog.hide(), MyNavigator.goToWelcome(context)}).catchError((e) {
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    progressDialog.hide();
                  });
                  //FocusScope.of(context).requestFocus();
                  setState(() {
                    _isValidLogin = false;
                    loginController.formKey.currentState.reassemble();
                  });
                });
              }
            },
    );
  }

  Widget _nameInput(BuildContext context, FocusNode _usernameFocusNode) {
    return LoginInputComponent(
      label: S.of(context).lbl_user_name.toUpperCase(),
      type: 'username',
      focusNode: _usernameFocusNode,
      autofocus: true,
      obscureText: false,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      isValidLogin: _isValidLogin,
      formFieldValidator: (name) {
        if (_isValidLogin == true) {
          return null;
        } else {
          setState(() {
            if (_isValidLogin == false) _isValidLogin = !_isValidLogin;
          });
          return '';
        }
      },
      valueChanged: (name) => {
        setState(() {
          _inputName = name;
        })
      },
      formFieldSetter: (name) => loginController.getLoginModel.username = name,
      onfieldSubmitted: (_) {
        _usernameFocusNode.unfocus();
      },
    );
  }

  Widget _passwordInput(BuildContext context) {
    return LoginInputComponent(
      label: S.of(context).lbl_password.toUpperCase(),
      type: 'password',
      focusNode: _passwordFocusNode,
      autofocus: false,
      obscureText: _showPassword,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      isValidLogin: _isValidLogin,
      formFieldValidator: (password) {
        if (_isValidLogin == true) {
          return null;
        } else {
          setState(() {
            if (_isValidLogin == false) _isValidLogin = !_isValidLogin;
          });

          return '';
        }
      },
      valueChanged: (pass) => {
        setState(() {
          _inputPass = pass;
        })
      },
      formFieldSetter: (password) => loginController.getLoginModel.password = password,
      onfieldSubmitted: (_) {
        _passwordFocusNode.unfocus();
      },
      onPressed: () {
        setState(() {
          _showPassword = !_showPassword;
        });
      },
    );
  }
  void _createPopupDialog() {
    progressDialog = new ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(
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
}
