import 'package:flutter/material.dart';
import 'package:hoqobajoe/theme.dart';

class NeedLogin extends StatelessWidget {
  const NeedLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Harus login terlebih dahulu',
          style: blackTextStyle,
        ),
      ),
    );
  }
}
