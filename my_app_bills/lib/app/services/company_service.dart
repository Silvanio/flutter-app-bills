import 'package:myutility/app/models/company_model.dart';
import 'package:myutility/app/services/service_locator.dart';
import 'package:myutility/utils/Constants.dart' as Constants;
import 'package:myutility/utils/convert.dart';
import 'package:myutility/utils/db_helper.dart';
import 'package:myutility/utils/rest_api.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;


class CompanyService {

  static String qGetCompanyAllQuery = 'SELECT * FROM tb_company a'
      ' INNER JOIN tb_companyContact b ON a.company_id = b.company_id ';

  static String qGetLegalWarningByLang = 'SELECT * FROM tb_companyLegalWarning a'
      '';

  /// WS antigo ia buscar a lista de empresas
  Future<List<CompanyModel>> listAllCompany() {
    Resource<List<CompanyModel>> resource = Resource(
        url: Constants.api_companies,
        parse: (response) {
          Iterable list = MyConvert.jsonParse(response.bodyBytes);
          return list.map((model) => CompanyModel.fromJson(model)).toList();
        });
    return getIt<RestAPI>().get(resource);
  }

  /// WS para trazer os dados da empresa
  Future<CompanyModel> getCompanyInfoFromService() async{
    Resource<CompanyModel> resource = Resource(
      url: Constants.api_get_comp_info,
      parse: (response) {
        Map<String, dynamic> data = MyConvert.jsonParse(response.bodyBytes);
        return CompanyModel.fromJson(data);
      });

    /// colocar o token posteriormente tambem
    Map<String, String> headers = {"Content-Type": "application/json",
      "companyId": Constants.api_companyid,
      "lang": Intl.getCurrentLocale()};

    String response = await rootBundle.loadString("assets/json/companies_info.json");
   Map<String, dynamic> data = MyConvert.jsonParseString(response);
   return CompanyModel.fromJson(data);

    //return getIt<RestAPI>().get(resource, headers: headers);
  }

  /// dados da empresa
  Future<int> saveCompany(CompanyModel company) async {
    var dbClient = await DbHelper.internal().db;
    int res = await dbClient.insert(CompanyModel.nameTable, company.toMap());
    return res;
  }

  Future<void> deleteAllCompany() async {
    var dbClient = await DbHelper.internal().db;
    dbClient.delete(CompanyModel.nameTable);
  }

  Future<CompanyModel> getCompanyBD() async {
    var db = await DbHelper.internal().db;

    /// usar para ir buscar todos os dados relativos à empresa, nao existe ainda o modelo criado
    //List<Map<String, dynamic>> allRecords = await db.rawQuery(qGetCompanyAllQuery);

    List<Map<String, dynamic>> records = await db.query(CompanyModel.nameTable);
    if(records.isEmpty){
      return null;
    }
    return CompanyModel.fromJsonOnlyCompany(records.first);
    
  }
  Future<String> getCompanyCurrency() async {
    var db = await DbHelper.internal().db;

    List<Map<String, dynamic>> record =  await db.query(CompanyModel.nameTable,
      columns: ["currency"],
      where: "company_id = ?",
      whereArgs: [Constants.api_companyid],
      limit: 1
    );

    return record.first['currency'].toString();
  }

  /// dados contactos empresa
  Future<int> saveCompanyContact(CompanyContactModel company) async {
    var dbClient = await DbHelper.internal().db;
    int res = await dbClient.insert(CompanyContactModel.nameTable, company.toMap());
    return res;
  }

  Future<void> deleteAllCompanyContact() async {
    var dbClient = await DbHelper.internal().db;
    dbClient.delete(CompanyContactModel.nameTable);
  }

  Future<CompanyContactModel> getCompanyContactBD() async {
    var db = await DbHelper.internal().db;
    List<Map<String, dynamic>> records = await db.query(CompanyContactModel.nameTable);
    if(records.isEmpty){
      return null;
    }
    return  CompanyContactModel.fromJson(records.first);
  }

  /// trás a lista completa de contactos
  Future<List<CompanyContactModel>> getCompanyContactListBD() async {
    var db = await DbHelper.internal().db;
    List<Map<String, dynamic>> records = await db.query(CompanyContactModel.nameTable);
    if(records.isEmpty){
      return null;
    }
    Iterable _contactList = records;
    List<CompanyContactModel> _contacts = _contactList.map( (i) => CompanyContactModel.fromJson(i)).toList();

    return  _contacts;
  }

  /// dados legalwarning e welcomeMsg empresa
  Future<int> saveCompanyLegalWarning(CompanyLegalWarningModel company) async {
    var dbClient = await DbHelper.internal().db;
    int res = await dbClient.insert(CompanyLegalWarningModel.nameTable, company.toMap());
    return res;
  }

  Future<void> deleteAllCompanyLegalWarning() async {
    var dbClient = await DbHelper.internal().db;
    dbClient.delete(CompanyLegalWarningModel.nameTable);
  }

  Future<String> getWelcomeMsgByLang() async {
    var db = await DbHelper.internal().db;

    List<Map<String, dynamic>> record =  await db.query(CompanyLegalWarningModel.nameTable,
        columns: ["welcomeMsg"],
        where: "lang = ?",
        whereArgs: [Intl.getCurrentLocale().toUpperCase()],
        limit: 1
    );

    return record.first['welcomeMsg'].toString();
  }

  Future<String> getLegalWarningByLang() async {
    var db = await DbHelper.internal().db;

    List<Map<String, dynamic>> record =  await db.query(CompanyLegalWarningModel.nameTable,
        columns: ["legalWarning"],
        where: "lang = ?",
        whereArgs: [Intl.getCurrentLocale().toUpperCase()],
        limit: 1
    );

    return record.first['legalWarning'].toString();
  }

  Future<String> getGdrpMarketingText() async {
    var db = await DbHelper.internal().db;

    List<Map<String, dynamic>> record =  await db.query(CompanyLegalWarningModel.nameTable,
        columns: ["gdprMarketing"],
        where: "lang = ?",
        whereArgs: [Intl.getCurrentLocale().toUpperCase()],
        limit: 1
    );

    return record.first['gdprMarketing'].toString();

  }

  Future<String> getGdrpThirdPartyText() async {
    var db = await DbHelper.internal().db;

    List<Map<String, dynamic>> record =  await db.query(CompanyLegalWarningModel.nameTable,
        columns: ["gdprThirdParty"],
        where: "lang = ?",
        whereArgs: [Intl.getCurrentLocale().toUpperCase()],
        limit: 1
    );

    return record.first['gdprThirdParty'].toString();

  }


}
