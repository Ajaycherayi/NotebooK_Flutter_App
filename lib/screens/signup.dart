import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_book/screens/signup_phone.dart';
import 'package:note_book/services/firebase_auth_methods.dart';
import 'package:note_book/screens/login.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void SignUpUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).SignUpWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
        context: this.context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: SignUpUser,
                icon: const Icon(Icons.arrow_circle_right_outlined),
                iconSize: 30,
                color: Colors.deepPurpleAccent,
              ),
              IconButton(
                onPressed: () => Navigator.push(context,
                    (MaterialPageRoute(builder: (context) => LoginScreen()))),
                icon: const Icon(Icons.arrow_circle_left_outlined),
                iconSize: 30,
                color: Colors.deepPurpleAccent,
              ),
              IconButton(
                onPressed: () => Navigator.push(
                    context,
                    (MaterialPageRoute(
                        builder: (context) => SignUpWithPhoneScreen()))),
                icon: const Icon(Icons.phone_iphone_sharp),
                iconSize: 30,
                color: Colors.deepPurpleAccent,
              ),
              IconButton(
                onPressed: () => FirebaseAuthMethods(FirebaseAuth.instance)
                    .SignUpWithGoogle(context),
                icon: const Icon(Icons.graphic_eq_outlined),
                iconSize: 30,
                color: Colors.deepPurpleAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
