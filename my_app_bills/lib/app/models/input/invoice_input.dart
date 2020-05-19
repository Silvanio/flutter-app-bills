import 'package:myutility/app/models/input/client_input.dart';

class InvoiceInput {

  String firstIndex;
  String numberOfElements;
  String ascending;
  String orderByColumn;
  ClientInput client;
  String token;

  InvoiceInput({this.ascending, this.client, this.firstIndex, this.numberOfElements, this.orderByColumn,this.token});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["firstIndex"] = firstIndex;
    map["numberOfElements"] = numberOfElements;
    map["ascending"] = ascending;
    map["orderByColumn"] = orderByColumn;
    map["client"] =  client.toMap() ;

    return map;
  }

  factory InvoiceInput.fromJson(Map<String, dynamic> json) {
    return InvoiceInput(
      firstIndex: json['firstIndex'],
      numberOfElements: json['numberOfElements'],
      ascending: json['ascending'],
      orderByColumn: json['orderByColumn'],
      client:  ClientInput.fromJson(json['client']),
    );
  }
}
