import 'package:flutter/material.dart';
import 'package:flutter_firebase_login_new/controllers/authentication.dart';
import 'package:flutter_firebase_login_new/pages/login_screen.dart';

class SuccessScreen extends StatefulWidget {
  final String uid;
  const SuccessScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState(uid);
}

class _SuccessScreenState extends State<SuccessScreen> {
  final String uid;
  _SuccessScreenState(this.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => signOutUser().whenComplete(
                    () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ),
                  ),
              icon: const Icon(Icons.exit_to_app))
        ],
        title: const Text('Main Page'),
      ),
      body: const Center(
        child: Text(
          'Logged In Successfully',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
