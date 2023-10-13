import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbTableService{
  static void createServiceTable(Database db) {
    db.execute(
      'CREATE TABLE Service(idService INTEGER PRIMARY KEY, name TEXT, photo TEXT)'
    );
  }
  
}