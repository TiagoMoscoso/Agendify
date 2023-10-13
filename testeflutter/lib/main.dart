import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import 'package:testeflutter/DB/DbAllData.dart';
import 'package:testeflutter/DB/DbTableUser.dart';
import 'package:testeflutter/profile.dart';
import 'second.dart';
import 'mainscreen.dart';
import 'login/login.dart' as login;
import 'config.dart' as config;
import 'profile.dart' as profile;
import 'Cadastro.dart' as cadastro;
import 'searchBar.dart' as searchBar;
import 'agenda.dart' as agenda;
Future<void> main() async {
  runApp(const MyApp());
  await DbAllData.createDatabase();

  ClassUser user = new ClassUser();
  user.setName("tegas");
  user.setEmail("tegas@gmail.com");
  user.setTelephone("+31 99af01301");
  user.setPhoto("pasassafd");
  await user.setIdUser(await DbTableUser.addUsertoTables(user));

  var x = user.getIdUser();
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClassUser>(
      future: DbTableUser.GetLastUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            ClassUser user = snapshot.data!;
            return MaterialApp(
              title: 'Agendfy',
              routes: {
                '/second': (context) => const SecondScreen(),
                '/mainscreen': (context) => MainScreen(),
                '/login': (context) => const login.Login(),
                '/config': (context) => const config.ConfigScreen(),
                '/profile': (context) => Profile(User: user),
                '/cadastro': (context) => const cadastro.CadastroPage(),
                '/busca': (context) => const searchBar.MyApp(),
                '/agenda': (context) => const agenda.Agenda(),
              },
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                useMaterial3: true,
              ),
              home: const MyHomePage(title: 'Nav Agendfy'),
            );
          } else {
            return CircularProgressIndicator();
          }
        } else {
          return CircularProgressIndicator();
        }
      },
<<<<<<< HEAD
=======
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Nav Agendfy'),
      debugShowCheckedModeBanner: false,
>>>>>>> 4251627fbd4eed4c4ef74777bd64981d572e2562
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  String enteredText = '';

  void onTextChanged(String text) {
    setState(() {
      enteredText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login'); // Navigate to 'second' route
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                )
              ),
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mainscreen'); // Navigate to 'second' route
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                )
              ),
              child: const Text('Tela Principal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile'); // Navigate to 'second' route
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                )
              ),
              child: const Text('Perfil'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/config'); // Navigate to 'second' route
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                )
              ),
              child: const Text('Configurações'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro'); // Navigate to 'second' route
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                )
              ),
              child: const Text('Cadastro'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/busca'); // Navigate to 'second' route
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                )
              ),
              child: const Text('Busca'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/agenda'); // Navigate to 'second' route
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                )
              ),
              child: const Text('Agenda'),
            ),
          ],
        ),
        
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
