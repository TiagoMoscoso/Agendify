import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import "../../Crypto/Crypto.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import 'package:testeflutter/JsonConverter/PasswordJson.dart';
import '../../JsonConverter/UserToJson.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  static Future<bool> VerifyPassword(String email, String passWord) async 
  {
    int id = await EmailKey(email);
    final databaseReference = FirebaseDatabase.instance.ref("/password/"+id.toString());

    DatabaseEvent dataSnapshot = (await databaseReference.child("Password").once());
    
    if (dataSnapshot.snapshot.value != null) 
    {
      passWord = Converter(passWord);
      String aux = dataSnapshot.snapshot.value.toString();
      if(passWord == aux)
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


  static Future<ClassUser> GetUserFromFbDb(String email) async 
  {
    int id = await EmailKey(email);
    final databaseReference = FirebaseDatabase.instance.ref("/users/"+id.toString());

    DatabaseEvent dataSnapshot = (await databaseReference.once());
    if (dataSnapshot.snapshot.value != null) 
    {

      ClassUser userData = ClassUser();
      userData.setIdUser(id);
      userData.setPhoto(await GetUserPhotoFromFbDb(id));
      userData.setName(dataSnapshot.snapshot.child("name").value);
      userData.setEmail(dataSnapshot.snapshot.child("email").value);
      userData.setTelephone(dataSnapshot.snapshot.child("telephone").value);
      return userData;
    }
    return ClassUser();
  }

  static Future<String> GetUserPhotoFromFbDb(int id) async {
    final storage = await FirebaseStorage.instance.ref("User");
    
    try
    {
      final pathReference = await storage.child('image'+id.toString()+'.png').getDownloadURL();
      return pathReference;
    }
    catch(exeption)
    {
      return await storage.child("fotoperfil.png").getDownloadURL();
    }
  }

  static Future<String> uploadImageFB(XFile image, var id) async 
  {
    final Reference storageReference = FirebaseStorage.instance.ref("User").child('image'+id.toString()+'.png');
    final UploadTask uploadTask = storageReference.putFile(File(image.path));

    Future<String> pathReference = FirebaseStorage.instance.ref("User").child("fotoperfil.png").getDownloadURL();

    await uploadTask.whenComplete(() async 
    {
      pathReference = storageReference.getDownloadURL();
    }).catchError((error) async {
      pathReference = FirebaseStorage.instance.ref("User").child("fotoperfil.png").getDownloadURL();
    });

    return pathReference;
  }

}