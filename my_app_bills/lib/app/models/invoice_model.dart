import 'package:myAppBills/app/models/payment_data_model.dart';

class InvoiceModel {
  double consumption;
  double iva;
  double othersValues;
  double rates;
  DateTime deadlinePayment; // por pagar  data limite pagamento
  DateTime issueDate; // data emissão (Sempre aparecer)
  double factors;
  String invoiceNumber;
  String invoiceReference;
  bool isLiquidated;
  PaymentDataModel paymentData; // pago -> data do pagamento

  InvoiceModel(
      {this.consumption,
      this.iva,
      this.othersValues,
      this.rates,
      this.deadlinePayment,
      this.issueDate,
      this.factors,
      this.invoiceNumber,
      this.invoiceReference,
      this.isLiquidated,
      this.paymentData});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
        consumption: json['consumption'],
        iva: json['iva'],
        othersValues: json['othersValues'],
        rates: json['rates'],
        deadlinePayment: json['deadlinePayment'] != null ? DateTime.parse(json['deadlinePayment']) : null,
        issueDate: json['issueDate'] != null ? DateTime.parse(json['issueDate']) : null,
        factors: json['factors'],
        invoiceNumber: json['invoiceNumber'],
        invoiceReference: json['invoiceReference'],
        isLiquidated: json['isLiquidated'],
        paymentData: PaymentDataModel.fromJson(json['paymentData']));
  }
}
