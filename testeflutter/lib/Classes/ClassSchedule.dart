class ClassSchedule{
  late Map<int, int> _time;

  addTime(String time, int userId) {
    int num = int.parse(time);
    _time[num] = userId;
  }

  // addTimes(String timeEntry, String timeLeft) {
  //   int entry = int.parse(timeEntry);
  //   int left = int.parse(timeLeft);

  //   for (int num = entry; num <= left; num++)
  //     _time.add(num);
  // }

  void rmvTime(String time) {
    int entry = int.parse(time);
    _time[entry] = 0;
  }

  // List<String> returnTimes() {
  //   return _time.map((num) => num.toString()).toList();
  // }
}
