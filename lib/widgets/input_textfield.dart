import 'package:flutter/material.dart';
import 'package:note_book/global/colors.dart';

class CustomInputTextField extends StatelessWidget {
  // const CustomInputTextField({Key? key}) : super(key: key);

  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixfixIcon;
  final TextEditingController textController;
  final bool obscure;

  CustomInputTextField({
    required this.hintText,
    required this.prefixIcon,
    required this.suffixfixIcon,
    required this.textController,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: Icon(suffixfixIcon),
        label: Text(
          hintText,
          style: const TextStyle(
            color: primaryDark,
            fontSize: 16,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryDark,
            width: 1,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColor,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        hintText: hintText,
      ),
    );
  }
}
