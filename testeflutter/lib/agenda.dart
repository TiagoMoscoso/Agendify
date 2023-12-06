import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'horario.dart';

class Agenda extends StatefulWidget {
  const Agenda ({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // final Map<DateTime, List<Evento>> _eventos = {};
  // late final ValueNotifier<List<Evento>> _eventosSelecionados;
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
  

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // _eventosSelecionados = ValueNotifier(_getEventosDoDia(_selectedDay!));
  }

  // List<Evento> _getEventosDoDia(DateTime day) {
  //   return _eventos[day] ?? [];
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D0C7),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           scrollable: true,
      //           title: const Text("Nome do Evento"),
      //           content: Padding(
      //             padding: const EdgeInsets.all(8),
      //             child: TextField(
      //               controller: _controladorEvento,
      //             )
      //           ),
      //           actions: [
      //             ElevatedButton(
      //               onPressed: () {
      //                 _eventos.addAll({
      //                   _selectedDay!: [Evento(hora: _controladorEvento.text)],
      //                 });
      //                 Navigator.of(context).pop();
      //                 _eventosSelecionados.value = _getEventosDoDia(_selectedDay!);
      //               },
      //               child: const Text("Confirmar"),
      //             ),
      //           ],
      //         );
      //       }
      //     );
      //   },
      //   backgroundColor: const Color.fromARGB(255, 199, 192, 227), 
      //   child: const Icon(Icons.add), 
      // ),
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
                      // if(_horarios.containsKey(_selectedDay) == false) {
                      //   _horarios.addAll({
                      //   _selectedDay!: horas.toList(),
                      //   });
                      //   _horariosDoDia.value = _getHorariosDoDia(_selectedDay!);
                      // }
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  // eventLoader: (day) {
                  //   return _getHorariosDoDia(day);
                  // },
                ),
                const SizedBox(height: 8.0,),
                const Divider(
                  color: Colors.white,
                  endIndent: 15.0,
                  indent: 15.0,
                  thickness: 2.0,
                ), 
                const SizedBox(height: 8.0,),
                // Expanded(
                //   child: ValueListenableBuilder <List<Evento>>(
                //     valueListenable: _eventosSelecionados, 
                //     builder: (context, value, _) {
                //       return ListView.builder(
                //         itemCount: value.length,
                //         itemBuilder: (context, index) {
                //           return Container(
                //             margin: const EdgeInsets.symmetric(
                //               horizontal: 12.0,
                //               vertical: 4.0,
                //             ),
                //             decoration: BoxDecoration(
                //               border: Border.all(),
                //               borderRadius: BorderRadius.circular(14),
                //             ),
                //             child: ListTile(
                //               onTap: () => print(""),
                //               title: Text('${value[index]}')
                //             ),
                //           );
                //         }
                //       );
                //     }
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}