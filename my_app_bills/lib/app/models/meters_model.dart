class MetersModel {
  int digits;
  String counterNumber;
  String markCode;
  String markDesc;
  String modelCode;
  String modelDesc;
  String productCode;
  String productDesc;
  String unit;
  List<MetersFunctions> functions;

  MetersModel(
      {this.digits,
      this.counterNumber,
      this.markCode,
      this.markDesc,
      this.modelCode,
      this.modelDesc,
      this.productCode,
      this.productDesc,
      this.unit,
      this.functions}
      );

  factory MetersModel.fromJson(Map<String, dynamic> json) {

    List<MetersFunctions> catMetersFunctions(Map<String, dynamic> json){
      List data = json['counterFunctions'].map((model) => MetersFunctions.fromJson(model)).toList();
      if(data != null && data.isNotEmpty){
        return List.castFrom<dynamic, MetersFunctions>(data);
      }
      return null;
    }

    return MetersModel(
        digits: json['digits'],
        counterNumber: json['counterNumber'],
        markCode: json['markCode'],
        markDesc: json['markDesc'],
        modelCode: json['modelCode'],
        modelDesc: json['modelDesc'],
        productCode: json['productCode'],
        productDesc: json['productDesc'],
        unit: json['unit'],
        functions: catMetersFunctions(json));
  }

}

class MetersFunctions {
  String functionCode;
  String functionDesc;
  DateTime endDateComunicate;
  DateTime lastComunication;
  DateTime startDateComunicate;
  double lastReading;
  double maxReading;
  double minReading;

  MetersFunctions(
      {this.functionCode,
      this.functionDesc,
      this.endDateComunicate,
      this.lastComunication,
      this.startDateComunicate,
      this.lastReading,
      this.maxReading,
      this.minReading});

  factory MetersFunctions.fromJson(Map<String, dynamic> json) {
    return MetersFunctions(
      functionCode: json['functionCode'],
      functionDesc: json['functionDesc'],
      endDateComunicate: json['endDateComunicate'] != null ? DateTime.parse(json['endDateComunicate']) : null,
      lastComunication: json['lastComunication1'] != null ? DateTime.parse(json['lastComunication1']) : null,
      startDateComunicate: json['startDateComunicate'] != null ? DateTime.parse(json['startDateComunicate']) : null,
      lastReading: json['lastReading'],
      maxReading: json['maxReading'],
      minReading: json['minReading'],
    );
  }
}
