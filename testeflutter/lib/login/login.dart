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
  RegExp formatacaoEmail = RegExp(r"^([\w\.-_]+)@+[\w\.]+((\.+\w{2,3}){1,2})$");
  bool _obscureText = true;

  // void logar() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: controllerEmail,
  //     password: controllerSenha,
  //   );
  // }

  void confirmar() {
    String email = controllerEmail.text;
    String senha = controllerSenha.text;

    if(email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Todos os campos são obrigatórios.',
            textAlign: TextAlign.center,
            selectionColor: Color(0xFFFFFFFF),
          ),
          backgroundColor: Color(0xFF7E72A6),
        )
      );
      return;
    }   

    if(!formatacaoEmail.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Formato Inválido de E-mail.',
            textAlign: TextAlign.center,
            selectionColor: Color(0xFFFFFFFF),
          ),
          backgroundColor: Color(0xFF7E72A6),
        )
      );
      return;
    }

    Navigator.popAndPushNamed(context, "/mainscreen");
  }

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
                      prefixIcon: const Icon(Icons.mail),
                      validator: (controllerEmail) {
                          if(!formatacaoEmail.hasMatch(controllerEmail ?? "")) {
                            return "Formato Inválido de E-mail.";
                          }
                          return null;
                      },
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
                        obscureText: _obscureText,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector (
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Botao(
                      onPressed: () => confirmar(),
                    ),
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
                      onTap: () => Navigator.pushNamed(context, '/cadastro'),
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

