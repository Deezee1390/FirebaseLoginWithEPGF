import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login_new/controllers/authentication.dart';
import 'package:flutter_firebase_login_new/pages/login_screen.dart';
import 'package:flutter_firebase_login_new/pages/successscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Cant not be empty';
                                }
                              },
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password'),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Cant not be empty';
                                }
                              },
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                          ),
                        ],
                      ))),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () =>
                      signUp(email!, password!).whenComplete(() async {
                        User? user = FirebaseAuth.instance.currentUser;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SuccessScreen(
                              uid: user!.uid,
                            ),
                          ),
                        );
                      }),
                  child: Text('Sign Up')),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  'Login Here',
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
