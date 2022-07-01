import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/theme.dart';

Future<dynamic> modalMessage(String status, Color statusColor, String message,
    Color messageColor, BuildContext context) {
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
                status,
                style: plainTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: plainTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                  color: messageColor,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: statusColor, // Background color
                ),
                child: Text(
                  'Close',
                  style: plainTextStyle.copyWith(
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

Future<dynamic> modalMessageNamed(String status, Color statusColor,
    String message, Color messageColor, BuildContext context, String named) {
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
                status,
                style: plainTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: plainTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                  color: messageColor,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: statusColor, // Background color
                ),
                child: Text(
                  'Close',
                  style: plainTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, named),
              )
            ],
          ),
        ),
      );
    },
  );
}
