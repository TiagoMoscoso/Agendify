class ClassService
{
  Map<DateTime, int> _schedules = {};

  void unschedule(DateTime dt) {
    _schedules[dt] = 0;
  }

  getSchedules()
  {
    return _schedules;
  }

  addSchedule(DateTime dt , int schedule)
  {
    _schedules[dt] = schedule;
  }

  getSchedule(DateTime dt )
  {
    return _schedules[dt]!;
  }
}