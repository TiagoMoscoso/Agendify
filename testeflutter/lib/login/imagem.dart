import "package:flutter/material.dart";

class Imagem extends StatelessWidget {
  final String caminhoImagem;
  const Imagem ({
    super.key,
    required this.caminhoImagem,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        caminhoImagem,
        height: 120,
      ),
    );
  }
}