import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  final Widget? label;
  final String? hintText;
  final Widget? suffixIcon;
  final IconData? iconData;
  final bool? obscureText;
  final InputBorder? border;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  CustomInputText(
      {Key? key,
      this.label,
      this.hintText,
      this.suffixIcon,
      this.obscureText = false,
      this.iconData,
      this.controller,
      this.border,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        
        label: label,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon:  Icon(
          iconData,
          color: Colors.brown,
        ),
        border: border ?? const OutlineInputBorder(),
      ),
      obscureText: obscureText!,
      controller: controller,
    );
  }
}
