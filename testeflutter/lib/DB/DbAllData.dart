
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testeflutter/DB/DbTableEnterprise.dart';
import 'package:testeflutter/DB/DbTableService.dart';
import 'package:testeflutter/DB/DbTableUser.dart';

class DbAllData {
  static Future<Database> createDatabase() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'DataApp.db'),
      onCreate: (db, version) {
        DbTableService.createServiceTable(db);
        DbTableEnterprise.createEnterpriseTable(db);
        DbTableUser.createUserTable(db);
      },
      version: 1,
    );

    return database;
  }

}