import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testeflutter/Classes/ClassEnterprise.dart';
import 'package:testeflutter/Firebase/Db/EnterpriseTableFB.dart';
import 'package:testeflutter/pagEmpresa.dart';
import 'package:testeflutter/searchBar.dart';

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

  var isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    loadData();
  }

void _onScroll() {
  if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
    loadMoreData();
  }
}

Future<void> loadData() async {
  top10ent = await EnterpriseTableFB.GetEnterprisesList(10);
  nomesEnt = List.from(top10ent);
  setState(() {
  });
  setState(() {
    isLoading = false;
  });
}

Future<void> loadMoreData() async {
  if (!isLoading) {

    double currentPosition = _scrollController.position.pixels;

    setState(() {
      isLoading = true;
    });

    List<ClassEnterprise> novosItens = await EnterpriseTableFB.GetMoreEnterprisesList(10, nomesEnt);

    setState(() {
      nomesEnt.addAll(novosItens);
      isLoading = false;
    });

    _scrollController.animateTo(
      currentPosition,
      duration: Duration(milliseconds: 500), 
      curve: Curves.easeInOut, 
    );
  }
}



  @override
  Widget build(BuildContext context) {
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
                  items: List.generate(
                    top10ent.length,
                    (index) {
                      final item = top10ent[index];
                      if (index < top10ent.length && item.getPhoto() != null) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaginaEmpresa(empresa: item),
                              ),
                            );
                          },
                          child: Container(
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
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
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
                  items: List.generate(
                    imgList.length,
                    (index) => Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.network(imgList[index], fit: BoxFit.cover, width: 1000.0),
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
                                  nomesCategorias[index],
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
                  ),
                ),
                const SizedBox(height: 10.0),
                // Lista de Empresas (FutureBuilder)
                FutureBuilder(
                future: Future.value(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar empresas: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: nomesEnt.length + 1, // Adiciona +1 para o indicador de carregamento
                    itemBuilder: (context, index) {
                      if (index == nomesEnt.length) {
                        // Índice extra para o indicador de carregamento
                        if (isLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return SizedBox.shrink(); // Não exibe indicador se não estiver carregando
                        }
                      } else if (index < nomesEnt.length && nomesEnt[index].getPhoto() != null) {
                        var item = nomesEnt[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaginaEmpresa(empresa: item),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Color(0xFF7E72A6), width: 1),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.network(
                                  item.getPhoto(),
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              title: Text(
                                item.getName(),
                                style: const TextStyle(color: Color(0xFF7E72A6)),
                              ),
                              subtitle: Text(
                                'Nota: ${Random().nextInt(6)}',
                                style: const TextStyle(color: Color(0xFF7E72A6)),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                      },
                      );
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

