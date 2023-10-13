import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  const Botao ({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/home');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7E72A6),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 20,
            )
          ),
          child: const Text("Entrar"),
          ),
      ),
    );
  }
}