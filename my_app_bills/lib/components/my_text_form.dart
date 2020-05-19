import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  MyTextForm({this.icon, this.label, this.validator,this.maxLength});

  final IconData icon;
  @required final String label;
  final FormFieldValidator<String> validator;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(
          child: ListTile(leading: Icon(this.icon), title: createTextForm())),
    );
  }

  createTextForm() {
   return new TextFormField(
        decoration: new InputDecoration(
          labelText: this.label,
        ),
        maxLength: maxLength,
        validator: this.validator);
  }
}
