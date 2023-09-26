import 'package:flutter/material.dart';
import 'package:testeflutter/login/hyperlink.dart';
import 'campo_texto.dart';
import 'botao.dart';
import 'imagem.dart';

class Login extends StatefulWidget {
  const Login ({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color(0xFFD9D0C7),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Imagem(caminhoImagem: "assets/logoApp.png"),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 35.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xFF7E72A6),
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    CampoTexto(
                      controller: controllerEmail,
                      hintText: "E-mail",
                      obscureText: false,
                      prefixIcon: const Icon(Icons.person),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                      CampoTexto(
                        controller: controllerSenha,
                        hintText: "Senha",
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    Hyperlink(
                      texto: 'Esqueceu a senha?',
                      onTap: () => Navigator.pushNamed(context, '/home'),
                      negrito: FontWeight.normal,
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Botao(),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Expanded(
                      child: Divider(
                        color: Color(0xFF7E72A6),
                        thickness: 1,
                        endIndent: 5,
                        indent: 30,
                      ),
                    ),
                    Text(
                      "Ou",
                      style: TextStyle(
                        color: Color(0xFF7E72A6),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFF7E72A6),
                        thickness: 1,
                        indent: 5,
                        endIndent: 30,
                    ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    const Text(
                      "Não possui uma conta?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4,),
                    Hyperlink(
                      texto: 'Registre-se agora.',
                      onTap: () => Navigator.pushNamed(context, '/home'),
                      negrito: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

