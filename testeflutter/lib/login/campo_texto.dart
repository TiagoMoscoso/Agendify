import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget prefixIcon;

  const CampoTexto ({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: TextFormField(
          cursorColor: const Color(0xFF7E72A6),
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Color(0xFF7E72A6) ),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            prefixIconColor: const Color(0xFF7E72A6),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7E72A6),
                width: 1.5,
              ),
            ),
            hintText: hintText, 
            hintStyle: const TextStyle(color: Color(0xFFD9D0C7)),
            fillColor: Colors.white,
            filled: true,

          ),
          controller: controller,
          obscureText: obscureText,
        ),
      ),
    );
  }
}