import 'package:myAppBills/app/models/input/client_input.dart';
import 'package:myAppBills/app/models/reading_model.dart';

class SendReadingModel {
  ClientInput client;
  String token;
  List<CountersReadings> countersReadings;

  SendReadingModel({this.client, this.token, this.countersReadings});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["client"] = client.toMap();
    map["countersReadings"] = countersReadings.map((i) => i.toMap()).toList();
    return map;
  }
}

class CountersReadings {
  String sourceCode;
  String counterNumber;
  String mark;
  String productCode;
  List<ReadingModel> readings;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["sourceCode"] = sourceCode;
    map["counterNumber"] = counterNumber;
    map["mark"] = mark;
    map["productCode"] = productCode;
    map["readings"] = readings.map((i) => i.toMap()).toList();
    return map;
  }
}
