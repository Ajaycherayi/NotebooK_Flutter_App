import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_book/firebase_options.dart';
import 'package:note_book/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // All good to Run
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform); // Get platform (IOS,Android,etc..)
  runApp(const NoteBook());
}

class NoteBook extends StatelessWidget {
  const NoteBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
