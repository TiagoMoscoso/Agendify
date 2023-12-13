import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DbTableService{
  static void createServiceTable(Database db) {
    db.execute(
      'CREATE TABLE Service(idEnterprise INTEGER, idUser INTEGER, dt DATETIME)'
    );
  }
  
  static Future<int> addHistoric(int idEnterprise, int idUser, DateTime dt) async {//CREATE

    var db = await openDatabase(join(await getDatabasesPath(), 'DataApp.db'));
    var insertSql = "INSERT INTO Service (idEnterprise, idUser, dt) VALUES (?, ?, ?)";
    
    String formattedDateTime = dt.toIso8601String();

    int rowsAffected = await db.rawInsert(insertSql, [idEnterprise,idUser,formattedDateTime]);


    if (rowsAffected > 0) {
      return rowsAffected;
    }
    
    return -1;
  }
  

  static Future<Map<DateTime,int>> GetHistoric(int idUser) async {//READ

    final db = await openDatabase(join(await getDatabasesPath(), 'DataApp.db'));

    Map<DateTime,int> lsDateTime = {};
    
    var searchSql = "SELECT dt, idEnterprise FROM Service WHERE idUser = ? ORDER BY idUser DESC";
    var results = await db.rawQuery(searchSql, [idUser]);
    

    if (results.isNotEmpty) 
    {
      for (var result in results) {

        DateTime dt = DateTime.parse(result['dt'] as String);
        int idEnterprise = result['idEnterprise'] as int;

        lsDateTime[dt]=idEnterprise;
      }
    }
    
    return lsDateTime; 
  }


  static Future<int> DeleteUsertoTables(DateTime dt) async {//DELETE

    final db = await openDatabase(join(await getDatabasesPath(), 'DataApp.db'));

    var deleteSql = "DELETE FROM Service WHERE dt = ?";

    String formattedDateTime = dt.toIso8601String();

    int rowsAffected = await db.rawUpdate(deleteSql, [formattedDateTime]);


    if (rowsAffected > 0) {
      return rowsAffected;
    }
    
    return -1;
  }

  
}