import 'package:breed_storeee/screens/login_screen.dart';
import 'package:breed_storeee/utils/colors.dart';
import 'package:flutter/material.dart';

void showLogoutAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Logout?",
        ),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text("Confirm",
              style: TextStyle(color: Colors.blueAccent),),
          ),
        ],
      );
    },
  );
}
