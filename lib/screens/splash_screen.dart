import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_book/global/colors.dart';
import 'package:note_book/screens/signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SpalshTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryMid,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 0),
          Center(
            child: Column(
              children: [
                Lottie.asset('assets/book_anime_icon.json',
                    width: 200, height: 200, fit: BoxFit.cover),
                const Text(
                  'NotebooK',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const Text(
              'By Ajay',
              style: TextStyle(
                  color: primaryDark,
                  fontSize: 20,
                  fontFamily: 'Signature',
                  fontWeight: FontWeight.w900),
            ),
          )
        ],
      )),
    );
  }

  SpalshTime() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpScreen())));
  }
}
