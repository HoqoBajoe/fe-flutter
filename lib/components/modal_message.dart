import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: messageColor,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: statusColor, // Background color
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
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: messageColor,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: statusColor, // Background color
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.poppins(
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
