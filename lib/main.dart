import 'package:flutter/material.dart';
import 'package:hoqobajoe/pages/Location.dart';
import 'package:hoqobajoe/pages/add_review.dart';
// import 'package:hoqobajoe/components/bottom_navbar.dart';
import 'package:hoqobajoe/pages/detail_page.dart';
import 'package:hoqobajoe/pages/home_page.dart';
import 'package:hoqobajoe/pages/search_page.dart';
import 'package:hoqobajoe/pages/sign_in_page.dart';
import 'package:hoqobajoe/pages/sign_up_page.dart';
import 'package:hoqobajoe/pages/splash_page.dart';
import 'package:hoqobajoe/pages/start_page.dart';
import 'package:hoqobajoe/pages/transaction_page.dart';
import 'pages/edit_profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HoqoBajoe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/start': (context) => const StartPage(),
        '/sign_in': (context) => const SignInPage(),
        '/sign_up': (context) => const SignUpPage(),
        '/homepage': (context) => const HomePage(),
        '/detail_page': (context) => const DetailPage(),
        '/search': (context) => const SearchPage(),
        '/edit_profile_page': (context) => const EditProfilePage(),
        '/location': (context) => const Location(),
        '/transaction': (context) => TransactionPage(),
        '/add_review': (context) => AddReview()
      },
    );
  }
}
