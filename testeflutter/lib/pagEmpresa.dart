import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendario.dart';

class PaginaEmpresa extends StatefulWidget {
  const PaginaEmpresa ({super.key});

  @override
  State<PaginaEmpresa> createState() => _PaginaEmpresa();
}

class _PaginaEmpresa extends State<PaginaEmpresa> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFD9D0C7),
      body: SafeArea(
        right: false,
        left: false,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.asset(
                            "assets/logoApp.png",
                            height: 120,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15.0,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nome da Empresa",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Color(0xFF7E72A6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Tipo de Serviço",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7E72A6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "À X Km de você",
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xFF7E72A6),
                              ),
                            ),
                            SizedBox(width: 65.0),
                            Text(
                              "5",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(width: 2.0),
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFAC33),
                              size: 17.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container( 
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFF7E72A6),
                  ),
                  child: TableCalendar(
                    calendarStyle: const CalendarStyle(
                      outsideTextStyle: TextStyle(color: Color(0xFFD9D0C7)),
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white),
                      todayDecoration: BoxDecoration(
                        color: Color(0xFFD9D0C7),
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(color: Color(0xFF7E72A6)),
                      selectedDecoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
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
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}