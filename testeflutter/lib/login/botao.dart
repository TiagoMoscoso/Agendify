import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const Botao ({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF7E72A6),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 20,
        ),
      ),
      child: Text(text),
      );
  }
}