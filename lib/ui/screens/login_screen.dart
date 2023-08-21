import 'package:aaa/ui/Home_layout.dart';
import 'package:aaa/ui/screens/form_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login(
    String email,
    String password,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          if (value.user != null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomeLayout();
            }));
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email'),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.black12),
                child: TextFormField(
                  controller: emailC,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid. Email must be not empty.';
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Password'),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.black12),
                child: TextFormField(
                  controller: passwordC,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid. Password must be not empty.';
                    } else if (value.length < 6) {
                      return 'Invalid. Password must be 6 numbers.';
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await login(
                        emailC.text,
                        passwordC.text,
                      );
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'OR',
                          style: TextStyle(fontSize: 20),),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const CreateAcc();
                      }));
                    },
                    child: const Text('Create Account'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
