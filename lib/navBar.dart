import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======
import 'profile.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
>>>>>>> b7944b51c2c486a6d80ae1a4fd29d7e416bd4ae8
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
<<<<<<< HEAD
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
=======
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Inicio',
      style: optionStyle,
    ),
    Text(
      'Pesquisa',
      style: optionStyle,
    ),
    Text(
      'Agenda',
      style: optionStyle,
    ),
    ProfileOriginal(),
>>>>>>> b7944b51c2c486a6d80ae1a4fd29d7e416bd4ae8
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
<<<<<<< HEAD
        child: _widgetOptions(user).elementAt(_selectedIndex), // Passe o User como argumento
=======
        child: _widgetOptions.elementAt(_selectedIndex),
>>>>>>> b7944b51c2c486a6d80ae1a4fd29d7e416bd4ae8
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 237, 237, 239),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
<<<<<<< HEAD
            label: 'Inicio',
=======
            label: 'Início',
>>>>>>> b7944b51c2c486a6d80ae1a4fd29d7e416bd4ae8
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
