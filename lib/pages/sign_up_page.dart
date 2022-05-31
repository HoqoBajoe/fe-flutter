import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: const [
              Text('Sign Up'),
            ],
          ),
        ),
      );
    }

    Widget nameField() {
      return Container(
        margin: const EdgeInsets.only(top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama',
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_circle),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Nama Anda',
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
            const Text(
              'Email Address',
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.mail),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Alamat Email',
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
            const Text(
              'Password',
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      );
    }

    Widget signUpButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Sign Up'),
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
            const Text('Sudah punya akun? '),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/detail_page');
                },
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      );
    }

    return Scaffold(
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
            signUpButton(),
            const Spacer(),
            footer(),
          ],
        ),
      )),
    );
  }
}
