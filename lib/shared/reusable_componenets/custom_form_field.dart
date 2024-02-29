import 'package:flutter/material.dart';
typedef FieldValidation = String? Function(String?)?;
class CustomFormField extends StatelessWidget {
  String label;
  TextInputType? keyboard;
  bool obscure;
  Widget? suffixIcon;
  FieldValidation validator;
  TextEditingController? controller;
  CustomFormField({super.key,required this.label,this.keyboard,this.obscure = false,this.suffixIcon , this.validator,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      decoration: InputDecoration(label: Text(label), suffixIcon: suffixIcon),
      style: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }
}
