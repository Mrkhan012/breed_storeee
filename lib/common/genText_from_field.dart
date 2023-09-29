import 'package:breed_storeee/common/comHelper.dart';
import 'package:flutter/material.dart';

class GenTextFromField extends StatelessWidget {
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;

  GenTextFromField({
    Key? key,
    required this.controller,
    required this.hintName,
    required this.icon,
    this.isObscureText = false,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: inputType,
        validator: ((value) {
          if (value == null || value.isEmpty) {
            return "Please enter $hintName";
          }
          if (hintName == "email" && !validateEmail(value)) {
            return "Please enter a valid email address";
          }
          return null;
        }),
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),

        ),
      ),
    );
  }
}


