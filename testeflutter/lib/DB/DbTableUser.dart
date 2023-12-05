import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testeflutter/Classes/ClassUser.dart';


class DbTableUser{
  static void createUserTable(Database db) {
    db.execute(
      'CREATE TABLE User(idUser INTEGER, name TEXT, telephone TEXT, email TEXT, photo TEXT)'
    );
  }
 
  static Future<int> addUsertoTables(ClassUser user) async {//CREATE

    final db = await openDatabase(join(await getDatabasesPath(), 'DataApp.db'));
    var insertSql = "INSERT INTO User (idUser, name, telephone, email, photo) VALUES (?, ?, ?, ?, ?)";
    
    int rowsAffected = await db.rawInsert(insertSql, [user.getIdUser(),user.getName(), user.getTelephone(), user.getEmail(), user.getPhoto()]);


    if (rowsAffected > 0) {
      return rowsAffected;
    }
    
    return -1;
  }

  
  static Future<ClassUser> GetLastUser() async {//READ

    final db = await openDatabase(join(await getDatabasesPath(), 'DataApp.db'));
    ClassUser user = ClassUser();
    var searchSql = "SELECT * FROM User ORDER BY idUser DESC LIMIT 1";
    
    List<Map<String, dynamic>> results = await db.rawQuery(searchSql);

    if (results.isNotEmpty) 
    {
      Map<String, dynamic> lastUser = results[0];
      user.setIdUser(lastUser['idUser']);
      user.setName(lastUser['name']);
      user.setTelephone(lastUser['telephone']);
      user.setEmail(lastUser['email']);
      user.setPhoto(lastUser['photo']);
    }
    
    return user; 
  }

  static Future<int> UpdateUsertoTables(ClassUser user) async {//UPDATE

    final db = await openDatabase(join(await getDatabasesPath(), 'DataApp.db'));
    var updateSql = "UPDATE User SET name = ?, telephone = ?, email = ?, photo = ? WHERE idUser = ?";
    
    int rowsAffected = await db.rawUpdate(updateSql, [user.getName(),user.getTelephone(),user.getEmail(),user.getPhoto(),user.getIdUser()]);


    if (rowsAffected > 0) {
      return rowsAffected;
    }
    
    return -1;
  }

  static Future<int> DeleteUsertoTables(ClassUser user) async {//DELETE

    final db = await openDatabase(join(await getDatabasesPath(), 'DataApp.db'));

    var deleteSql = "DELETE FROM User WHERE idUser = ?";
    
    int rowsAffected = await db.rawUpdate(deleteSql, [user.getIdUser()]);


    if (rowsAffected > 0) {
      return rowsAffected;
    }
    
    return -1;
  }


}
