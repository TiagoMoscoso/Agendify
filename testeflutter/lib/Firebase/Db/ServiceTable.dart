import 'package:firebase_database/firebase_database.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'package:testeflutter/Classes/ClassSchedule.dart';
import 'package:testeflutter/Classes/ClassService.dart';
import 'package:testeflutter/JsonConverter/ScheduleJson.dart';

class ServiceTableFB
{
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<ClassEnterprise> GetServiceFromFbDb(ClassEnterprise enterprise) async 
  {
    final databaseReference = FirebaseDatabase.instance.ref("/Service/"+enterprise.getid().toString()+"/");

    DatabaseEvent dataSnapshot = (await databaseReference.once());
    if (dataSnapshot.snapshot.value != null) 
    {
      //enterprise.service.schedule(dataSnapshot.snapshot.child("dt").value as DateTime, dataSnapshot.snapshot.child("userId").value as int);
    }
    return enterprise;
  }

  static void addSchedule(int id, DateTime value, int idUser) async {
    final newSchedule = database.ref('/Services/$id');
    try 
    {
      await newSchedule.set(scheduleToJson(value, idUser));
    } catch (error) {
      print("Erro ao definir dados no Firebase: $error");
    }
    
  }

}