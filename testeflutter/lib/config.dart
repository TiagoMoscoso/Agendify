import 'dart:io';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:testeflutter/login/login.dart';
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
        "/login": (context)=>
            Login(),
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
            content: valor? const Text("Senha alterada com sucesso!", style: TextStyle(color: Color(0xFF7E72A6))) : const Text("As senhas não se coincidem", style: TextStyle(color: Color(0xFF7E72A6))),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok", style: TextStyle(color: Color(0xFF7E72A6))))
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
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor:const Color(0xFF7E72A6),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.notification_add,
                color: Color(0xFF7E72A6)
              ),
              const SizedBox(width: 15),
              const Text(
                "Deseja receber notificações?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF7E72A6),
                )
              ),
              const SizedBox(width: 10),
              Switch(
                value: isOn,
                activeColor: const Color(0xFF7E72A6),
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
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                child: Row(
                  /*Botão para alterar a senha*/
                  children: [
                    const Icon(
                        Icons.person_2_rounded,
                        color: Color(0xFF7E72A6)
                    ),
                    const SizedBox(width: 7.5),
                    SizedBox(
                        width: 315,
                        child:TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF7E72A6)),
                          ),
                          onPressed: (){
                            showDialog(context: context,
                                builder: (context) =>
                                    StatefulBuilder(
                                      builder: (context, setState){
                                        return AlertDialog(
                                          title: const Text("Troca de senha", style: TextStyle(color: Color(0xFF7E72A6))),
                                          scrollable: true,
                                          content: Column(
                                            children: [
                                              Row(
                                                  children: <Widget>[
                                                    const Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Icon(Icons.person, color: Color(0xFF7E72A6)),
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        controller: textController1,
                                                        cursorColor: const Color(0xFF7E72A6),
                                                        style: const TextStyle(color: Color(0xFF7E72A6)),
                                                        obscureText: !senhaVisivel,
                                                        decoration: const InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: 'Nova senha',
                                                          hintStyle: TextStyle(color: Color(0xFFD9D0C7)),
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  children: <Widget>[
                                                    const Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Icon(Icons.person, color: Color(0xFF7E72A6)),
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        controller: textController2,
                                                        cursorColor: const Color(0xFF7E72A6),
                                                        style: const TextStyle(color: Color(0xFF7E72A6)),
                                                        obscureText: !senhaVisivel,
                                                        decoration: InputDecoration(
                                                            border: InputBorder.none, // Remove the default border
                                                            hintText: 'Confirmação da nova senha',
                                                            hintStyle: const TextStyle(color: Color(0xFFD9D0C7)),
                                                            suffixIconColor: const Color(0xFF7E72A6),
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
                                            TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('Cancelar', style: TextStyle(color: Color(0xFF7E72A6)))),
                                            TextButton(onPressed: (){
                                              String text1 = textController1.text;
                                              String text2 = textController2.text;
                                              if (text1 == text2) {
                                                Navigator.pop(context);
                                              }
                                              verificaSenha(text1 == text2);
                                            }, child: const Text('Ok', style: TextStyle(color: Color(0xFF7E72A6))))
                                          ],
                                        );
                                      },
                                    ));
                          },//LOGOUT
                          child: const Text("Alterar senha", style: TextStyle(fontSize: 20)),
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
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                child: Row(
                  children: [
                    const Icon(
                        Icons.info_rounded,
                        color: Color(0xFF7E72A6),
                    ),
                    const SizedBox(width: 7.5),
                    SizedBox(
                        width: 315,
                        child:TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF7E72A6)),
                          ),
                          onPressed: (){
                            showDialog(context: context, builder: (context)=> AlertDialog(
                              title: const Text("Agendify", style: TextStyle(color: Color(0xFF7E72A6), fontWeight: FontWeight.bold)),
                              content: const Text("Desenvolvido durante a matéria de Laboratório de Desenvolvimento para Dispositivos Móveis, este aplicativo possui o objetivo de simplificar o processo de agendamento de compromissos e de gerenciamento de horários ocupados dos mais diversos serviços.\n\nAutores: Gabriel Luís, Leonardo Pizani, Pedro Caillaux, Rafael Vicente, Tiago Moscoso", style: TextStyle(color: Color(0xFF7E72A6))),
                              actions: [
                                TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('Top!', style: TextStyle(color: Color(0xFF7E72A6))))
                              ],
                            ));
                          },//LOGOUT
                          child: const Text("Sobre o App", style: TextStyle(fontSize: 20)),
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
                        Icons.logout,
                        color: Color(0xFF7E72A6),
                    ),
                    const SizedBox(width: 7.5),
                    SizedBox(
                        width: 315,
                        child:TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF7E72A6)),
                          ),
                          onPressed: (){
                            showDialog(context: context, builder: (context)=> AlertDialog(
                              content: const Text("Deseja realmente sair do aplicativo?", style: TextStyle(color: Color(0xFF7E72A6))),
                              actions: [
                                TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('Cancelar', style: TextStyle(color: Color(0xFF7E72A6)))),
                                TextButton(onPressed: ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (Route<dynamic> route) => false), child: const Text('Ok', style: TextStyle(color: Color(0xFF7E72A6))))
                              ],
                            ));
                          },//LOGOUT
                          child: const Text("Sair", style: TextStyle(fontSize: 20)),
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      backgroundColor: const Color(0xFFD9D0C7),
    );
  }
}