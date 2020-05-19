import 'dart:async';
import 'package:myutility/app/models/company_model.dart';
import 'package:myutility/app/models/login_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = new DbHelper.internal();

  factory DbHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DbHelper.internal();

  initDb() async {
    var theDb = await openDatabase("myutility.db", version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(LoginModel.create);
    await db.execute(CompanyModel.create);
    await db.execute(CompanyContactModel.create);
    await db.execute(CompanyLegalWarningModel.create);
  }
}
