import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hoqobajoe/components/modal_message.dart';
import 'package:hoqobajoe/model/paket.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:http/http.dart' as http;

class AddReview extends StatefulWidget {
  AddReview({Key? key}) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  int? ratingStars;
  TextEditingController controllerReview = TextEditingController();
  var storage = const FlutterSecureStorage();
  String? token;

  Future<void> getStorage() async {
    var getToken = await storage.read(key: "TOKEN");
    setState(() {
      token = getToken;
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

    // Add Review (Consume API)
    Future<void> doAddReview(int stars, String review) async {
      final response = await http.post(
        Uri.parse('https://hoqobajoe.herokuapp.com/api/review/paket/' +
            paket.id.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token '
        },
        body: jsonEncode({
          'stars': stars,
          'review': review,
        }),
      );
      if (response.statusCode == 201) {
        Navigator.pop(context);
        modalMessage(
            'Success',
            successColor,
            'Berhasil memberikan review, mohon bersabar review akan di cek oleh admin',
            messageColor,
            context);
      } else if (token == null) {
        modalMessage(
          'Gagal',
          gagalColor,
          'Harap login terlebih dahulu.',
          messageColor,
          context,
        );
      } else {
        modalMessage(
          'Gagal',
          gagalColor,
          'Gagal memberikan review, hubungi admin.',
          messageColor,
          context,
        );
      }
    }

    AppBar buildAppBar() {
      return AppBar(
          centerTitle: true,
          title: Text(
            "Hoqo Bajoe",
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
          ));
    }

    SingleChildScrollView addReview() {
      return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
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
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stars ',
                  style: blackTextStyle,
                ),
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratingStars = rating.toInt();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: TextFormField(
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 6 * 4),
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.chat,
                      color: Colors.black,
                    ),
                    hintText: "Masukkan Review...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
                onChanged: (value) {
                  setState(() {});
                },
                controller: controllerReview,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 5),
              child: ElevatedButton(
                onPressed: () {
                  int newRatingStars = ratingStars?.toInt() ?? 0;
                  doAddReview(newRatingStars, controllerReview.text);
                },
                child: const Text(
                  "Submit Review",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: addReview(),
      ),
    );
  }
}
