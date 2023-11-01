// cadastro.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testeflutter/Classes/ClassUser.dart';
import 'package:testeflutter/DB/DbTableUser.dart';
import 'package:testeflutter/login/campo_texto.dart';
import 'package:testeflutter/login/botao.dart';
import 'package:testeflutter/perfil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; 

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
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmarSenhaController = TextEditingController();
  RegExp formatacaoEmail = RegExp(r"^([\w\.-_]+)@+[\w\.]+((\.+\w{2,3}){1,2})$");

  final List<TextInputFormatter> _telefoneInputFormatters = [
    LengthLimitingTextInputFormatter(15),
    FilteringTextInputFormatter.digitsOnly,
    MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    )
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Todos os campos são obrigatórios.',
            textAlign: TextAlign.center,
            selectionColor: Colors.white,
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

    if (senha != confirmarSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'As senhas não coincidem.',
            textAlign: TextAlign.center,
            selectionColor: Color(0xFFFFFFFF),
          ),
          backgroundColor: Color(0xFF7E72A6),
        )
      );
      return;
    }

    // Remove caracteres não numéricos do telefone
    // String telefoneNumerico = telefone.replaceAll(RegExp(r'[^\d]+'), '');

    if (telefone.length != 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'O número de telefone deve ter 11 dígitos',
            textAlign: TextAlign.center,
            selectionColor: Color(0xFFFFFFFF),
          ),
          backgroundColor: Color(0xFF7E72A6),
        )
      );
      return;
    }

    // Formata o telefone com parênteses nos dois primeiros dígitos
    // String ddd = telefoneNumerico.substring(0, 2);
    // String numero = telefoneNumerico.substring(2);
    // String telefoneFormatado =
    //     '($ddd) $numero'; // Adicione o espaço entre os parênteses e o número

    Cadastro cadastro = Cadastro(
      nome: nome,
      telefone: telefone,
      email: email,
      senha: senha,
    );

    // Após o cadastro bem-sucedido, navegue para a tela SecondScreen
    ClassUser user = ClassUser();
    user.setName(cadastro.nome);
    user.setEmail(cadastro.email);
    user.setTelephone(cadastro.telefone);
    user.setIdUser(await DbTableUser.addUsertoTables(user));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileOriginal(user: user)),
    );
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
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Text(
                      "Cadastro",
                      style: TextStyle(
                        color: Color(0xFF7E72A6),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.assignment, color: Color(0xFF7E72A6), size: 36)
                  ],
                ),
                const SizedBox(height: 20.0),
                CampoTexto(
                  inputFormatters: [],
                  keyboardType: TextInputType.name,
                  obscureText: false, 
                  controller: _nomeController, 
                  hintText: 'Nome', 
                  prefixIcon: const Icon(Icons.person_rounded),
                ),
                const SizedBox(height: 15.0),
                CampoTexto(
                  inputFormatters: _telefoneInputFormatters,
                  keyboardType: TextInputType.phone,
                  obscureText: false, 
                  controller: _telefoneController, 
                  hintText: 'Telefone', 
                  prefixIcon: const Icon(Icons.phone_rounded),
                ),
                const SizedBox(height: 15.0),
                CampoTexto(
                  inputFormatters: [],
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false, 
                  controller: _emailController, 
                  hintText: 'E-mail', 
                  prefixIcon: const Icon(Icons.mail_rounded),
                ),
                const SizedBox(height: 15.0),
                CampoTexto(
                  inputFormatters: [],
                  keyboardType: TextInputType.text,
                  obscureText: true, 
                  controller: _senhaController, 
                  hintText: 'Senha', 
                  prefixIcon: const Icon(Icons.lock_rounded),
                ),
                const SizedBox(height: 15.0),
                CampoTexto(
                  inputFormatters: [],
                  keyboardType: TextInputType.text,
                  obscureText: true, 
                  controller: _confirmarSenhaController, 
                  hintText: 'Confirmação de Senha', 
                  prefixIcon: const Icon(Icons.lock),
                ),
                const SizedBox(height: 20.0),
                Botao(
                  text: 'Confirmar',
                  onPressed: _onConfirmarPressed,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}