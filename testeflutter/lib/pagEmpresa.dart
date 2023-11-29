import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:testeflutter/evento.dart';
import 'calendario.dart';

class PaginaEmpresa extends StatefulWidget {
  const PaginaEmpresa ({super.key});

  @override
  State<PaginaEmpresa> createState() => _PaginaEmpresa();
}

class _PaginaEmpresa extends State<PaginaEmpresa> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final Map<DateTime, List<Evento>> _horarios = {};
  late final ValueNotifier<List<Evento>> _horariosDoDia;
  List<Evento> horas = List.generate(13, (index) => Evento(hora: (index+8).toString() + ':00'));

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _horarios.addAll({
      _selectedDay!: horas.toList(),
    });
    _horariosDoDia = ValueNotifier(_getHorariosDoDia(_selectedDay!));
  }

  List<Evento> _getHorariosDoDia(DateTime day) {
    return _horarios[day] ?? [];
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
                  child: Column(
                    children: <Widget> [
                      TableCalendar(
                        calendarStyle: const CalendarStyle(
                          markerDecoration: BoxDecoration(color: Colors.transparent),
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
                        firstDay: DateTime.utc(_focusedDay.year, _focusedDay.month - 3, _focusedDay.day),
                        lastDay: DateTime.utc(_focusedDay.year, _focusedDay.month + 3, _focusedDay.day), 
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            if(_horarios.containsKey(_selectedDay) == false) {
                              _horarios.addAll({
                              _selectedDay!: horas.toList(),
                              });
                              _horariosDoDia.value = _getHorariosDoDia(_selectedDay!);
                            }
                          });
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        eventLoader: (day) {
                          return _getHorariosDoDia(day);
                        },
                      ),
                      const SizedBox(height: 8.0,),
                      const Divider(
                        color: Colors.white,
                        endIndent: 15.0,
                        indent: 15.0,
                        thickness: 2.0,
                      ), 
                      const SizedBox(height: 8.0,),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF7E72A6),
                        ),
                        height: 250,
                        child: ValueListenableBuilder <List<Evento>>(
                          valueListenable: _horariosDoDia, 
                          builder: (context, value, _) {
                            return ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: ListTile(
                                    onTap: () { 
                                      AlertDialog confirmar = AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(
                                          '${value[index].hora} - Marcar Horário?', 
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Color(0xFF7E72A6)),
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                  _horarios[_selectedDay]!.removeAt(index);
                                                  _horariosDoDia.value = _getHorariosDoDia(_selectedDay!);
                                                  Navigator.of(context).pop();
                                                },
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF7E72A6)),),
                                                child: const Icon(Icons.done_rounded, color: Colors.white,),
                                              ),
                                              const SizedBox(width: 5.0,),
                                              ElevatedButton(
                                                onPressed: () {
                                                  _horariosDoDia.value = _getHorariosDoDia(_selectedDay!);
                                                  Navigator.of(context).pop();
                                                },
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF7E72A6)),),
                                                child: const Icon(Icons.close_rounded, color: Colors.white,),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return confirmar;
                                        }
                                      );
                                    },
                                    title: Text(value[index].hora),
                                    textColor: Colors.white,
                                    trailing: const Icon(
                                      Icons.chevron_right_rounded,
                                      color: Colors.white, 
                                      size: 30.0
                                    ),
                                  ),
                                );
                              }
                            );
                          }
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
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