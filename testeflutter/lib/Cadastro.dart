// cadastro.dart

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import 'package:testeflutter/DB/DbTableUser.dart';
import 'package:testeflutter/Firebase/Db/UserTableFB.dart';
import 'package:testeflutter/profile.dart';
import '/Firebase/Db/UserTableFB.dart';
// Importe a classe SecondScreen

class Cadastro {
  final String nome;
  final String telefone;
  final String email;
  final String senha;

  Cadastro({
    required this.nome,
    required this.telefone,
    required this.email,
    required this.senha,
  });
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  final List<TextInputFormatter> _telefoneInputFormatters = [
    LengthLimitingTextInputFormatter(11),
    FilteringTextInputFormatter.digitsOnly,
  ];

  Future<void> _onConfirmarPressed() async {
    String nome = _nomeController.text;
    String telefone = _telefoneController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;
    String confirmarSenha = _confirmarSenhaController.text;

    if (nome.isEmpty ||
        telefone.isEmpty ||
        email.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Todos os campos são obrigatórios.'),
      ));
      return;
    }

    if (senha != confirmarSenha) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('As senhas não coincidem.'),
      ));
      return;
    }

    if(await UserTableFB.EmailRegistred(email))
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email ja cadastrado.'),
      ));
      return;
    }
    // Remove caracteres não numéricos do telefone
    String telefoneNumerico = telefone.replaceAll(RegExp(r'[^\d]+'), '');

    if (telefoneNumerico.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('O número de telefone deve ter 11 dígitos.'),
      ));
      return;
    }

    // Formata o telefone com parênteses nos dois primeiros dígitos
    String ddd = telefoneNumerico.substring(0, 2);
    String numero = telefoneNumerico.substring(2);
    String telefoneFormatado =
        '($ddd) $numero'; // Adicione o espaço entre os parênteses e o número

    Cadastro cadastro = Cadastro(
      nome: nome,
      telefone: telefoneFormatado,
      email: email,
      senha: senha,
    );

    // Após o cadastro bem-sucedido, navegue para a tela SecondScreen
    ClassUser user = ClassUser();
    user.setName(cadastro.nome);
    user.setEmail(cadastro.email);
    user.setTelephone(cadastro.telefone);
    user.setIdUser(await UserTableFB.InsertInDatabase(user, cadastro.senha));
    DbTableUser.addUsertoTables(user);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile(User: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF1E4),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome:'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone:'),
              keyboardType: TextInputType.number,
              inputFormatters: _telefoneInputFormatters,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email:'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha:'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmarSenhaController,
              decoration: const InputDecoration(labelText: 'Confirmação de Senha:'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onConfirmarPressed,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
