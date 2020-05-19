import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginInputComponent extends StatelessWidget {
  LoginInputComponent(
      {this.label,
      this.type,
      this.focusNode,
      this.autofocus,
      this.obscureText,
      this.textInputType,
      this.textInputAction,
      this.isValidLogin,
      this.formFieldValidator,
      this.valueChanged,
      this.formFieldSetter,
      this.onfieldSubmitted,
      this.onPressed});

  final String label;
  final String type;
  final FocusNode focusNode;
  final bool autofocus;
  bool obscureText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isValidLogin;
  final FormFieldValidator formFieldValidator;
  final ValueChanged valueChanged;
  final FormFieldSetter formFieldSetter;
  final ValueChanged onfieldSubmitted;
  final VoidCallback onPressed;

  int _buildSuffixLogic;

  @override
  Widget build(BuildContext context) {
    if (type == 'password' && obscureText == true) {
      _buildSuffixLogic = 0; // hide pw
    } else if (type == 'password' && obscureText == false) {
      _buildSuffixLogic = 1; // show pw
    } else
      _buildSuffixLogic = 2;

    return TextFormField(
      focusNode: focusNode,
      autofocus: autofocus,
      obscureText: obscureText,
      //textCapitalization: TextCapitalization.words,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: _buildSuffixIcon(context, _buildSuffixLogic, onPressed),
        labelText: label,
        labelStyle: TextStyle(
          color: isValidLogin == true ? Color.fromRGBO(13, 13, 15, 0.5) : Colors.red,
          fontFamily: 'OpenSans',
        ),
        enabledBorder: new UnderlineInputBorder(borderSide: BorderSide(color: isValidLogin == true ? Color.fromRGBO(19, 19, 21, 0.1) : Colors.red)),
        //errorBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder: new UnderlineInputBorder(borderSide: BorderSide(color: isValidLogin == true ? Color.fromRGBO(19, 19, 21, 0.1) : Colors.red)),
      ),
      textInputAction: textInputAction,
      //validator: formFieldValidator,
      onChanged: valueChanged,
      onSaved: formFieldSetter,
      onFieldSubmitted: onfieldSubmitted,
    );
  }

  Widget _buildSuffixIcon(BuildContext context, int _buildSuffixIcon, VoidCallback onPressed) {
    switch (_buildSuffixLogic) {
      case 0:
        return IconButton(
            icon: Icon(
              Icons.visibility,
              color: Color(0xAAAAAAAA),
            ),
            onPressed: onPressed);
        break;
      case 1:
        return IconButton(
            icon: Icon(
              Icons.visibility_off,
              color: Color(0xAAAAAAAA),
            ),
            onPressed: onPressed);
        break;
      case 2:
        return null;
        break;
      default:
        return null;
        break;
    }
  }
}
