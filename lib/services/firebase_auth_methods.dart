import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_book/screens/signup.dart';
import 'package:note_book/utility/showOTPDialogBox.dart';
import 'package:note_book/utility/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  // Email Signup Function
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ); // Creating User in Firebase using Email and Password
      await sendEmailVerification(context); // Email Verification
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Email Login Function
  Future<void> loginWithEmail({
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
        await sendEmailVerification(context);
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // PhoneNumber Signup Function
  Future<void> signUpWithPhone({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    TextEditingController controller = TextEditingController();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final isVerified = await _auth.signInWithCredential(credential);

          if (isVerified.user != null &&
              isVerified.additionalUserInfo != null) {
            print('User :${isVerified.user}');
            print('additionalUserInfo :${isVerified.additionalUserInfo}');
            Navigator.push(
                context,
                (MaterialPageRoute(
                    builder: (context) => const SignUpScreen())));
          }
        },
        verificationFailed: (e) {
          showSnackBar(context, e.message!);
        },
        codeSent: (String verificationId, int? resendToken) async {
          showOTPDialog(
              context: context,
              controller: controller,
              onpress: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: controller.text.trim());
                final user =
                    await _auth.signInWithCredential(phoneAuthCredential);

                if (user.user != null && user.additionalUserInfo != null) {
                  print('User :${user.user}');
                  print('additionalUserInfo :${user.additionalUserInfo}');
                  Navigator.push(
                      context,
                      (MaterialPageRoute(
                          builder: (context) => const SignUpScreen())));
                }
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
  Future sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Phone Verification Send!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
