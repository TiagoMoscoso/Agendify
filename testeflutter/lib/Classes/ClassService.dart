import 'package:testeflutter/Classes/ClassSchedule.dart';

class ClassService
{
  var _idService;
  Map<DateTime, ClassSchedule> _schedules = {};

  setId(idService)
  {
    _idService = idService;
  }
  getIdservice()
  {
    return _idService;
  }

  addSchedule(DateTime dt , ClassSchedule schedule)
  {
    _schedules[dt] = schedule;
  }

  getSchedule(DateTime dt )
  {
    return _schedules[dt];
  }

}