import 'package:flutter/material.dart';
import 'package:smp/src/const/style.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final IconData icon;
  final TextInputType keyboardType;
  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.name,
      required this.icon, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: name,
          labelStyle: Style.fourteen,
          hintStyle: Style.fourteen,
          suffixIcon: Icon(icon),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onChanged: (value) => controller.text = value,
      ),
    );
  }
}
