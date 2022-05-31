import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/theme.dart';

class BottomNavbar extends StatefulWidget {
  BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60,
      child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
                backgroundColor: backgroundColor4,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home, color: backgroundColor4, size: 21),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat, color: backgroundColor4, size: 21),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite,
                          color: backgroundColor4, size: 21),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle,
                          color: backgroundColor4, size: 21),
                      label: ""),
                ]),
          )),
    );
  }
}
