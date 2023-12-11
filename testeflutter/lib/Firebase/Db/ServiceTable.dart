import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'package:testeflutter/Classes/ClassSchedule.dart';
import 'package:testeflutter/Classes/ClassService.dart';
import 'package:testeflutter/JsonConverter/ScheduleJson.dart';

class ServiceTableFB
{
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<Map<DateTime, int>> GetServiceFromFbDb(ClassEnterprise enterprise) async
  {
    final databaseReference = FirebaseDatabase.instance.ref("/Services/"+enterprise.getid().toString()+"/");
    Map<DateTime, int> horarios = {};
    try{
      DatabaseEvent dataSnapshot = (await databaseReference.once());
      Map<dynamic, dynamic>? values = dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null){
        values.forEach((key, keyValue){
          DateTime aux = DateFormat("yyyy-MM-dd HH:mm:ss").parse(key).toUtc().subtract(Duration(hours: 3));
          print(aux);
          horarios[aux] = int.parse(keyValue);
        });
      }
    }
    catch(e){
      print(e);
    }
    print(horarios);
    return horarios;
  }

  static void addSchedule(int id, DateTime value, int idUser) async {
    final newSchedule = database.ref('/Services/$id');
    try 
    {
      String aux = value.toString().split(".")[0];
      await newSchedule.set(scheduleToJson(aux, idUser));
    } catch (error) {
      print("Erro ao definir dados no Firebase: $error");
    }

  }

}