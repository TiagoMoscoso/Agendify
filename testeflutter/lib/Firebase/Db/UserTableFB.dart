import 'dart:async';

import 'package:testeflutter/Classes/ClassUser.dart';
import '../../JsonConverter/UserToJson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserTableFB{

  static Future<int> InsertInDatabase(ClassUser user) 
  async {

    final newUserReference = FirebaseFireStore.

    newUserReference.set(UserToJson(user));

    return 1;
  }

}