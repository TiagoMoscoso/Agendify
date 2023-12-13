import 'dart:math';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:testeflutter/DB/DbTableService.dart';
import 'package:testeflutter/Firebase/Db/ServiceTableFB.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'Classes/ClassUser.dart';

class PaginaEmpresa extends StatefulWidget {
  final ClassEnterprise empresa;
  final ClassUser user;
  const PaginaEmpresa ({super.key, required this.empresa, required this.user});

  @override
  State<PaginaEmpresa> createState() => _PaginaEmpresa(empresa: empresa, user: user);
}

class _PaginaEmpresa extends State<PaginaEmpresa> {
  ClassEnterprise empresa;
  ClassUser user;
  DateTime? _selectedDay;
  static DateTime _hoje = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour);
  DateTime _focusedDay = DateTime.utc(_hoje.year, _hoje.month, _hoje.day);
  CalendarStyle designCalendario = 
  const CalendarStyle(
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
  );
  HeaderStyle designCabecalho = 
  const HeaderStyle(
    titleTextStyle: TextStyle(color: Colors.white),
    formatButtonVisible: false,
    leftChevronIcon: Icon(Icons.chevron_left_rounded, color: Colors.white),
    rightChevronIcon: Icon(Icons.chevron_right_rounded, color: Colors.white),
  );
  DaysOfWeekStyle designDiasDaSemana =
  const DaysOfWeekStyle (
    weekdayStyle: TextStyle(color: Colors.white),
    weekendStyle: TextStyle(color: Colors.white),
  );
  CalendarBuilders construtorCalendario = 
  CalendarBuilders(
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
  );
  Map<DateTime, int> _horarios = {};
  ValueNotifier<List<DateTime>> _horariosDoDia = ValueNotifier([]);

  _PaginaEmpresa({required this.empresa, required this.user});

  @override
  void initState() {
    super.initState();
    addHorarios();
  }

  Future addHorarios() async {
    empresa.service.setSchedules(await ServiceTableFB.GetServiceFromFbDb(empresa)); 
    _horarios = empresa.service.getSchedules();
  }

  List<DateTime> _getHorariosDoDia(DateTime day) {
    List<DateTime> listaTodos = List.of(_horarios.keys);
    List<DateTime> horariosDoDia = [];
    for(DateTime horario in listaTodos) {
      if(horario.day == day.day && horario.month == day.month && horario.year == day.year) horariosDoDia.add(horario);
    }
    return horariosDoDia;
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        empresa.getPhoto(),
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            empresa.getName(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Color(0xFF7E72A6),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            height: 50.0,
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  empresa.getDescription(),
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF7E72A6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${Random().nextInt(6)}',
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(width: 2.0),
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFAC33),
                                size: 17.0,
                              ),
                            ],
                          ),
                        ],
                      ),
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
                        locale: 'pt_BR',
                        calendarStyle: designCalendario,
                        headerStyle: designCabecalho,
                        daysOfWeekStyle: designDiasDaSemana,
                        calendarBuilders: construtorCalendario,
                        focusedDay: _focusedDay,
                        firstDay: DateTime.utc(_hoje.year, _hoje.month - 3, _hoje.day),
                        lastDay: DateTime.utc(_hoje.year, _hoje.month + 3, _hoje.day), 
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onPageChanged: (focusedDay) {
                          _hoje = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour);
                          _focusedDay = focusedDay;
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            _hoje = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour);
                            for (int i = 8; i <= 20; i++) {
                              DateTime hour = DateTime.utc(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day, i);
                              _horarios.putIfAbsent(hour, () => 0);  
                            }
                            _horariosDoDia = ValueNotifier(_getHorariosDoDia(_selectedDay!));
                          });
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
                        child: ValueListenableBuilder <List<DateTime>>(
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
                                    onTap: _horarios[value[index]] != 0 || value[index].isBefore(_hoje) || value[index].isAtSameMomentAs(_hoje) ? () {} : () { 
                                      AlertDialog confirmar = AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(
                                          '${value[index].hour}:00 - Marcar Horário?', 
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Color(0xFF7E72A6)),
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                  _horarios[value[index]] = user.getIdUser();
                                                  setState(() => _horariosDoDia = ValueNotifier(_getHorariosDoDia(_selectedDay!)));
                                                  empresa.service.addSchedule(value[index], _horarios[value[index]]!);
                                                  ServiceTableFB.addSchedule(empresa.getid(), value[index], user.getIdUser());
                                                  DbTableService.addHistoric(empresa.getid(),user.getIdUser(),value[index]);
                                                  Navigator.of(context).pop();
                                                },
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF7E72A6)),),
                                                child: const Icon(Icons.done_rounded, color: Colors.white,),
                                              ),
                                              const SizedBox(width: 5.0,),
                                              ElevatedButton(
                                                onPressed: () {
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
                                    title: _horarios[value[index]] != 0 || value[index].isBefore(_hoje) || value[index].isAtSameMomentAs(_hoje) ? Text('${value[index].hour}:00 - Indisponível') : Text('${value[index].hour}:00 - Disponível'),
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