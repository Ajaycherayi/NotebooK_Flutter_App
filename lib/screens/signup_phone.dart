import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_book/services/firebase_auth_methods.dart';

class SignUpWithPhoneScreen extends StatefulWidget {
  SignUpWithPhoneScreen({Key? key}) : super(key: key);

  @override
  State<SignUpWithPhoneScreen> createState() => _SignUpWithPhoneScreenState();
}

class _SignUpWithPhoneScreenState extends State<SignUpWithPhoneScreen> {
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                ),
              ),
              IconButton(
                  onPressed: PhoneSignUp,
                  icon: const Icon(Icons.account_circle_outlined))
            ],
          ),
        ),
      ),
    );
  }

  void PhoneSignUp() {
    FirebaseAuthMethods(FirebaseAuth.instance).SignUpWithPhone(
        phoneNumber: '+91${_phoneController.text.trim()}', context: context);
  }
}
