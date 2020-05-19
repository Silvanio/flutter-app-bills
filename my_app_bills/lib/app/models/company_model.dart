/// Dados da empresa sao divididos em duas partes
/// Company(tport_app_config -> tb_company) e CompanyContact(tport_company_contacts -> tb_companyContact)

class CompanyModel {
  static final String nameTable = "tb_company";
  static final String create = "CREATE TABLE tb_company(id INTEGER PRIMARY KEY AUTOINCREMENT, company_id INTEGER, company_logo TEXT, "
      "dash_img TEXT, currency TEXT, avisosLegais TEXT, companyName TEXT, welcomeMsg TEXT)";

  int companyId;
  String companyLogo;
  String dashboardImg;
  String currency;
  //String legalWarning;
  List<CompanyContactModel> companyInfo;
  List<CompanyLegalWarningModel> companyLegalWarning;
  String companyName;
  //String welcomeMsg;

  CompanyModel(
      {this.companyId, this.companyLogo, this.dashboardImg, this.currency, this.companyInfo, this.companyLegalWarning, this.companyName});


  /// usado para mapear os dados vindos do serviço
  factory CompanyModel.fromJson(Map<String, dynamic> json) {

      List<CompanyLegalWarningModel> catCompanyLegalWarning(Map<String, dynamic> json) {
        List data = json['legalWarningList'].map((model) => CompanyLegalWarningModel.fromJson(model)).toList();
        if (data != null && data.isNotEmpty) {
          return List.castFrom<dynamic, CompanyLegalWarningModel>(data);
        }
        return null;
      }

    List<CompanyContactModel> catCompanyInfo(Map<String, dynamic> json) {
      List data = json['contactList'].map((model) => CompanyContactModel.fromJson(model)).toList();
      if (data != null && data.isNotEmpty) {
        return List.castFrom<dynamic, CompanyContactModel>(data);
      }
      return null;
    }

    return CompanyModel(
        companyId: json['company_id'],
        companyLogo: json['company_logo'],
        dashboardImg: json['dash_img'],
        currency: json['currency'],
        companyInfo: catCompanyInfo(json),
        companyLegalWarning: catCompanyLegalWarning(json),
        companyName: json['companyName'],
        );
  }

  /// usado para mapear os dados vindos da BD
  factory CompanyModel.fromJsonOnlyCompany(Map<String, dynamic> json) {
    return CompanyModel(
        companyId: json['company_id'],
        companyLogo: json['company_logo'],
        dashboardImg: json['dash_img'],
        currency: json['currency'],
        companyName: json['companyName']);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["company_id"] = companyId;
    map["company_logo"] = companyLogo;
    map["dash_img"] = dashboardImg;
    map["currency"] = currency;
    map["companyName"] = companyName;
    return map;
  }
}

class CompanyContactModel {
  static final String nameTable = "tb_companyContact";
  static final String create = "CREATE TABLE tb_companyContact(id INTEGER PRIMARY KEY AUTOINCREMENT, company_id INTEGER, name TEXT, "
      "contact TEXT, email TEXT, address TEXT, opening_hours TEXT, localizations TEXT)";

  int companyId;
  String name;
  String contact;
  String email;
  String address;
  String opening_hours;
  String localizations;

  CompanyContactModel({this.companyId, this.name, this.contact, this.email, this.address, this.opening_hours, this.localizations});

  /// usado para mapear os dados vindos da BD e do Serviço
  factory CompanyContactModel.fromJson(Map<String, dynamic> json) {
    return CompanyContactModel(
      companyId: json['company_id'],
      name: json['name'],
      contact: json['contact'],
      email: json['email'],
      address: json['address'],
      opening_hours: json['opening_hours'],
      localizations: json['localizations'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["company_id"] = companyId;
    map["name"] = name;
    map["contact"] = contact;
    map["email"] = email;
    map["address"] = address;
    map["opening_hours"] = opening_hours;
    map["localizations"] = localizations;
    return map;
  }
}

class CompanyLegalWarningModel {
  static final String nameTable = "tb_companyLegalWarning";
  static final String create = "CREATE TABLE tb_companyLegalWarning(id INTEGER PRIMARY KEY AUTOINCREMENT, company_id INTEGER, "
      "legalWarning TEXT, welcomeMsg TEXT, gdprMarketing TEXT, gdprThirdParty TEXT, lang TEXT)";

  int companyId;
  String legalWarning;
  String welcomeMsg;
  String gdprMarketing;
  String gdprThirdParty;
  String lang;

  CompanyLegalWarningModel({this.companyId, this.legalWarning, this.welcomeMsg, this.lang, this.gdprMarketing, this.gdprThirdParty});

  /// usado para mapear os dados vindos da BD e do Serviço
  factory CompanyLegalWarningModel.fromJson(Map<String, dynamic> json) {
    return CompanyLegalWarningModel(
      companyId: json['company_id'],
      legalWarning: json['legalWarning'],
      welcomeMsg: json['welcomeMsg'],
      gdprMarketing: json['gdprMarketing'],
      gdprThirdParty: json['gdprThirdParty'],
      lang: json ['lang']
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["company_id"] = companyId;
    map["legalWarning"] = legalWarning;
    map["welcomeMsg"] = welcomeMsg;
    map['gdprMarketing'] = gdprMarketing;
    map['gdprThirdParty'] = gdprThirdParty;
    map["lang"] = lang;

    return map;
  }
}