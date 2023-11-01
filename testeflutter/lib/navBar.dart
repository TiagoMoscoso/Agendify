import 'package:flutter/material.dart';
import 'package:testeflutter/DB/DbTableUser.dart';
import 'package:testeflutter/perfil.dart';
import 'perfil.dart';
import 'agenda.dart';
import 'searchBar.dart';
import 'mainscreen.dart';

class BottomNavigationBarExample extends StatefulWidget {
  BottomNavigationBarExample({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = await DbTableUser.GetLastUser();
    setState(() {
      _widgetOptions = [
        MainScreen(),
        SearchPage(),
        Agenda(),
        //ProfileOriginal(user: user),
      ];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 237, 237, 239),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Iní­cio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Pesquisa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 100, 123, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}