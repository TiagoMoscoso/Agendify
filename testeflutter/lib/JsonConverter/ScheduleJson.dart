
Map<String, dynamic> scheduleToJson(DateTime value, int idUser) {
  return 
  {
    value.toUtc().hour.toString() : idUser.toString(),
  };
}


