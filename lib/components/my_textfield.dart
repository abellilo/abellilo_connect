import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obsureText;
  final TextEditingController controller;

  MyTextField(
      {Key? key,
      required this.hintText,
      required this.obsureText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          
        )
    ),
    );
  }
}
