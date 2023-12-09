import 'package:firebase_database/firebase_database.dart';

class EnterpriseQuery{
  EnterpriseQuery();

  Future<Object?> getEnterprise(String enterpriseSubstring) async {
    List<dynamic> enterprises = [];
    final databaseReference = FirebaseDatabase.instance.ref().child("/Empresa");
    try {
      DatabaseEvent dataSnapshot = await databaseReference.once();
      Map<dynamic, dynamic>? values = dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        values.forEach((key, keyValue) {//TA PEGANDO O INTEIRO NO .KEY
          // Check if the key contains the search name using Dart's contains method
          if (keyValue['name'].toString().contains(enterpriseSubstring) && enterprises.length < 5) {
            enterprises.add({key: keyValue});
            // Perform further actions with searchResults if needed
          }
        });
      }
    }
    catch (e){
      //print(enterprises);
      return enterprises;
    }
    return enterprises;
  }

}

