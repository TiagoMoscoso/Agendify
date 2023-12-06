import 'package:testeflutter/Classes/ClassSchedule.dart';

class ClassService
{
  Map<DateTime, int> _schedules = {};

  schedule(DateTime dt, int userId) {
    _schedules[dt] = userId;
  }

  void unschedule(DateTime dt) {
    _schedules[dt] = 0;
  }

  getSchedules()
  {
    return _schedules;
  }

}