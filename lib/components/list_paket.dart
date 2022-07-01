import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

Widget listPaket(
  String imagePhoto,
  paketName,
  List<String> list,
  int harga,
) =>
    Row(
      children: [
        SizedBox(
          height: 75,
          width: 75,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imagePhoto,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                paketName,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),
              ),
              const SizedBox(width: 16),
              Text(
                "${list[0]},${list[1]},...",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14),
              ),
              Text(
                formatCurrency.format(harga),
                style: blackTextStyle.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
