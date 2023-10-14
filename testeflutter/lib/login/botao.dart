import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final Function()? onPressed;

  const Botao ({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: SizedBox(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7E72A6),
            foregroundColor: const Color.fromARGB(255, 184, 175, 175),
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