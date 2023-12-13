import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class EnterpriseTableFB
{
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<String> GetEnterprisePhotoFromFbDb(int id) async 
  {
    final storage = await FirebaseStorage.instance.ref("Empresa");
    
    try
    {
      final pathReference = await storage.child('image'+id.toString()+'.png').getDownloadURL();
      return pathReference;
    }
    catch(exeption)
    {
      final pathReference = await storage.child("fotoempresa.png").getDownloadURL();
      return pathReference;
    }
  }

  static Future<ClassEnterprise> GetEnterpriseFromFbDb(int id) async 
  {
    final databaseReference = FirebaseDatabase.instance.ref("/Empresa/"+id.toString());

    DatabaseEvent dataSnapshot = (await databaseReference.once());
    if (dataSnapshot.snapshot.value != null) 
    {

      ClassEnterprise enterpriseData = ClassEnterprise();
      enterpriseData.setId(id);
      enterpriseData.setCNPJ(dataSnapshot.snapshot.child("cnpj").value);
      enterpriseData.setDescription(dataSnapshot.snapshot.child("description").value);
      enterpriseData.setPhoto(await GetEnterprisePhotoFromFbDb(id));
      enterpriseData.setName(dataSnapshot.snapshot.child("name").value);
      return enterpriseData;
    }
    return ClassEnterprise();
  }

  static Future <List<ClassEnterprise>> GetEnterprisesList(int numero) async
  {
    //TO DO: refazer mais eficiente
    List<ClassEnterprise> listaEmpresas = [];
    final EnterpriseReference = database.ref('/Empresa');
    DatabaseReference  ref = EnterpriseReference.child("KeyControllerEnterprise");
    DatabaseEvent getBase = await ref.once();

    int auxID = getBase.snapshot.value as int;

    if(numero >= auxID)
    {
      
    }
    else
    {
      Set<int> indicesUsados = Set<int>();
      for(int x = 0; x < numero; x++)
      {
        int numeroAleatorio = Random().nextInt(auxID + 1);

        if(indicesUsados.contains(numeroAleatorio))
        {
          x--;
        }
        else
        {
          listaEmpresas.add( await GetEnterpriseFromFbDb(numeroAleatorio));
          indicesUsados.add(numeroAleatorio);
        }

      }
    }
    return listaEmpresas;
  }

  static Future <List<ClassEnterprise>> GetMoreEnterprisesList(int numero, List<ClassEnterprise> nomesEnt) async
  {
    //TO DO: refazer mais eficiente
    List<ClassEnterprise> listaEmpresas = [];
    final EnterpriseReference = database.ref('/Empresa');
    DatabaseReference  ref = EnterpriseReference.child("KeyControllerEnterprise");
    DatabaseEvent getBase = await ref.once();

    int auxID = getBase.snapshot.value as int;

    if(numero >= auxID)
    {
      
    }
    else
    {
      Set<int> indicesUsados = Set<int>();
      for (ClassEnterprise item in nomesEnt) 
      {
        try 
        {
          indicesUsados.add(item.getid() as int);
        } on Exception catch (e) {
          indicesUsados.add(await item.getid());
        }
      }

      for(int x = 0; x < numero; x++)
      {
        int numeroAleatorio = Random().nextInt(auxID + 1);

        if(indicesUsados.contains(numeroAleatorio))
        {
          x--;
        }
        else
        {
          listaEmpresas.add(await GetEnterpriseFromFbDb(numeroAleatorio));
          indicesUsados.add(numeroAleatorio);
        }

      }
    }
    return listaEmpresas;
  }
}