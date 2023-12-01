class ClassSchedule{
  List<int> _time = [];

  addTime(String time) {
    int num = int.parse(time);
    _time.add(num);
  }

  addTimes(String timeEntry, String timeLeft) {
    int entry = int.parse(timeEntry);
    int left = int.parse(timeLeft);

    for (int num = entry; num <= left; num++)
      _time.add(num);
  }

  void rmvTime(String time) {
    int entry = int.parse(time);
    _time.remove(entry);
  }

  List<String> returnTimes() {
    return _time.map((num) => num.toString()).toList();
  }
}
