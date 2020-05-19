class ClientInput{
  String accountNumber;
  String clientNumber;
  String cil;

  ClientInput({this.cil, this.clientNumber, this.accountNumber});

  Map<String, dynamic> toJson() =>
      {
        'accountNumber': accountNumber,
        'clientNumber': clientNumber,
        "cil": cil
      };

  Map<String, dynamic> toMap() {
    var map = new Map<String, String>();
    map["accountNumber"] = accountNumber;
    map["clientNumber"] = clientNumber;
    map["cil"] = cil;
    return map;
  }

  factory ClientInput.fromJson(Map json) {
    return ClientInput(
      accountNumber: json['accountNumber'],
      clientNumber: json['clientNumber'],
      cil: json['cil'],
    );
  }
}
