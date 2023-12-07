import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:testeflutter/Firebase/Db/ServiceTable.dart';
import 'package:testeflutter/horario.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'calendario.dart';

class PaginaEmpresa extends StatefulWidget {
  final ClassEnterprise empresa;
  const PaginaEmpresa ({super.key, required this.empresa});

  @override
  State<PaginaEmpresa> createState() => _PaginaEmpresa(empresa: empresa);
}

class _PaginaEmpresa extends State<PaginaEmpresa> {
  ClassEnterprise empresa;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
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
  late ValueNotifier<List<DateTime>> _horariosDoDia;

  _PaginaEmpresa({required this.empresa});

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    for(int j = 0; j < 3; j++) {
      for (int i = 0; i < 24; i++) {
        DateTime hour = DateTime(_selectedDay!.year, _selectedDay!.month, (_selectedDay!.day) + j, i);
        _horarios[hour] = 0;  
      }
    }
    // addHorarios();
    _horariosDoDia = ValueNotifier(_getHorariosDoDia(_selectedDay!));
  }

  Future addHorarios() async {
    empresa = await ServiceTableFB.GetServiceFromFbDb(empresa);
    _horarios = empresa.service.getSchedules();
  }

  List<DateTime> _getHorariosDoDia(DateTime day) {
    List<DateTime> listaTodos = List.of(_horarios.keys);
    List<DateTime> horariosDoDia = [];
    for(DateTime horario in listaTodos) {
      if(horario.day == day.day) horariosDoDia.add(horario); 
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
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
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
                            _horariosDoDia = ValueNotifier(_getHorariosDoDia(_selectedDay!));
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
                                    onTap: _horarios[value[index]] != 0 ? () {} : () { 
                                      AlertDialog confirmar = AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(
                                          '${value[index].hour} - Marcar Horário?', 
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Color(0xFF7E72A6)),
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                  _horarios[value[index]] = 1;
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
                                    title: _horarios[value[index]] != 0 ? Text('${value[index].hour} - Ocupado') : Text('${value[index].hour} - Disponível'),
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