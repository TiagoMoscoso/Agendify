import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'Firebase/Db/EnterpriseTableFB.dart';

class EnterpriseQuery{
  EnterpriseQuery();

  static Future<List<ClassEnterprise>> getEnterprise(String enterpriseSubstring) async {
    List<ClassEnterprise> enterprises = [];
    final databaseReference = FirebaseDatabase.instance.ref().child("/Empresa");
    try {
      DatabaseEvent dataSnapshot = await databaseReference.once();
      Map<dynamic, dynamic>? values = dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        values.forEach((key, keyValue) {//TA PEGANDO O INTEIRO NO .KEY
          // Check if the key contains the search name using Dart's contains method
          if (keyValue['name'].toString().toLowerCase().contains(enterpriseSubstring.toLowerCase())) {
            ClassEnterprise enterprise = ClassEnterprise();
            enterprise.setId(int.parse(key.toString()));
            enterprise.setName(keyValue['name']);
            enterprise.setDescription(keyValue['description']);
            enterprise.setCNPJ(keyValue['cnpj']);
            //print(enterprise.getName()+" - "+enterprise.getid());
            enterprises.add(enterprise);
            // Perform further actions with searchResults if needed
          }
        });
      }
    }
    catch (e){
      print(e);
      return enterprises;
    }
    return enterprises;
  }

}

