import 'package:flutter/material.dart';
import 'package:hoqobajoe/theme.dart';

Widget headerOnAuth(String headerText, String img) {
  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            img,
            width: 200,
          ),
        ),
        Text(
          headerText,
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
