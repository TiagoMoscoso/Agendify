import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import '../../JsonConverter/UserToJson.dart';

class UserTableFB{
  
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<int> InsertInDatabase(ClassUser user) async {

    final newUserReference = database.ref('/users');
    
    DatabaseReference  ref = newUserReference.child("KeyController");
    DatabaseEvent getBase = await ref.once();

    var auxID = getBase.snapshot.value;

    user.setIdUser(auxID);

    newUserReference.update(UserToJson(user));

    if(int.tryParse(auxID.toString()) != null) 
    {
      Map<String, Object?> value = {};

      value["KeyController"] = (int.parse(auxID.toString()) + 1).toString();

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
}