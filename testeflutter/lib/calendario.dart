import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class Calendario extends StatefulWidget {
  const Calendario ({super.key});
  
  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: const CalendarStyle(
        outsideTextStyle: TextStyle(color: Color(0xFFD9D0C7)),
        defaultTextStyle: TextStyle(color: Colors.white),
        weekendTextStyle: TextStyle(color: Colors.white),
        todayDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        todayTextStyle: TextStyle(color: Color(0xFF7E72A6)),
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        selectedTextStyle: TextStyle(color: Color(0xFF7E72A6)),
      ),
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(color: Colors.white),
        formatButtonVisible: false,
        leftChevronIcon: Icon(Icons.chevron_left_rounded, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right_rounded, color: Colors.white),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Colors.white),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          String text;
          switch (day.weekday) {
            case DateTime.monday:
              text = 'Seg';
              break;
            case DateTime.tuesday:
              text = 'Ter';
              break;
            case DateTime.wednesday:
              text = 'Qua';
              break;
            case DateTime.thursday:
              text = 'Qui';
              break;
            case DateTime.friday:
              text = 'Sex';
              break;
            case DateTime.saturday:
              text = 'Sáb';
              break;
            case DateTime.sunday:
              text = 'Dom';
              break;
            default:
              text = 'Err';
              break;
          }
          return Center(child: Text(text,style: const TextStyle(color: Colors.white)));
        },
        // headerTitleBuilder: (context, day) {
        //   String text;
        //   switch(day.month) {
        //     case DateTime.october:
        //       text = 'Outubro ';
        //       break;
        //     default:
        //       text = 'Erro';
        //       break;
        //   }
        //   return Text(text, style: const TextStyle(color: Colors.white));
        // },
      ),
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      focusedDay: _focusedDay,
      firstDay: DateTime(_focusedDay.year, _focusedDay.month - 3, _focusedDay.day),
      lastDay: DateTime(_focusedDay.year, _focusedDay.month + 3, _focusedDay.day), 
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}