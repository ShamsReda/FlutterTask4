import 'package:aaa/ui/Home_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({super.key});

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController nameC = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          if (value.user != null) {
            saveUserData(
              email: email,
              password: password,
              name: name,
              uid: value.user!.uid,
            ).then((value) {
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const HomeLayout();
                }));
              }
            });
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  Future<bool> saveUserData({
    required String email,
    required String password,
    required String name,
    required String uid,
  }) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'name': name,
        'uid': uid,
      }, SetOptions(merge: true));
      return true;
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      return false;
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      controller: emailC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid. Email must not be empty.';
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Name'),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      controller: nameC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid. Name must not be empty.';
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Password'),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      controller: passwordC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid. Password must not be empty.';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 numbers.';
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await signup(
                      email: emailC.text,
                      password: passwordC.text,
                      name: nameC.text,
                    );
                  },
                  child: const Text('Sign up'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
