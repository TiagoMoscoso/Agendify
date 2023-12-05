import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class enterpriseQuery{
  enterpriseQuery();

  Future<Object> getEnterprise(String enterpriseSubstring) async {
    List<String> enterprises = [];
    final databaseReference = FirebaseDatabase.instance.ref().child("/Empresa");
    try {
      DatabaseEvent dataSnapshot = await databaseReference.once();
      Map<dynamic, dynamic>? values = dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        values.forEach((key, snapdb) {
          // Check if the key contains the search name using Dart's contains method
          if (key.toString().contains(enterpriseSubstring) && enterprises.length < 5) {
            enterprises.add(snapdb);
            // Perform further actions with searchResults if needed
          }
        });
      }

    }
    catch(e){
      return "";
    }
    return enterprises;
  }

}
