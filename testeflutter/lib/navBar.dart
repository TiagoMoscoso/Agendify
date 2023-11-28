import 'package:flutter/material.dart';
import 'perfil.dart';
import 'agenda.dart';
import 'searchBar.dart';
import 'mainscreen.dart';
import 'package:testeflutter/Classes/ClassUser.dart';

class BottomNavigationBarExample extends StatefulWidget {
  final ClassUser user;
  const BottomNavigationBarExample({super.key, required this.user});
  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState(user: user);
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  final ClassUser user; // Declare uma variável para armazenar o User

  _BottomNavigationBarExampleState({required this.user}); // Construtor que recebe o User

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions(ClassUser user) => <Widget>[
    const MainScreen(),
    const SearchPage(),
    const Agenda(),
    Profile(user: user),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions(user).elementAt(_selectedIndex), // Passe o User como argumento
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 237, 237, 239),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
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
