import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  CustomInput({Key? key, this.hintText, this.controller, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                12,
              ),
            ),
            borderSide: BorderSide(
              color: Color.fromARGB(
                255,
                240,
                195,
                178,
              ),
            )),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                12,
              ),
            ),
            borderSide: BorderSide(
              color: Color.fromARGB(
                255,
                240,
                195,
                178,
              ),
            )),
      ),
      obscureText: false,
      controller: controller,
    );
  }
}
