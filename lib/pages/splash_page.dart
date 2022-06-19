import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // _startApp();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushNamed(context, '/start'),
    );
    super.initState();
  }

  // Future<void> _startApp() async {
  //   final storage = FlutterSecureStorage();
  //   var token = await storage.read(key: "TOKEN");
  //   if (token == null) {
  //     print(token);
  //   } else {
  //     print('error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo_hoqobajoe.png'),
          ),
        ),
      ),
    ));
  }
}
