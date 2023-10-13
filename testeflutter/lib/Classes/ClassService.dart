import 'package:testeflutter/Classes/ClassEnterprise.dart';

class ClassService extends ClassEnterprise
{
  var _idService;
  var _name;
  var _photo;
  setName(name)
  {
    _name = name;
  }

  getNameService()
  {
    return _name;
  }

  getIdservice()
  {
    return _idService;
  }

  getServicePhoto()
  {
    return _photo;
  }
}