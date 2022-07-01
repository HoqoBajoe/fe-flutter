import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/components/list_paket.dart';
import 'package:hoqobajoe/model/paket.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List<Paket>> fetchPaket() async {
  var response =
      await http.get(Uri.parse('https://hoqobajoe.herokuapp.com/api/paket'));
  return (json.decode(response.body)['data'] as List)
      .map((e) => Paket.fromJson(e))
      .toList();
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var txtSearch = TextEditingController();
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
          child: Container(
        child: buildHomePage(),
      )),
    );
  }

  ListView buildHomePage() {
    return ListView(children: [
      Column(
        children: [
          //Text
          textHeader(),
          //search
          searchPaket(),
          //Text Widget
          textPopular(),
          //popular list
          listPopular(),
          //Text widget
          textRecommended(),
        ],
      ),
      //list recommended
      listRecommended(),
    ]);
  }

  Container listRecommended() {
    return Container(
        margin: const EdgeInsets.only(left: 30),
        height: 300,
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
                    child: listPaket(
                      paket[index].photo_wisata[1],
                      paket[index].nama_paket,
                      paket[index].destinasi_wisata,
                      paket[index].harga,
                    ),
                  ),
                  separatorBuilder: (content, _) => const SizedBox(height: 12),
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

  Container textRecommended() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Recommended",
            style: blackTextStyle.copyWith(
              fontSize: 22,
              fontWeight: bold,
            ),
          ),
        ],
      ),
    );
  }

  Container listPopular() {
    return Container(
        margin: const EdgeInsets.only(left: 30),
        height: 300,
        child: FutureBuilder(
            future: fetchPaket(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Paket> paket = snapshot.data as List<Paket>;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: paket.length,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/detail_page",
                            arguments: paket[index]);
                      },
                      child: buildCard(paket[index].photo_wisata[1],
                          paket[index].destinasi_wisata[1])),
                  separatorBuilder: (content, _) => const SizedBox(width: 12),
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

  Container textPopular() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Popular Category",
            style: blackTextStyle.copyWith(
              fontSize: 22,
              fontWeight: bold,
            ),
          ),
        ],
      ),
    );
  }

  Container searchPaket() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: 50,
      width: 340,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: txtSearch,
        onSubmitted: (value) {
          Navigator.pushNamed(context, '/search', arguments: value.toString());
        },
        decoration: const InputDecoration(
            hintText: "Search Place",
            hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14)),
      ),
    );
  }

  Container textHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "World of Paradise,",
            style: GoogleFonts.poppins(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              height: 0.5,
            ),
          ),
          Text(
            "Indonesia",
            style: GoogleFonts.poppins(
                fontSize: 38, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String imagePhoto, String placeName) => Stack(
        children: [
          SizedBox(
            height: 300,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imagePhoto,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    placeName,
                    style: plainTextStyle.copyWith(
                      fontWeight: regular,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget buildListRecs(
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
                  style: blackTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "${list[0]},${list[1]},...",
                  style: blackTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
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

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Hoqo Bajoe",
        style: blackTextStyle.copyWith(
          fontSize: 16,
          fontWeight: bold,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
