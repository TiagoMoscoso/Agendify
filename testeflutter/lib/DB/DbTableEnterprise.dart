import 'package:sqflite/sqflite.dart';


class DbTableEnterprise {
  static void createEnterpriseTable(Database db) {
    db.execute(
      'CREATE TABLE Enterprise(idEnterprise INTEGER PRIMARY KEY, name TEXT, description TEXT, photo TEXT)'
    );
  }

}
