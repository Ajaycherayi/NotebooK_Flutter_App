import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_book/global/colors.dart';
import 'package:note_book/screens/signup_phone.dart';
import 'package:note_book/services/firebase_auth_methods.dart';
import 'package:note_book/screens/login.dart';

import '../widgets/input_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signUpUser() async {
    final numberOrMail = _emailController.text.trim();
    final password = _passwordController.text;

    if (int.tryParse(numberOrMail) != null) {
      FirebaseAuthMethods(FirebaseAuth.instance)
          .signUpWithPhone(phoneNumber: '+91$numberOrMail', context: context);
    } else {
      FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
          email: numberOrMail, password: password, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/signup_anime.json',
                fit: BoxFit.cover,
              ),
              const Text('SignUp with NotebooK',
                  style: TextStyle(
                      color: primaryDark,
                      fontFamily: 'PrimaryFont',
                      fontWeight: FontWeight.w900,
                      fontSize: 40)),
              const SizedBox(height: 60),
              CustomInputTextField(
                hintText: "Email",
                obscure: false,
                suffixfixIcon: Icons.clear_rounded,
                prefixIcon: Icons.email_outlined,
                textController: _emailController,
              ),
              const SizedBox(height: 20),
              CustomInputTextField(
                hintText: "Password",
                obscure: true,
                suffixfixIcon: Icons.clear_rounded,
                prefixIcon: Icons.password_outlined,
                textController: _passwordController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUpUser,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(500, 50),
                ),
                child: const Text('SignUp',
                    style: TextStyle(
                        color: primaryLite,
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.w900,
                        fontSize: 20)),
              ),
              const SizedBox(height: 20),
              const Text('OR',
                  style: TextStyle(
                      color: primaryDark,
                      fontFamily: 'PrimaryFont',
                      fontWeight: FontWeight.w900,
                      fontSize: 25)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (() => Navigator.push(
                          context,
                          (MaterialPageRoute(
                            builder: (context) => const SignUpWithPhoneScreen(),
                          )),
                        )),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      shadowColor: Colors.black,
                      elevation: 4,
                    ),
                    child: const Icon(
                      Icons.phone_android_outlined,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (() => FirebaseAuthMethods(FirebaseAuth.instance)
                        .SignUpWithGoogle(context)),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      shadowColor: Colors.black,
                      elevation: 4,
                    ),
                    child: const Icon(
                      Icons.g_mobiledata_outlined,
                    ),
                  ),
                ],
              ),
              // IconButton(
              //   onPressed: () => Navigator.push(
              //       context,
              //       (MaterialPageRoute(
              //           builder: (context) => const LoginScreen()))),
              //   icon: const Icon(Icons.arrow_circle_left_outlined),
              //   iconSize: 30,
              //   color: Colors.deepPurpleAccent,
              // ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account ?',
                      style: TextStyle(
                          color: primaryDark,
                          fontFamily: 'PrimaryFont',
                          fontWeight: FontWeight.w900,
                          fontSize: 20)),
                  GestureDetector(
                    onTap: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()))),
                    child: const Text(' Login',
                        style: TextStyle(
                            color: linkColor,
                            fontFamily: 'PrimaryFont',
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
