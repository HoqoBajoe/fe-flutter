import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hoqobajoe/components/header_on_auth.dart';
import 'package:hoqobajoe/components/modal_message.dart';
import 'package:http/http.dart' as http;
import 'package:hoqobajoe/theme.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txtEditNama = TextEditingController();
    var txtEditEmail = TextEditingController();
    var txtEditPass = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    Future<void> registerUser(
      String nama,
      String email,
      String password,
    ) async {
      final response = await http.post(
        Uri.parse('https://hoqobajoe.herokuapp.com/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nama': nama,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        modalMessageNamed(
          'Success',
          successColor,
          'Registrasi akun berhasil, silahkan login!',
          messageColor,
          context,
          '/start',
        );
      } else if (response.statusCode == 422) {
        modalMessage(
          'Error',
          gagalColor,
          'Email yang sama sudah digunakan.',
          messageColor,
          context,
        );
      } else {
        modalMessage(
          'Gagal',
          gagalColor,
          'Registrasi akun gagal..',
          messageColor,
          context,
        );
      }
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                        controller: txtEditNama,
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
              registerUser(
                txtEditNama.text,
                txtEditEmail.text,
                txtEditPass.text,
              );
            }
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerOnAuth("Daftar", "assets/images/logo_hoqobajoe.png"),
              nameField(),
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
