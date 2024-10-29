import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  void Function(String)? onFieldSubmitted;

  MyTextField(
      {super.key,
      required this.hint,
      this.suffixIcon,
      this.controller,
      this.validator,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        style: const TextStyle(color: Colors.white),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            suffixIcon: suffixIcon),
      ),
    );
  }
}