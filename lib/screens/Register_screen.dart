import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breed_storeee/user_model/user_model.dart';
import 'package:flutter/material.dart';

import '../DbHelper/db_helper.dart';
import '../common/comHelper.dart';
import '../common/genText_from_field.dart';
import '../utils/colors.dart';
import 'login_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) ;



  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  final _userId = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _conformPassword = TextEditingController();
  final _address = TextEditingController();

  var databaseHelper;


  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
  }
  register()async{
    String uid = _userId.text;
    String uname = _username.text;
    String email = _email.text;
    String password = _password.text;
    String cpassword = _conformPassword.text;
    String address = _address.text;


    if (_formKey.currentState!.validate()) {
      if (password != cpassword) {
        showSnackBar(context: context, content: "Password Mismatch");
      } else {
        _formKey.currentState!.save();

        UserModel uModel = UserModel(
            userId: uid,
            username: uname,
            email: email,
            password: password,
            address: address,
        );
        await databaseHelper!.saveData(uModel).then((userData) {
          showSnackBar(context: context, content: "Successfully Registered");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  const LoginScreen()));
        }).catchError((error) {
          print(error);
          showSnackBar(context: context, content: "Error Registering");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      "WELCOME TO",
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                    ColorizeAnimatedText(
                      "Register Screen",
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                GenTextFromField(
                  controller: _userId,
                  icon: Icons.person,
                  inputType: TextInputType.name,
                  hintName: "userId",
                ),
                const SizedBox(height: 20),
                GenTextFromField(
                    controller: _username,
                    icon: Icons.person,
                    hintName: "username"),
                const SizedBox(
                  height: 20,
                ),
                GenTextFromField(
                    controller: _email,
                    icon: Icons.mail,
                    hintName: "email",

                ),
                const SizedBox(
                  height: 20,
                ),

                GenTextFromField(
                  controller: _password,
                  icon: Icons.lock,
                  hintName: "password",
                  isObscureText: true,
                ),
                const SizedBox(height: 20),
                GenTextFromField(
                  controller: _conformPassword,
                  icon: Icons.lock,
                  hintName: "confirmPassword",
                  isObscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                GenTextFromField(
                    controller: _address,
                    icon: Icons.home,
                    hintName: "address"),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: register,
                  child: Container(
                    width: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: darkBluishColor, // Set your desired color here
                    ),
                    child: const Text("Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Already have an account?',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(' Register in',
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
