class CompanyModel {

  int companyId;
  String currency;
  String companyName;

  CompanyModel(
      {this.companyId,  this.currency, this.companyName});


  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        companyId: json['company_id'],
        currency: json['currency'],
        companyName: json['companyName'],
        );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["company_id"] = companyId;
    map["currency"] = currency;
    map["companyName"] = companyName;
    return map;
  }
}