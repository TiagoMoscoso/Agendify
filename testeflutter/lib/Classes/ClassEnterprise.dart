import 'package:testeflutter/Classes/ClassService.dart';

class ClassEnterprise extends ClassService
{
  var _idEnterprise;
  var _name;
  var _description;
  var _photo;
  var _cnpj;
  ClassService service = new ClassService();

  setName(name)
  {
    _name = name;
  }

  setDescription(description)
  {
    _description = description;
  }

  setId(idEnterprise)
  {
   
    _idEnterprise = idEnterprise;
  
  }

  setCNPJ(cnpj)
  {
    _cnpj = cnpj;
  }
    
  setPhoto(photo)
  {
   
    _photo = photo;
  
  }
  getName()
  {
    return _name;
  }

  getid()
  {
    return _idEnterprise;
  }

  getDescription()
  {
    return _description;
  }

  getPhoto()
  {
    return _photo;
  }

  getCNPJ()
  {
    return _cnpj;
  }
}