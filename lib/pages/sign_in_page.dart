import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hoqobajoe/components/header_on_auth.dart';
import 'package:hoqobajoe/components/modal_message.dart';
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
    final _formKey = GlobalKey<FormState>();

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
        modalMessage("Success!", const Color(0xff3ccd71), "Login sukses",
            const Color(0xff12313E), context);
      } else {
        modalMessage("Gagal", const Color(0xfff04f4e), "Email/password salah",
            const Color(0xff12313E), context);
      }
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          if (EmailValidator.validate(value.toString()) ==
                              false) {
                            return 'Email tidak sesuai format';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
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
            if (_formKey.currentState!.validate()) {
              doLogin(txtEditEmail.text, txtEditPass.text);
            }
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerOnAuth("Masuk", "assets/images/login_vector.png"),
              emailField(),
              passwordField(),
              signInButton(),
              const Spacer(),
              footer(),
            ],
          ),
        ),
      )),
    );
  }
}
