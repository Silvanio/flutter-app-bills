import 'package:myutility/app/models/input/client_input.dart';

class ReadingInput {
  String counterNumber;
  String mark;
  String productCode;
  String startDate;
  String endDate;
  String token;
  ClientInput client;

  ReadingInput({this.counterNumber, this.mark, this.productCode, this.startDate, this.endDate, this.token, this.client});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["counterNumber"] = counterNumber;
    map["mark"] = mark;
    map["productCode"] = productCode;
    map["startDate"] = startDate;
    map["endDate"] = endDate;
    map["token"] = token;
    map["client"] = client.toMap();
    return map;
  }
}
