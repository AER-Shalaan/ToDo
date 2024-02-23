import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  String label;
  TextInputType? keyboard;
  bool obscure;
  Widget? suffixIcon;
  CustomFormField({super.key,required this.label,this.keyboard,this.obscure = false,this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(label),
        suffixIcon: suffixIcon
      ),
      keyboardType: keyboard,
      style: const TextStyle(color: Colors.black,
        fontSize: 16),
      obscureText: obscure,

    );
  }
}
