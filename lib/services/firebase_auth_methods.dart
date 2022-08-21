import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_book/screens/signup.dart';
import 'package:note_book/utility/showOTPDialogBox.dart';
import 'package:note_book/utility/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  // Email Signup Function
  Future<void> SignUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ); // Creating User in Firebase
      await SendEmailVerification(context); // Email Verification
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Email Login Function
  Future<void> LoginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); // Creating User in Firebase
      if (!_auth.currentUser!.emailVerified) {
        await SendEmailVerification(context);
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // PhoneNumber Signup Function
  Future<void> SignUpWithPhone({
    required String phoneNumber,
    required BuildContext context,
    // required String password,
  }) async {
    TextEditingController controller = TextEditingController();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final is_verified = await _auth.signInWithCredential(credential);

          Navigator.push(context,
              (MaterialPageRoute(builder: (context) => SignUpScreen())));
        },
        verificationFailed: (e) {
          showSnackBar(context, e.message!);
        },
        codeSent: (String VerificationId, int? resendToken) async {
          showOTPDialog(
              context: context,
              controller: controller,
              onpress: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: VerificationId,
                        smsCode: controller.text.trim());
                await _auth.signInWithCredential(phoneAuthCredential);
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 30),
      );
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //Google Signup Function
  Future<void> SignUpWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {}
        }
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Email Verification
  Future SendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Phone Verification Send!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
