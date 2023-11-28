import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'package:testeflutter/Firebase/Db/EnterpriseTableFB.dart';
import 'package:testeflutter/Firebase/Db/UserTableFB.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ClassEnterprise> top10ent = [];
  List<ClassEnterprise> nomesEnt = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    loadData();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      loadMoreData();
    }
  }

  Future<void> loadData() async {
    top10ent = await EnterpriseTableFB.GetEnterprisesList(10);
    nomesEnt = await EnterpriseTableFB.GetEnterprisesList(10);
  }

 Future<void> loadMoreData() async {
  await Future.delayed(const Duration(seconds: 2));
  List<ClassEnterprise> additionalData = await EnterpriseTableFB.GetMoreEnterprisesList(10, nomesEnt);
  setState(() {
    nomesEnt.addAll(additionalData);
  });
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildMainScreen();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget buildMainScreen() {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];

    final List<String> nomesCategorias = [
      'Salão de Beleza',
      'Clínica Médica',
      'Restaurante',
      'Academia',
      'Salão de Massagem',
      'Oficina Mecânica',
    ];

    final List<Widget> top10 = top10ent
        .map(
          (item) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 10),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: const Color(0xFF7E72A6), width: 1.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        item.getPhoto(),
                        fit: BoxFit.cover,
                        width: 90.0,
                        height: 90.0,
                      ),
                    ),
                  ),
                  Text(
                    item.getName(),
                    style: const TextStyle(
                      color: Color(0xFF7E72A6),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();

    final List<Widget> categorias = imgList
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        nomesCategorias[imgList.indexOf(item)],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFD9D0C7),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Bem vindo de volta!",
                    style: TextStyle(
                      color: Color(0xFF7E72A6),
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        "Em alta",
                        style: TextStyle(
                          color: Color(0xFF7E72A6),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(width: 5.0),
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.orange[900],
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 2.0,
                    height: 150,
                    enlargeCenterPage: false,
                    viewportFraction: 0.25,
                  ),
                  items: top10,
                ),
                const SizedBox(height: 5.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Categorias",
                        style: TextStyle(
                          color: Color(0xFF7E72A6),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 5.0),
                      Icon(
                        Icons.list_rounded,
                        color: Color(0xFF7E72A6),
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 2.0,
                    height: 150,
                    enlargeCenterPage: false,
                    viewportFraction: 0.7,
                  ),
                  items: categorias,
                ),
                const SizedBox(height: 10.0),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: nomesEnt.length,
                  itemBuilder: (context, index) {
                  if (index < nomesEnt.length) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xFF7E72A6), width: 1),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            nomesEnt[index].getPhoto(),
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: Text(
                          nomesEnt[index].getName(),
                          style: const TextStyle(color: Color(0xFF7E72A6)),
                        ),
                        subtitle: Text(
                          'Nota: ${Random().nextInt(6)}',
                          style: const TextStyle(color: Color(0xFF7E72A6)),
                        ),
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
