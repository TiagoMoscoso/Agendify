import 'package:flutter/material.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import 'package:testeflutter/DB/DbAllData.dart';
import 'package:testeflutter/DB/DbTableUser.dart';
import 'package:testeflutter/pagEmpresa.dart';
import 'package:testeflutter/perfil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mainscreen.dart';
import 'login/login.dart' as login;
import 'config.dart' as config;
import 'Cadastro.dart' as cadastro;
import 'searchBar.dart' as searchBar;
import 'agenda.dart' as agenda;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  runApp(const MyApp());
  await DbAllData.createDatabase();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ClassUser user = await DbTableUser.GetLastUser();
  Profile(user: user);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClassUser>(
      future: DbTableUser.GetLastUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            ClassUser user = snapshot.data!;
            return MaterialApp(
              title: 'Agendify',
              routes: {
                '/mainscreen': (context) => const MainScreen(),
                '/busca': (context) => const searchBar.SearchPage(),
                '/login': (context) => const login.Login(),
                '/config': (context) => const config.ConfigScreen(),
                '/agenda': (context) => const agenda.Agenda(),
                '/perfil': (context) => ProfileOriginal(user: user),
                '/cadastro': (context) => const cadastro.CadastroPage(),
                '/pagEmpresa': (context) => const PaginaEmpresa(),
              },
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                useMaterial3: true,
                textTheme: GoogleFonts.rubikTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              home: const MyHomePage(title: "Nav Agendify"),
              debugShowCheckedModeBanner: false,
            );
          } else {
            return const CircularProgressIndicator();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                Navigator.pushNamed(context, '/perfil'); // Navigate to 'second' route
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pagEmpresa'); // Navigate to 'second' route
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                )
              ),
              child: const Text('Página Empresa'),
            ),
          ],
        ),
        
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
