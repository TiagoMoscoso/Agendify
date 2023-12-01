class ClassUser
{
  var _idUser;
  var _name;
  var _telephone;
  var _email;
  var _photo;
  
  setIdUser(idUser) async
  {
    if(idUser.runtimeType == Future<int>) {
      idUser = await idUser;
    }
    _idUser = idUser;
  }
  setName(name)
  {
    _name = name;
  }

  setTelephone(telephone)
  {
    _telephone = telephone;
  }

  setEmail(email)
  {
    _email = email;
  }

  setPhoto(photo)
  {
    _photo = photo;
  }

  getIdUser()
  {
    return _idUser;
  }

  getName()
  {
    return _name;
  }

  getTelephone()
  {
    return _telephone;
  }

  getEmail()
  {
    return _email;
  }

  getPhoto()
  {
    return _photo;
  }

  getFromDB()
  {
    
  }
}