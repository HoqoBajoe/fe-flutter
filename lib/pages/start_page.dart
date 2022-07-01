import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hoqobajoe/pages/about_us.dart';
import 'package:hoqobajoe/pages/edit_profile_page.dart';
import 'package:hoqobajoe/pages/history_page.dart';
import 'package:hoqobajoe/pages/home_page.dart';
import 'package:hoqobajoe/pages/need_login.dart';
import 'package:hoqobajoe/pages/sign_in_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _currentIndex = 0;

  Future<void> checkIfLoggedIn() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: "TOKEN");
    if (token != null) {
      setState(() {
        screen[1] = HistoryPage();
        screen[3] = EditProfilePage();
      });
    }
  }

  @override
  void initState() {
    checkIfLoggedIn();
    super.initState();
  }

  final screen = [
    HomePage(),
    const NeedLogin(),
    const AboutUsPage(),
    const SignInPage(),
  ];

  @override
  Widget build(BuildContext context) {
    void _onTap(int index) {
      _currentIndex = index;
      setState(() {});
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        onTap: _onTap,
        elevation: 15,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'About Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
