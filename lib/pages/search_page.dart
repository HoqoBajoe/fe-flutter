import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/model/paket.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputUser = ModalRoute.of(context)!.settings.arguments as String;

    Future<List<Paket>> fetchPaket() async {
      var response = await http.get(Uri.parse(
          'https://hoqobajoe.herokuapp.com/api/paket?nama_paket=' + inputUser));
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body)['data'];
        return (responseJson as List).map((e) => Paket.fromJson(e)).toList();
      } else {
        return <Paket>[];
      }
    }

    Widget buildListRecs(String imagePhoto, paketName, List<String> list) =>
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
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.yellow,
                      ),
                      Text(
                        "4.9",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
    Container listRecommended() {
      return Container(
          margin: const EdgeInsets.only(left: 15, top: 10),
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: fetchPaket(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Paket> paket = snapshot.data as List<Paket>;
                  return ListView.separated(
                    itemCount: paket.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/detail_page",
                            arguments: paket[index]);
                      },
                      child: buildListRecs(
                          paket[index].photo_wisata[1],
                          paket[index].nama_paket,
                          paket[index].destinasi_wisata),
                    ),
                    separatorBuilder: (content, _) =>
                        const SizedBox(height: 12),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                );
              }));
    }

    AppBar buildAppBar() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Search",
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      );
    }

    // Screen
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            listRecommended(),
            listRecommended(),
            listRecommended(),
            listRecommended(),
            listRecommended(),
            listRecommended(),
            listRecommended(),
          ],
        ),
      ),
    );
  }
}
