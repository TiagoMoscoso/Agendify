import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import 'package:testeflutter/DB/DbTableService.dart';
import 'package:testeflutter/Firebase/Db/ServiceTableFB.dart';

class Agenda extends StatefulWidget {
  final ClassUser user;
  const Agenda ({super.key, required this.user});

  @override
  State<Agenda> createState() => _AgendaState(user: user);
}

class _AgendaState extends State<Agenda> {
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
  Map<DateTime, int> _horariosUsuario = {};
  ValueNotifier<List<DateTime>> _horariosDoDia = ValueNotifier([]);
  
  _AgendaState({required this.user});

  @override
  void initState() {
    super.initState();
    addHorarios();
    
  }

  Future addHorarios() async {
    //Preencher com histórico local
    _horariosUsuario = await DbTableService.GetHistoric(user.getIdUser());
  }

  List<DateTime> _getHorariosDoDia(DateTime day) {
    List<DateTime> listaTodos = List.of(_horariosUsuario.keys);
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFF7E72A6),
            ),
            child: Column(
              children: [
                TableCalendar(
                  locale: 'pt_BR',
                  calendarStyle: designCalendario,
                  headerStyle: designCabecalho,
                  daysOfWeekStyle: designDiasDaSemana,
                  calendarBuilders: construtorCalendario,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(_hoje.year, _hoje.month, _hoje.day),
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
                      _hoje = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour);
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
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
                const SizedBox(height: 8.0),
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
                              onTap: _horariosUsuario[value[index]] == 0 || value[index].isBefore(_hoje) || value[index].isAtSameMomentAs(_hoje) ? () {} : () { 
                                AlertDialog confirmar = AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    '${value[index].hour} - Desmarcar Horário?', 
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Color(0xFF7E72A6)),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget> [
                                        ElevatedButton(
                                          onPressed: () {
                                            
                                            DbTableService.DeleteUsertoTables(value[index]);
                                            ServiceTableFB.removeSchedule(_horariosUsuario[value[index]]!,value[index]);
                                            _horariosUsuario[value[index]] = 0;
                                            setState(() => _horariosDoDia = ValueNotifier(_getHorariosDoDia(_selectedDay!)));
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
                              title: _horariosUsuario[value[index]] == 0 || value[index].isBefore(_hoje) || value[index].isAtSameMomentAs(_hoje) ? Text('${value[index].hour}:00 - Evento Expirado') : Text('${value[index].hour}:00 - Evento Marcado'),
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
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}