import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*void main() {
  runApp(const MaterialApp(
      home: ConfigScreen()
  ));
}*/


class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});
  @override
  State<ConfigScreen> createState() => _ConfigScreen();
}

class _ConfigScreen extends State<ConfigScreen> {
  bool receberNotificacao = true;
  @override
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
                SizedBox(
                  width: 50,
                  child: FloatingActionButton(
                    onPressed: (){
                      setState(() {
                        receberNotificacao = !receberNotificacao;
                      });
                    },
                    backgroundColor: receberNotificacao?const Color(0xff008000):const Color(0xffFF0000),

                  ),
                )
              ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 0),
                child: Row(
                  children: [
                    const Icon(
                        Icons.logout
                    ),
                    SizedBox(
                        width: 250,
                        child:TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(const Color(0xff000000)),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffAEC3AE)),
                          ),
                          onPressed: (){
                            exit(0);
                          },//LOGOUT
                          child: const Text("Sair", style: TextStyle(fontSize: 20, fontFamily: "Kanit")),
                        )
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
      backgroundColor: const Color(0xffFAF1E4),
    );
  }
}


