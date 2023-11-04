import 'dart:io';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:testeflutter/Cadastro.dart';
void main() {
  runApp(const MaterialApp(
      home: ConfigScreen()
  ));
}

class ConfigButton extends StatelessWidget {
  const ConfigButton({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Perfil",
      routes:  {
        "/exit": (context)=>
         MyApp(),
        "/cadastro": (context)=>
        CadastroPage(),
      },
      home: ConfigScreen(),
    );
  }
}

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});
  @override
  State<ConfigScreen> createState() => _ConfigScreen();
}

class _ConfigScreen extends State<ConfigScreen> {
  bool isOn = false;
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  bool receberNotificacao = true;
  bool senhaVisivel = false;
  final TextEditingController textController = TextEditingController();
  @override
  void initState() {
    senhaVisivel = false;
  }
  void verificaSenha(bool valor){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: valor? const Text("Senha alterada com sucesso!"): const Text("As senhas não se coincidem"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        }
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações",
          style: TextStyle(
            fontSize: 20.0,
            color: Color(0xff252B48),
          ),
        ),
        centerTitle: true,
        backgroundColor:const Color(0xffc1c0c0),
      ),
      body: Column(
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.notification_add),
                const Text("Deseja receber notificações?", style: TextStyle(fontSize: 20, fontFamily: "Kanit")),
                const SizedBox(height: 20),
                Switch(
                  value: isOn,
                  onChanged: (bool newValue) {
                    setState(() {
                      isOn = newValue;
                    });
                  },
                ),
              ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 0),
                child: Row(
                  /*Botão para alterar a senha*/
                  children: [
                    const Icon(
                        Icons.person_2_rounded
                    ),
                    SizedBox(
                        width: 275,
                        child:TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(const Color(0xff000000)),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffAEC3AE)),
                          ),
                          onPressed: (){
                            showDialog(context: context,
                                builder: (context) =>
                                  StatefulBuilder(
                                    builder: (context, setState){
                                      return AlertDialog(
                                        title: const Text("Troca de senha"),
                                        scrollable: true,
                                        content: Column(
                                          children: [
                                            Row(
                                                children: <Widget>[
                                                  const Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Icon(Icons.person, color: Colors.black),
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller: textController1,
                                                      obscureText: !senhaVisivel,
                                                      decoration: const InputDecoration(
                                                        border: InputBorder.none, // Remove the default border
                                                        hintText: 'Nova senha',
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                            ),
                                            Row(
                                                children: <Widget>[
                                                  const Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Icon(Icons.person, color: Colors.black),
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller: textController2,
                                                      obscureText: !senhaVisivel,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none, // Remove the default border
                                                        hintText: 'Confirmação da nova senha',
                                                        suffixIcon: IconButton(
                                                            onPressed: (){
                                                              setState((){
                                                                senhaVisivel = !senhaVisivel;
                                                              });
                                                            },
                                                            icon: Icon(
                                                              senhaVisivel?Icons.visibility:Icons.visibility_off
                                                            ))
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ],
                                        ),
                                          actions: [
                                            TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('Cancelar')),
                                            TextButton(onPressed: (){
                                              String text1 = textController1.text;
                                              String text2 = textController2.text;
                                              if (text1 == text2) {
                                                Navigator.pop(context);
                                              }
                                              verificaSenha(text1 == text2);
                                            }, child: const Text('Ok'))
                                          ],
                                      );
                                    },
                                ));
                          },//LOGOUT
                          child: const Text("Alterar senha", style: TextStyle(fontSize: 20, fontFamily: "Kanit")),
                        )
                    )
                  ],
                ),
              )
            ],
          ),
          /*BOTÃO SOBRE O APP QUE VAI MOSTRAR UM POP UP DO AGENDIFY*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 0),
                child: Row(
                  children: [
                    const Icon(
                        Icons.info_rounded
                    ),
                    SizedBox(
                        width: 275,
                        child:TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(const Color(0xff000000)),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffAEC3AE)),
                          ),
                          onPressed: (){
                            showDialog(context: context, builder: (context)=> AlertDialog(
                              title: const Text("Agendify"),
                              content: const Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock"),
                              actions: [
                                TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('Top!'))
                              ],
                            ));
                          },//LOGOUT
                          child: const Text("Sobre o App", style: TextStyle(fontSize: 20, fontFamily: "Kanit")),
                        )
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                child: Row(
                  children: [
                    const Icon(
                        Icons.logout
                    ),
                    SizedBox(
                        width: 275,
                        child:TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(const Color(0xff000000)),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffAEC3AE)),
                          ),
                          onPressed: (){
                            showDialog(context: context, builder: (context)=> AlertDialog(
                              //title: const Text(""),
                              content: const Text("Deseja realmente sair do aplicativo?"),
                              actions: [
                                TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('Cancelar')),
                                TextButton(onPressed: ()=> Navigator.pushNamed(context, "/cadastro"), child: const Text('Ok'))
                              ],
                            ));
                          },//LOGOUT
                          child: const Text("Sair", style: TextStyle(fontSize: 20, fontFamily: "Kanit")),
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      backgroundColor: const Color(0xffFAF1E4),
    );
  }
}


