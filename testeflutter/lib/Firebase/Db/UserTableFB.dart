import 'dart:async';
import "../../Crypto/Crypto.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import 'package:testeflutter/JsonConverter/PasswordJson.dart';
import '../../JsonConverter/UserToJson.dart';

class UserTableFB
{
  
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<int> InsertInDatabase(ClassUser user, String password) async {

    final newUserReference = database.ref('/users');
    final UserPassword = database.ref('/password');

    DatabaseReference  ref = newUserReference.child("KeyController");
    DatabaseEvent getBase = await ref.once();

    var auxID = getBase.snapshot.value;

    user.setIdUser(auxID);

    newUserReference.update(UserToJson(user));
    UserPassword.update(UserPasswordToJson(user.getIdUser(),password));

    if(int.tryParse(auxID.toString()) != null) 
    {
      Map<String, Object?> value = {};

      value["KeyController"] = (int.parse(auxID.toString()) + 1);

      newUserReference.update(value);

      return int.parse(auxID.toString());
    }

    return -1;
  }


  static Future<bool> EmailRegistred(String email) async 
  {
    final databaseReference = FirebaseDatabase.instance.ref();

    DatabaseEvent dataSnapshot = (await databaseReference.child('users').orderByChild('email').equalTo(email).once());

    if (dataSnapshot.snapshot.value != null) 
    {
      return true;
    } 
      else 
    {
      return false;
    }
  }

  static Future<bool> VerifyPassword(String email, String password) async 
  {
    int id = await EmailKey(email);
    final databaseReference = FirebaseDatabase.instance.ref("/password/"+id.toString());

    DatabaseEvent dataSnapshot = (await databaseReference.child("password").once());
    
    if (dataSnapshot.snapshot.value != null) 
    {
      password = Converter(password);
      String aux = dataSnapshot.snapshot.value.toString();
      if(password == aux)
      {
        return true;
      }
    } 
    
    return false;
    
  }


  static Future<int> EmailKey(String email) async 
  {
    final databaseReference = FirebaseDatabase.instance.ref();

    DatabaseEvent dataSnapshot = (await databaseReference.child('users').orderByChild('email').equalTo(email).once());

    if (dataSnapshot.snapshot.value != null) 
    {
      var aux = dataSnapshot.snapshot.children.first.key.toString();
      if(int.tryParse(aux) != null)
      {
        return int.parse(aux);
      }
    } 
    return -1;
  }
}