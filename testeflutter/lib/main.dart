import 'package:flutter/material.dart';
import 'package:testeflutter/login/login.dart';
import 'second.dart';
import 'second.dart';
import 'mainscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/home': (context) => const SecondScreen(), // Define the 'second' route
        '/login': (context) => const Login(),
        '/second': (context) => const SecondScreen(), // Define the 'second' route
        '/mainscreen':(context) => MainScreen()

      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
            // ignore: prefer_const_constructors
            SizedBox(
              width: 25,
              child:TextField(
                cursorColor: Colors.blueAccent,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(labelText: 'Nome:',border: UnderlineInputBorder()),
                onChanged: onTextChanged,
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            
            Text('Entered Text: $enteredText'),

            ElevatedButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/login'); // Navigate to 'second' route

                Navigator.pushNamed(context, '/mainscreen'); // Navigate to 'second' route

              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                )
              ),
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
        
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
