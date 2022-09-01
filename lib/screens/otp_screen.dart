import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:note_book/widgets/input_textfield.dart';

class MyWidget extends StatelessWidget {
  MyWidget({Key? key}) : super(key: key);

  var otp_contoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomInputTextField(
                hintText: '*** ***',
                prefixIcon: null,
                suffixfixIcon: null,
                textController: otp_contoller,
                obscure: false),
            ElevatedButton(onPressed: ()=>{
              void verifyOtp(){
                
              }
            }, child: child)
          ],
        ),
      ),
    );
  }

  
}

