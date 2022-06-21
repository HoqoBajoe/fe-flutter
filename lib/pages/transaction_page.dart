import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:hoqobajoe/model/paket.dart';
import 'package:hoqobajoe/theme.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String? metodeValue;
  String? namaUser;
  int? totalValue;

  Future<void> getStorage() async {
    var storage = const FlutterSecureStorage();
    var nama = await storage.read(key: "NAMA");
    setState(() {
      namaUser = nama.toString();
    });
  }

  @override
  void initState() {
    getStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Paket paket = ModalRoute.of(context)!.settings.arguments as Paket;
    int? tempTotalVal = totalValue;
    setState(() {
      tempTotalVal = paket.harga;
    });

    AppBar buildAppBar() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Transaction",
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () => {
              Navigator.pop(context),
            },
          ),
        ),
      );
    }

    Row headerSummary() {
      return Row(
        children: [
          const Icon(
            Icons.airplane_ticket,
          ),
          const SizedBox(width: 10),
          Text(
            "Details",
            style: blackTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w400),
          )
        ],
      );
    }

    DropdownButton<String> dropdownMetode() {
      return DropdownButton<String>(
        hint: const Text('Pilih Metode'),
        value: metodeValue,
        elevation: 16,
        style: blackTextStyle,
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        onChanged: (String? changedValue) {
          metodeValue = changedValue;
          setState(() {
            metodeValue;
            print(metodeValue);
          });
        },
        items: <String>[
          'Virtual Account BNI',
          'Virtual Account BRI',
          'DANA',
          'GoPay'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    }

    SizedBox dataTransaction() {
      return SizedBox(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "User",
                  style: blackTextStyle,
                ),
                Text(
                  "$namaUser",
                  style: blackTextStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nama Paket",
                  style: blackTextStyle,
                ),
                Expanded(
                  child: Text(
                    paket.nama_paket,
                    style: blackTextStyle,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Metode",
                  style: blackTextStyle,
                ),
                dropdownMetode(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pax",
                  style: blackTextStyle,
                ),
                CustomNumberPicker(
                  initialValue: 1,
                  maxValue: 100,
                  minValue: 1,
                  step: 1,
                  onValue: (value) {
                    setState(() {
                      totalValue = (value as int) * paket.harga;
                    });
                    print("ini totalValue $totalValue");
                    print("ini paxValue $value");
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: blackTextStyle,
                ),
                Text(
                  "Rp. $totalValue",
                  style: blackTextStyle,
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget payNowButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 75),
        child: TextButton(
          onPressed: () {
            print('di klik');
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0XFF31A5BE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Bayar Sekarang!',
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              headerSummary(),
              const Divider(
                thickness: 1,
              ),
              dataTransaction(),
              payNowButton()
            ],
          ),
        ));
  }
}
