import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'evento.dart';

class Agenda extends StatefulWidget {
  const Agenda ({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  DateTime? _diaSelecionado;
  DateTime _hoje = DateTime.now();
  CalendarFormat _formatoCalendario = CalendarFormat.month;
  Map<DateTime, List<Evento>> _eventos = {};
  late final ValueNotifier<List<Evento>> _eventosSelecionados;
  TextEditingController _controladorEvento = TextEditingController();

  @override
  void initState() {
    super.initState();
    _diaSelecionado = _hoje;
    _eventosSelecionados = ValueNotifier(_getEventosDoDia(_diaSelecionado!));
  }

  List<Evento> _getEventosDoDia(DateTime day) {
    return _eventos[day] ?? [];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF1E4),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: const Text("Nome do Evento"),
                content: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _controladorEvento,
                  )
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      _eventos.addAll({
                        _diaSelecionado!: [Evento(nome: _controladorEvento.text)],
                      });
                      Navigator.of(context).pop();
                      _eventosSelecionados.value = _getEventosDoDia(_diaSelecionado!);
                    },
                    child: const Text("Confirmar"),
                  ),
                ],
              );
            }
          );
        }, 
        child: Icon(Icons.add), 
      ),
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2023, 9, 1),
              lastDay: DateTime.utc(2033, 10, 1),
              focusedDay: _hoje,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(_diaSelecionado, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _diaSelecionado = selectedDay;
                  _hoje = focusedDay; 
                  _eventosSelecionados.value = _getEventosDoDia(_diaSelecionado!);
                });
              },
              calendarFormat: _formatoCalendario,
              onFormatChanged: (format) {
                setState(() {
                  _formatoCalendario = format;
                });
              },
              onPageChanged: (focusedDay) {
                _hoje = focusedDay;
              },
              eventLoader: (day) {
                return _getEventosDoDia(day);
              },
            ),
            Expanded(
              child: ValueListenableBuilder <List<Evento>>(
                valueListenable: _eventosSelecionados, 
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
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          onTap: () => print(""),
                          title: Text('${value[index]}')
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
    );
    
  }
}