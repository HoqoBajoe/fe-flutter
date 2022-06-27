import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hoqobajoe/model/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var txtEditEmail = TextEditingController();
    var txtEditPass = TextEditingController();

    Future<void> doLogin(String email, String password) async {
      final response = await http.post(
        Uri.parse('https://hoqobajoe.herokuapp.com/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        await storage.write(
            key: "ID", value: responseJson['data']['id'].toString());
        await storage.write(key: "NAMA", value: responseJson['data']['nama']);
        await storage.write(key: "ROLE", value: responseJson['data']['role']);
        await storage.write(key: "TOKEN", value: responseJson['data']['token']);
        
        Navigator.pushNamed(context, '/start');
        return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Success',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff3ccd71),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Login sukses",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff12313E),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff3ccd71), // Background color
                    ),
                    child: Text(
                      'Close',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          );
        },
      );
      } else {
        return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Gagal',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xfff04f4e),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Email/password salah",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff12313E),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xfff04f4e), // Background color
                    ),
                    child: Text(
                      'Close',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          );
        },
      );
      }
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Image(
                image: AssetImage("assets/images/login_vector.png"),
                width: 200,
              ),
            ),
            Text(
              'Masuk',
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
      );
    }

    Widget emailField() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: txtEditEmail,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Alamat Email',
                          hintStyle: hintTextStyle,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      );
    }

    Widget passwordField() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: txtEditPass,
                        obscureText: true,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Password',
                          hintStyle: hintTextStyle,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      );
    }

    Widget signInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () {
            print('di klik');
            doLogin(txtEditEmail.text, txtEditPass.text);
          },
          style: TextButton.styleFrom(
            backgroundColor: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Masuk',
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(
          bottom: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun? ',
              style: blackTextStyle,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              child: Text(
                'Daftar',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            emailField(),
            passwordField(),
            signInButton(),
            const Spacer(),
            footer(),
          ],
        ),
      )),
    );
  }
}
