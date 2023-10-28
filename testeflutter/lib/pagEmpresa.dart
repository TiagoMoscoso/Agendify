import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PaginaEmpresa extends StatefulWidget {
  const PaginaEmpresa ({super.key});

  @override
  State<PaginaEmpresa> createState() => _PaginaEmpresa();
}

class _PaginaEmpresa extends State<PaginaEmpresa> {

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
                              color: Color(0xFFFFAC33)
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      todayTextStyle: TextStyle(color: Color(0xFF7E72A6)),
                    ),
                    headerStyle: const HeaderStyle(
                      titleTextStyle: TextStyle(color: Colors.white),
                      formatButtonVisible: false,
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white),
                      weekendStyle: TextStyle(color: Colors.white),
                    ),
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2023, 9, 1),
                    lastDay: DateTime.utc(2033, 10, 1),
                    startingDayOfWeek: StartingDayOfWeek.monday,
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