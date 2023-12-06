import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import 'package:testeflutter/DB/DbAllData.dart';
import 'package:testeflutter/DB/DbTableUser.dart';
import 'package:testeflutter/pagEmpresa.dart';
import 'package:testeflutter/perfil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'second.dart';
import 'mainscreen.dart';
import 'login/login.dart' as login;
import 'config.dart' as config;
import 'Cadastro.dart' as cadastro;
import 'searchBar.dart' as searchBar;
import 'agenda.dart' as agenda;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'navBar.dart';
import 'Firebase/Db/EnterpriseTableFB.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DbAllData.createDatabase();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
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
            var home;
            if(user.getName() != null)
            {
              home = BottomNavigationBarExample(user: user);
            }
            else
            {
              home = login.Login();
            }
            return MaterialApp(
              title: 'Agendify',
              routes: {
                '/second': (context) => const SecondScreen(),
                '/mainscreen': (context) => const MainScreen(),
                '/login': (context) => const login.Login(),
                '/config': (context) =>  config.ConfigScreen(),
                '/profile': (context) => Profile(user: user),
                '/cadastro': (context) => const cadastro.CadastroPage(),
                '/busca': (context) => const searchBar.SearchPage(),
                '/agenda': (context) => const agenda.Agenda(),
                //'/pagEmpresa': (context) => const PaginaEmpresa(),
                '/navBar': (context) => BottomNavigationBarExample(user: user)
              },
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                textTheme: GoogleFonts.rubikTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              home: home,
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/navBar'); // Navigate to 'second' route
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Border radius
                  )
              ),
              child: const Text('Nav-Bar-Interação-De-Telas'),
            ),
          ],
        ),

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
