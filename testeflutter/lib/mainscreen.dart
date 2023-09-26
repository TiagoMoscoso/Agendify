
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Menu Principal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    ),
  );
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<String> nomes = [
  'Salão de Casamento',
  'Escritório de Reunião',
  'Resort na Praia',
  'Kartódromo',
  'Zé da Djamba',
  'Passeio no Rio',
];

final List<String> nomesCategorias = [
  'Salão de Beleza',
  'Clínica Médica',
  'Restaurante',
  'Academia',
  'Salão de Massagem',
  'Oficina Mecânica',
];

final List<Widget> Top10 = imgList
    //lista widget do top 10
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 10), // margem do container
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0), // borda circular
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5, 
                        blurRadius: 7,
                        offset: Offset(0, 3),
                        //configuracoes da sombra
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0), // borda circular
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 90.0,
                      height: 90.0,
                      // configurações da imagem
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  //posição resetada

                  child: Container(
                    //container do texto
                    child: Text(
                      nomes[imgList.indexOf(item)],
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        //configuração do texto
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
    .toList();

final List<Widget> Categorias = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          nomesCategorias[imgList.indexOf(item)],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key});
  
  @override
  Widget build(BuildContext context) {
return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,//remover barra vertical
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //texto de boas vindas
              "Bem vinde de volta Fulane ", 
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Text(
              //texto do carrossel de Top 10 serviços do dia
              "Em alta 🔥",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            Container(
              //carrossel de Top 10 serviços do dia
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2.0,
                  height: 150,
                  enlargeCenterPage: false,
                  viewportFraction: 0.2,
                ),
                items: Top10,
              ),
            ),
            Text(
              //texto de categorias em alta
              "Categorias 📒",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            Container(
              //carrousel de categorias em alta
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2.0,
                  height: 150,
                  enlargeCenterPage: false,
                  viewportFraction: 0.7,
                ),
                items: Categorias,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),//impede rolagem da lista interna
              scrollDirection: Axis.vertical, //remover barra vertical
              itemCount: nomes.length,
              //for da lista de serviços
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(imgList[index], fit: BoxFit.cover, width: 50, height: 50,) //imagem do serviço,
                    ),
                    title: Text(nomes[index]), //nome do serviço
                    subtitle: Text('Nota: ${Random().nextInt(6)}'), //nota do serviço
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
