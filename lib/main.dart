import 'package:breed_storeee/screens/Register_screen.dart';
import 'package:breed_storeee/screens/catalog_screen.dart';
import 'package:breed_storeee/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()

    );
  }
}

 