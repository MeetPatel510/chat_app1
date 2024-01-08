import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const CustomTextField({super.key, required this.label, required this.controller,this.obscureText = false, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      decoration: const InputDecoration.collapsed(
              hintText: '', border: OutlineInputBorder())
          .copyWith(
            labelText: label,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
    );
  }
}
