class ClassEnterprise
{
  var _idEnterprise;
  var _name;
  var _description;
  var _photo;
  var _cnpj;
  
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