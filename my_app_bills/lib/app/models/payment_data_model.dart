class PaymentDataModel {

  String entity;
  String reference;
  DateTime finishDate;
  double value;

  PaymentDataModel({this.entity, this.reference, this.finishDate, this.value});

  factory PaymentDataModel.fromJson(Map<String, dynamic> json) {
    return PaymentDataModel(
        entity: json['entity'],
        reference: json['reference'],
        finishDate: json['finishDate'] != null ? DateTime.parse(json['finishDate']) : null,
        value: json['value']
    );
  }
}
