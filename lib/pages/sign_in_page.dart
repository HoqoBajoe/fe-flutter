import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: const [
              Text('Sign in'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Liburan seru menantimu bersama HoqoBajoe',
              )
            ],
          ),
        ),
      );
    }

    Widget emailField() {
      return Container(
        margin: const EdgeInsets.only(top: 70),
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
            backgroundColor: Colors.blue[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Sign In'),
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
            const Text('Belum punya akun? '),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/sign_up');
                },
                child: const Text(
                  'Daftar',
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
