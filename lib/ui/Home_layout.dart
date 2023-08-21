import 'package:aaa/ui/screens/MyHomePage3.dart';
import 'package:aaa/ui/screens/home_screen.dart';
import 'package:aaa/ui/screens/login_screen.dart';
import 'package:aaa/ui/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  void getPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    const ListScreen(),
    const Page2(),
    const Profile(),
  ];

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      appBar: AppBar(
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () async {
            await signOut().then((value) {
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              }
            });
          },
          icon: const Icon(Icons.logout),
        ),
        title: const Text('Task 5'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black54,
        currentIndex: currentIndex,
        onTap: (index) {
          getPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.home_filled,
                  color: Colors.white,
              ),
              label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.add_box_rounded,
                color: Colors.white,
            ),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.person_rounded,
                color: Colors.white,
            ),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
