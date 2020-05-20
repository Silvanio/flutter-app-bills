

class ConsumptionModel {

  double value;
  String source;
  DateTime invoiceDate;
  DateTime readingDate;


  ConsumptionModel( {this.value, this.source, this.invoiceDate, this.readingDate});

  factory ConsumptionModel.fromJson(Map<String, dynamic> json) {
    return ConsumptionModel(
      value: json['value'],
      source: json['source'],
      invoiceDate: json['invoiceDate'] != null ? DateTime.parse(json['invoiceDate']) : null,
      readingDate: json['readingDate'] != null ? DateTime.parse(json['readingDate']) : null,
    );
  }
}
