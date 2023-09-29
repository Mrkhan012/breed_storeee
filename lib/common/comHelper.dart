import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

validateEmail(String email) {
  String pattern =
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}
