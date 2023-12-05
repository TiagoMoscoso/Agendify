import 'package:firebase_database/firebase_database.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'package:testeflutter/Classes/ClassSchedule.dart';
import 'package:testeflutter/Classes/ClassService.dart';

class ServiceTableFB
{
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<ClassEnterprise> GetServiceFromFbDb(ClassEnterprise Enterprise, int idService) async 
  {
    final databaseReference = FirebaseDatabase.instance.ref("/Service/"+Enterprise.getid().toString()+"/"+idService.toString());

    DatabaseEvent dataSnapshot = (await databaseReference.once());
    if (dataSnapshot.snapshot.value != null) 
    {
      Enterprise.services[idService].addSchedule(dataSnapshot.snapshot.child("dt").value as DateTime, dataSnapshot.snapshot.child("schedule").value as ClassSchedule);
    }
    return Enterprise;
  }
}