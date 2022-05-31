import 'package:flutter/material.dart';
import 'package:hoqobajoe/pages/about_us.dart';
import 'package:hoqobajoe/pages/history_page.dart';
import 'package:hoqobajoe/pages/home_page.dart';
import 'package:hoqobajoe/pages/my_profile.dart';
import 'package:hoqobajoe/pages/search_page.dart';
import 'package:hoqobajoe/theme.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _currentIndex = 0;

  final screen = const [
    HomePage(),
    SearchPage(),
    HistoryPage(),
    AboutUsPage(),
    MyProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    void _onTap(int index) {
      _currentIndex = index;
      setState(() {});
    }

    return Scaffold(
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
            icon: Icon(Icons.search),
            label: 'Search',
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

  // return Container(
  //   color: Colors.white60,
  //   child: ClipRRect(
  //       borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  //       child: BottomAppBar(
  //         shape: const CircularNotchedRectangle(),
  //         notchMargin: 10,
  //         clipBehavior: Clip.antiAlias,
  //         child: BottomNavigationBar(
  //             backgroundColor: backgroundColor4,
  //             items: <BottomNavigationBarItem>[
  //               BottomNavigationBarItem(
  //                   icon: Icon(
  //                     Icons.home,
  //                     color: backgroundColor4,
  //                     size: 21,
  //                   ),
  //                   label: ""),
  //               BottomNavigationBarItem(
  //                   icon: Icon(
  //                     Icons.chat,
  //                     color: backgroundColor4,
  //                     size: 21,
  //                   ),
  //                   label: ""),
  //               BottomNavigationBarItem(
  //                   icon: Icon(
  //                     Icons.question_mark,
  //                     color: backgroundColor4,
  //                     size: 21,
  //                   ),
  //                   label: ""),
  //               BottomNavigationBarItem(
  //                   icon: Icon(
  //                     Icons.account_circle,
  //                     color: backgroundColor4,
  //                     size: 21,
  //                   ),
  //                   label: ""),
  //             ]),
  //       )),
  // );
}
