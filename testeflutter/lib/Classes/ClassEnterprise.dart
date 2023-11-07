class ClassEnterprise
{
  var _idEnterprise;
  var _name;
  var _description;
  var _photo;
  
  setNameEnterprise(name)
  {
    _name = name;
  }

  setDescriptionEnterprise(description)
  {
    _description = description;
  }

  setEnterpriseById(idEnterprise)
  {
   
    _idEnterprise = idEnterprise;
  
  }

  getNameEnterprise()
  {
    return _name;
  }

  getidEnterprise()
  {
    return _idEnterprise;
  }

  getDescriptionEnterprise()
  {
    return _description;
  }

  getPhotoEnterprise()
  {
    return _photo;
  }
}