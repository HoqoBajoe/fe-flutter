import 'package:flutter/material.dart';
import 'package:hoqobajoe/theme.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 4;

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Image(
                image: AssetImage("assets/images/logo_hoqobajoe.png"),
                width: 200,
              ),
            ),
            Text(
              'Daftar',
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

    Widget nameField() {
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
                      Icons.people_alt_rounded,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Nama',
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
            Navigator.pushNamed(context, '/homepage');
          },
          style: TextButton.styleFrom(
            backgroundColor: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Daftar',
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
              'Sudah punya akun? ',
              style: blackTextStyle,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/start');
                },
                child: Text(
                  'Masuk',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )),
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
            nameField(),
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
