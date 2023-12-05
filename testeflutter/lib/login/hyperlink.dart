import 'package:flutter/material.dart';

class Hyperlink extends StatelessWidget {
  final String? texto;
  final FontWeight? negrito;
  final Function()? onTap;

  const Hyperlink ({
    super.key,
    required this.texto,
    required this.onTap,
    required this.negrito,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        texto!,
        style: TextStyle(
          color: const Color(0xFF7E72A6),
          fontWeight: negrito,
        ),
      ),
    );
  }
}