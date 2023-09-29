import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../DbHelper/db_helper.dart';
import '../common/comHelper.dart';
import '../common/genText_from_field.dart';
import '../utils/colors.dart';
import 'Register_screen.dart';
import 'catalog_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userId = TextEditingController();
  final _password = TextEditingController();
  DatabaseHelper? databaseHelper;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  login() async {
    setState(() {
      _isLoading = true;
    });

    String uid = _userId.text;
    String password = _password.text;

    if (uid.isEmpty) {
      showSnackBar(context: context, content: "Please Enter UserId");
      setState(() {
        _isLoading = false;
      });
    } else if (password.isEmpty) {
      showSnackBar(context: context, content: "Please Enter Password");
      setState(() {
        _isLoading = false;
      });
    } else {
      await databaseHelper!.getLoginUser(uid, password).then((userData) async {
        if (userData != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const CatalogScreen()),
                  (Route<dynamic> route) => false);
        } else {
          showSnackBar(context: context, content: "Error user not found");
          setState(() {
            _isLoading = false;
          });
        }
      }).catchError((error) async {
        showSnackBar(context: context, content: "Error Login fail");
        setState(() {
          _isLoading = false;
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                ColorFiltered(
                  colorFilter: const
                  ColorFilter.mode(
                    creamColor,
                    BlendMode.modulate,
                  ),
                  child: Image.asset(
                    "assets/login_screen.png",
                    fit: BoxFit.cover,
                    height: 350,
                    width: 700,
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      "WELCOME TO",
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                    ColorizeAnimatedText(
                      "BREED STORE",
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                ),
                GenTextFromField(
                  controller: _userId,
                  icon: Icons.person,
                  hintName: "UserId ",
                ),
                const SizedBox(height: 20),
                GenTextFromField(
                  controller: _password,
                  icon: Icons.lock,
                  hintName: "Password",
                  isObscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.black,

                )
                    : ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    primary: darkBluishColor,
                  ),
                  child: const Text("Login"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Dont have an account?',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(' Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
