import 'package:flutter/material.dart';

class MyNavigator {
  static void goToLogin(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, "/login");
  }

  static void goToWelcome(BuildContext context) {
    Navigator.pushNamed(context, "/welcome");
  }

  static void goToHome(BuildContext context, {homeController}) {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "/home", arguments: homeController);
  }

  static void goToContractDetail(BuildContext context, {contractsController}) {
    Navigator.pushNamed(context, "/contract_detail", arguments: contractsController);
  }

  static void goToContractList(BuildContext context, {contractsController}) {
    Navigator.pushNamed(context, "/contract_list", arguments: contractsController);
  }

  static void goToInvoiceDetail(BuildContext context, {invoiceController}) {
    Navigator.pushNamed(context, "/invoice_detail", arguments: invoiceController);
  }

  static void goToContacts(BuildContext context) {
    Navigator.pushNamed(context, "/contacts");
  }

  static void goToLegalWarnings(BuildContext context) {
    Navigator.pushNamed(context, "/legalWarnings");
  }

  static void goToSettings(BuildContext context, {contractsController}) {
    Navigator.pushNamed(context, "/settings", arguments: contractsController);
  }
}
