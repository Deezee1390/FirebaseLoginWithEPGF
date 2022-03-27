import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login_new/pages/login_screen.dart';
import 'package:flutter_firebase_login_new/pages/successscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = snapshot.data;
            return SuccessScreen(uid: user!.uid);
          } else {
            return LoginScreen();
          }
        });
  }
}
