import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  CustomTextFormFeild({
    super.key,
    required this.hintText,
    this.label,
    this.onChange,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });
  String? hintText;
  String? label;
  bool? obscureText;
  Function(String)? onChange;
  final Icon? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'feild is requierd ';
        }
        return null;
      },
      style: const TextStyle(
        color: Colors.white,
      ),
      onChanged: onChange,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.white,
        suffix: suffixIcon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
