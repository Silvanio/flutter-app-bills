
import 'package:myutility/app/models/meters_model.dart';
import 'package:myutility/utils/convert.dart';

class ReadingModel {
  bool estimate;
  String functionCode;
  DateTime readingDate;
  double value;
  String source;

  //transient
  MetersFunctions function;

  ReadingModel( {this.estimate, this.functionCode, this.readingDate, this.value, this.source});

  factory ReadingModel.fromJson(Map<String, dynamic> json) {
    return ReadingModel(
      estimate: json['estimate'] == "true",
      functionCode: json['functionCode'],
      readingDate: json['readingDate'] != null ? DateTime.parse(json['readingDate']) : null,
      value: json['value'],
        source: json['origem'] == null ? "": json['origem']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "estimate": this.estimate.toString(),
      "functionCode": this.functionCode,
      "readingDate": MyConvert.formatDatePattern(this.readingDate,"yyyy-MM-dd"),
      "value": this.value
    };
  }
}
