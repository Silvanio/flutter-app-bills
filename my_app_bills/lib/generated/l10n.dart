// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get lbl_name_app {
    return Intl.message(
      'myUtility',
      name: 'lbl_name_app',
      desc: '',
      args: [],
    );
  }

  String get lbl_user_name {
    return Intl.message(
      'E-mail or Username',
      name: 'lbl_user_name',
      desc: '',
      args: [],
    );
  }

  String get lbl_password {
    return Intl.message(
      'Password',
      name: 'lbl_password',
      desc: '',
      args: [],
    );
  }

  String get lbl_remember_pass {
    return Intl.message(
      'Remember',
      name: 'lbl_remember_pass',
      desc: '',
      args: [],
    );
  }

  String get lbl_login {
    return Intl.message(
      'Login',
      name: 'lbl_login',
      desc: '',
      args: [],
    );
  }

  String get lbl_required_field {
    return Intl.message(
      'Required fields',
      name: 'lbl_required_field',
      desc: '',
      args: [],
    );
  }

  String get lbl_companies {
    return Intl.message(
      'Adherent services',
      name: 'lbl_companies',
      desc: '',
      args: [],
    );
  }

  String get lbl_cil {
    return Intl.message(
      'CIL',
      name: 'lbl_cil',
      desc: '',
      args: [],
    );
  }

  String get lbl_notification {
    return Intl.message(
      'Notification',
      name: 'lbl_notification',
      desc: '',
      args: [],
    );
  }

  String get lbl_settings {
    return Intl.message(
      'Settings',
      name: 'lbl_settings',
      desc: '',
      args: [],
    );
  }

  String get lbl_logout {
    return Intl.message(
      'Logout',
      name: 'lbl_logout',
      desc: '',
      args: [],
    );
  }

  String get msg_welcome {
    return Intl.message(
      'Welcome!',
      name: 'msg_welcome',
      desc: '',
      args: [],
    );
  }

  String get msg_required_field {
    return Intl.message(
      'Required field',
      name: 'msg_required_field',
      desc: '',
      args: [],
    );
  }

  String get msg_error_login {
    return Intl.message(
      'Login invalid',
      name: 'msg_error_login',
      desc: '',
      args: [],
    );
  }

  String get msg_please_wait {
    return Intl.message(
      'Please wait...',
      name: 'msg_please_wait',
      desc: '',
      args: [],
    );
  }

  String get lbl_last_bill {
    return Intl.message(
      'Last bill',
      name: 'lbl_last_bill',
      desc: '',
      args: [],
    );
  }

  String get lbl_paid {
    return Intl.message(
      'Paid',
      name: 'lbl_paid',
      desc: '',
      args: [],
    );
  }

  String get lbl_waiting_payment {
    return Intl.message(
      'Awaits Payment',
      name: 'lbl_waiting_payment',
      desc: '',
      args: [],
    );
  }

  String get lbl_due_date {
    return Intl.message(
      'Due date',
      name: 'lbl_due_date',
      desc: '',
      args: [],
    );
  }

  String get lbl_menu_readings {
    return Intl.message(
      'Readings',
      name: 'lbl_menu_readings',
      desc: '',
      args: [],
    );
  }

  String get lbl_menu_home {
    return Intl.message(
      'Home',
      name: 'lbl_menu_home',
      desc: '',
      args: [],
    );
  }

  String get lbl_menu_invoices {
    return Intl.message(
      'Invoices',
      name: 'lbl_menu_invoices',
      desc: '',
      args: [],
    );
  }

  String get lbl_speel_contracts {
    return Intl.message(
      'Contracts',
      name: 'lbl_speel_contracts',
      desc: '',
      args: [],
    );
  }

  String get lbl_last_reading {
    return Intl.message(
      'Last reading',
      name: 'lbl_last_reading',
      desc: '',
      args: [],
    );
  }

  String get lbl_last_consumption {
    return Intl.message(
      'Last consumption',
      name: 'lbl_last_consumption',
      desc: '',
      args: [],
    );
  }

  String get lbl_comunication {
    return Intl.message(
      'Comunication',
      name: 'lbl_comunication',
      desc: '',
      args: [],
    );
  }

  String get lbl_invoices_six_month {
    return Intl.message(
      'Invoices last 6 months',
      name: 'lbl_invoices_six_month',
      desc: '',
      args: [],
    );
  }

  String get lbl_issue_date {
    return Intl.message(
      'Issue date',
      name: 'lbl_issue_date',
      desc: '',
      args: [],
    );
  }

  String get lbl_payment_deedLine {
    return Intl.message(
      'Payment deed line',
      name: 'lbl_payment_deedLine',
      desc: '',
      args: [],
    );
  }

  String get lbl_payment_date {
    return Intl.message(
      'Payment date',
      name: 'lbl_payment_date',
      desc: '',
      args: [],
    );
  }

  String get lbl_invoice_date {
    return Intl.message(
      'Invoice date',
      name: 'lbl_invoice_date',
      desc: '',
      args: [],
    );
  }

  String get lbl_reading_date {
    return Intl.message(
      'Reading date',
      name: 'lbl_reading_date',
      desc: '',
      args: [],
    );
  }

  String get lbl_forgot_password {
    return Intl.message(
      'Forgot the password',
      name: 'lbl_forgot_password',
      desc: '',
      args: [],
    );
  }

  String get lbl_not_reg_yet {
    return Intl.message(
      'Not registered yet?',
      name: 'lbl_not_reg_yet',
      desc: '',
      args: [],
    );
  }

  String get lbl_signUp {
    return Intl.message(
      'Sign up',
      name: 'lbl_signUp',
      desc: '',
      args: [],
    );
  }

  String get lbl_login_err {
    return Intl.message(
      'INVALID USERNAME OR PASSWORD',
      name: 'lbl_login_err',
      desc: '',
      args: [],
    );
  }

  String get lbl_inv_user {
    return Intl.message(
      'Invalid Username',
      name: 'lbl_inv_user',
      desc: '',
      args: [],
    );
  }

  String get lbl_inv_pass {
    return Intl.message(
      'Invalid Password',
      name: 'lbl_inv_pass',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_product {
    return Intl.message(
      'Product',
      name: 'lbl_contracts_product',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_holder {
    return Intl.message(
      'Holder',
      name: 'lbl_contracts_holder',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_payments {
    return Intl.message(
      'Payments',
      name: 'lbl_contracts_payments',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_contract {
    return Intl.message(
      'Contract',
      name: 'lbl_contracts_contract',
      desc: '',
      args: [],
    );
  }

  String get lbl_contract_info {
    return Intl.message(
      'Contract Information',
      name: 'lbl_contract_info',
      desc: '',
      args: [],
    );
  }

  String get lbl_holder_info {
    return Intl.message(
      'Holder Information',
      name: 'lbl_holder_info',
      desc: '',
      args: [],
    );
  }

  String get lbl_additional_options {
    return Intl.message(
      'Additional Options',
      name: 'lbl_additional_options',
      desc: '',
      args: [],
    );
  }

  String get lbl_nr_contract {
    return Intl.message(
      'Contract nº',
      name: 'lbl_nr_contract',
      desc: '',
      args: [],
    );
  }

  String get lbl_first_last_names {
    return Intl.message(
      'Name and surname',
      name: 'lbl_first_last_names',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_name {
    return Intl.message(
      'Name',
      name: 'lbl_contracts_name',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_address {
    return Intl.message(
      'Address',
      name: 'lbl_contracts_address',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_email {
    return Intl.message(
      'E-mail',
      name: 'lbl_contracts_email',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_nif {
    return Intl.message(
      'NIF',
      name: 'lbl_contracts_nif',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_phone {
    return Intl.message(
      'Phone',
      name: 'lbl_contracts_phone',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_mobile_phone {
    return Intl.message(
      'Mobile Phone',
      name: 'lbl_contracts_mobile_phone',
      desc: '',
      args: [],
    );
  }

  String get lbl_opening_hours {
    return Intl.message(
      'Schedule',
      name: 'lbl_opening_hours',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_nib {
    return Intl.message(
      'NIB',
      name: 'lbl_contracts_nib',
      desc: '',
      args: [],
    );
  }

  String get lbl_sPhone {
    return Intl.message(
      'Ph. Nr.',
      name: 'lbl_sPhone',
      desc: '',
      args: [],
    );
  }

  String get lbl_active {
    return Intl.message(
      'Active',
      name: 'lbl_active',
      desc: '',
      args: [],
    );
  }

  String get lbl_inactive {
    return Intl.message(
      'Inactive',
      name: 'lbl_inactive',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_plan {
    return Intl.message(
      'Plan',
      name: 'lbl_contracts_plan',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_contract_number {
    return Intl.message(
      'Contract number',
      name: 'lbl_contracts_contract_number',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_start_date {
    return Intl.message(
      'Start date',
      name: 'lbl_contracts_start_date',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_tariff {
    return Intl.message(
      'Tariff',
      name: 'lbl_contracts_tariff',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_contract_direct_debit {
    return Intl.message(
      'Direct Debit',
      name: 'lbl_contracts_contract_direct_debit',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_social_tariff {
    return Intl.message(
      'Social tariff',
      name: 'lbl_contracts_social_tariff',
      desc: '',
      args: [],
    );
  }

  String get lbl_contracts_electronic_invoice {
    return Intl.message(
      'Electronic invoice',
      name: 'lbl_contracts_electronic_invoice',
      desc: '',
      args: [],
    );
  }

  String get lbl_my_contracts {
    return Intl.message(
      'My Contracts',
      name: 'lbl_my_contracts',
      desc: '',
      args: [],
    );
  }

  String get lbl_invoice_entity {
    return Intl.message(
      'Entity',
      name: 'lbl_invoice_entity',
      desc: '',
      args: [],
    );
  }

  String get lbl_invoice_reference {
    return Intl.message(
      'Reference',
      name: 'lbl_invoice_reference',
      desc: '',
      args: [],
    );
  }

  String get lbl_invoice_amount {
    return Intl.message(
      'Amount',
      name: 'lbl_invoice_amount',
      desc: '',
      args: [],
    );
  }

  String get lbl_invoice_n_reference {
    return Intl.message(
      'Nº Reference',
      name: 'lbl_invoice_n_reference',
      desc: '',
      args: [],
    );
  }

  String get lbl_invoice_issue_date {
    return Intl.message(
      'Issue Date',
      name: 'lbl_invoice_issue_date',
      desc: '',
      args: [],
    );
  }

  String get lbl_invoice_value {
    return Intl.message(
      'Amount',
      name: 'lbl_invoice_value',
      desc: '',
      args: [],
    );
  }

  String get lbl_reading_send_reading {
    return Intl.message(
      'Send reading',
      name: 'lbl_reading_send_reading',
      desc: '',
      args: [],
    );
  }

  String get lbl_reading_value_reading {
    return Intl.message(
      'Reading value',
      name: 'lbl_reading_value_reading',
      desc: '',
      args: [],
    );
  }

  String get lbl_reading_estimate {
    return Intl.message(
      'Estimated reading',
      name: 'lbl_reading_estimate',
      desc: '',
      args: [],
    );
  }

  String get lbl_reading_manual {
    return Intl.message(
      'Manual reading',
      name: 'lbl_reading_manual',
      desc: '',
      args: [],
    );
  }

  String get lbl_reading_send {
    return Intl.message(
      'Send',
      name: 'lbl_reading_send',
      desc: '',
      args: [],
    );
  }

  String get lbl_dialog_confirmation {
    return Intl.message(
      'Confirmation',
      name: 'lbl_dialog_confirmation',
      desc: '',
      args: [],
    );
  }

  String get msg_reading_send_confirm {
    return Intl.message(
      'Reading outside expected values.\nDo you want to send the reading with these values?',
      name: 'msg_reading_send_confirm',
      desc: '',
      args: [],
    );
  }

  String get msg_reading_error_send_reading {
    return Intl.message(
      'A communication error has occurred.',
      name: 'msg_reading_error_send_reading',
      desc: '',
      args: [],
    );
  }

  String get msg_reading_send_success {
    return Intl.message(
      'Your reading has been successfully submitted.',
      name: 'msg_reading_send_success',
      desc: '',
      args: [],
    );
  }

  String get msg_reading_send_warning_value {
    return Intl.message(
      'Reading submitted outside expected values.',
      name: 'msg_reading_send_warning_value',
      desc: '',
      args: [],
    );
  }

  String get lbl_invalid_value {
    return Intl.message(
      'Invalid value',
      name: 'lbl_invalid_value',
      desc: '',
      args: [],
    );
  }

  String get lbl_close {
    return Intl.message(
      'Close',
      name: 'lbl_close',
      desc: '',
      args: [],
    );
  }

  String get lbl_last_readings {
    return Intl.message(
      'Last Readings',
      name: 'lbl_last_readings',
      desc: '',
      args: [],
    );
  }

  String get lbl_legal_warnings {
    return Intl.message(
      'Legal Warnings',
      name: 'lbl_legal_warnings',
      desc: '',
      args: [],
    );
  }

  String get lbl_contacts {
    return Intl.message(
      'Contacts',
      name: 'lbl_contacts',
      desc: '',
      args: [],
    );
  }

  String get lbl_store {
    return Intl.message(
      'Store',
      name: 'lbl_store',
      desc: '',
      args: [],
    );
  }

  String get lbl_help {
    return Intl.message(
      'Help',
      name: 'lbl_help',
      desc: '',
      args: [],
    );
  }

  String get lbl_hi {
    return Intl.message(
      'Hi',
      name: 'lbl_hi',
      desc: '',
      args: [],
    );
  }

  String get lbl_open_value {
    return Intl.message(
      'Open amount',
      name: 'lbl_open_value',
      desc: '',
      args: [],
    );
  }

  String msg_pay_until(Object datePayment) {
    return Intl.message(
      'Payment until: $datePayment',
      name: 'msg_pay_until',
      desc: '',
      args: [datePayment],
    );
  }

  String msg_payment_until(Object datePayment) {
    return Intl.message(
      'Payment until: $datePayment',
      name: 'msg_payment_until',
      desc: '',
      args: [datePayment],
    );
  }

  String msg_pay_in(Object datePayment) {
    return Intl.message(
      'Paid on: $datePayment',
      name: 'msg_pay_in',
      desc: '',
      args: [datePayment],
    );
  }

  String msg_issue_on(Object dateissue) {
    return Intl.message(
      'Issued on: $dateissue',
      name: 'msg_issue_on',
      desc: '',
      args: [dateissue],
    );
  }

  String get lbl_reading_history {
    return Intl.message(
      'Reading history',
      name: 'lbl_reading_history',
      desc: '',
      args: [],
    );
  }

  String get lbl_last_3_months {
    return Intl.message(
      'Last 3 months',
      name: 'lbl_last_3_months',
      desc: '',
      args: [],
    );
  }

  String get lbl_last_6_months {
    return Intl.message(
      'Last 6 months',
      name: 'lbl_last_6_months',
      desc: '',
      args: [],
    );
  }

  String get lbl_last_12_months {
    return Intl.message(
      'Last 12 months',
      name: 'lbl_last_12_months',
      desc: '',
      args: [],
    );
  }

  String get lbl_place_consumption {
    return Intl.message(
      'Place of consumption',
      name: 'lbl_place_consumption',
      desc: '',
      args: [],
    );
  }

  String get lbl_filter_by {
    return Intl.message(
      'Filter by',
      name: 'lbl_filter_by',
      desc: '',
      args: [],
    );
  }

  String get lbl_reading {
    return Intl.message(
      'Reading',
      name: 'lbl_reading',
      desc: '',
      args: [],
    );
  }

  String get lbl_client {
    return Intl.message(
      'Client',
      name: 'lbl_client',
      desc: '',
      args: [],
    );
  }

  String get lbl_distributor {
    return Intl.message(
      'Distributor',
      name: 'lbl_distributor',
      desc: '',
      args: [],
    );
  }

  String get lbl_consumption {
    return Intl.message(
      'Consumptions',
      name: 'lbl_consumption',
      desc: '',
      args: [],
    );
  }

  String get lbl_trend {
    return Intl.message(
      'Trend',
      name: 'lbl_trend',
      desc: '',
      args: [],
    );
  }

  String get lbl_lang {
    return Intl.message(
      'Language',
      name: 'lbl_lang',
      desc: '',
      args: [],
    );
  }

  String get lbl_about {
    return Intl.message(
      'About',
      name: 'lbl_about',
      desc: '',
      args: [],
    );
  }

  String get lbl_privacy {
    return Intl.message(
      'Privacy',
      name: 'lbl_privacy',
      desc: '',
      args: [],
    );
  }

  String get lbl_yes {
    return Intl.message(
      'Yes',
      name: 'lbl_yes',
      desc: '',
      args: [],
    );
  }

  String get lbl_no {
    return Intl.message(
      'No',
      name: 'lbl_no',
      desc: '',
      args: [],
    );
  }

  String get msg_communicate_reading {
    return Intl.message(
      'Communicate reading',
      name: 'msg_communicate_reading',
      desc: '',
      args: [],
    );
  }

  String msg_communicate_reading_between(Object initialDate, Object finalDate) {
    return Intl.message(
      'Lower estimates in your reading. Communicate your readings between $initialDate and $finalDate.',
      name: 'msg_communicate_reading_between',
      desc: '',
      args: [initialDate, finalDate],
    );
  }

  String msg_insert_reading(Object typeReading) {
    return Intl.message(
      'Enter your reading for: $typeReading',
      name: 'msg_insert_reading',
      desc: '',
      args: [typeReading],
    );
  }

  String msg_last_real_reading(Object dateReading) {
    return Intl.message(
      'Last reading: $dateReading',
      name: 'msg_last_real_reading',
      desc: '',
      args: [dateReading],
    );
  }

  String get lbl_cancel {
    return Intl.message(
      'Cancel',
      name: 'lbl_cancel',
      desc: '',
      args: [],
    );
  }

  String get lbl_communicate {
    return Intl.message(
      'Communicate',
      name: 'lbl_communicate',
      desc: '',
      args: [],
    );
  }

  String get lbl_dialog_confirm_reading {
    return Intl.message(
      'Confirm reading',
      name: 'lbl_dialog_confirm_reading',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}