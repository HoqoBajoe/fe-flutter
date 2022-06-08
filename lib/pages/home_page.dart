import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/model/paket.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchPaket() async {
  final response =
      await http.get(Uri.parse('https://hoqobajoe.herokuapp.com/api/paket'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body)["data"];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _paket;

  @override
  void initState() {
    _paket = fetchPaket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
          child: Container(
        child: buildBody(),
      )),
    );
  }

  ListView buildBody() {
    return ListView(children: [
      Column(
        children: [
          //Text
          Container(
            margin: const EdgeInsets.only(top: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "World of Paradise,",
                  style: GoogleFonts.poppins(
                      fontSize: 38, fontWeight: FontWeight.bold, height: 0.5),
                ),
                Text(
                  "Indonesia",
                  style: GoogleFonts.poppins(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),

          //search
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            height: 50,
            width: 340,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)),
            child: const TextField(
              decoration: InputDecoration(
                  hintText: "Search Place",
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14)),
            ),
          ),

          //Text Widget
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Category",
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "View All",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),

          //popular list
          Container(
              margin: const EdgeInsets.only(left: 30),
              height: 300,
              child: FutureBuilder(
                  future: _paket,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildCard(snapshot.data[index]["photo_wisata"][1],
                                snapshot.data[index]["destinasi_wisata"][1]),
                        separatorBuilder: (content, _) => SizedBox(width: 12),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  })),

          //Text widget
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended",
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "View All",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),

      //list recommended

      Container(
          margin: const EdgeInsets.only(left: 30),
          height: 300,
          child: FutureBuilder(
              future: _paket,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildListRecs(snapshot.data[index]["photo_wisata"][1],
                            snapshot.data[index]["destinasi_wisata"][1]),
                    separatorBuilder: (content, _) => SizedBox(height: 12),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              })),
    ]);
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
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget buildListRecs(
    String imagePhoto,placeName,
   
    
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
                  placeName,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                ),
                const SizedBox(width: 16),
                Text(
                  "Indonesia",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14),
                ),
                Row(
                  children: [
                    const Icon(Icons.star_rounded),
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

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Hoqo Bajoe",
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      // leading: Padding(
      //   padding: const EdgeInsets.only(left: 10),
      //   child: IconButton(
      //     icon: const Icon(
      //       Icons.menu,
      //       color: Colors.black,
      //     ),
      //     onPressed: () => {},
      //   ),
      // ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 10),
      //     child: IconButton(
      //       icon: const Icon(
      //         Icons.account_circle_rounded,
      //         color: Colors.black,
      //       ),
      //       onPressed: () => {},
      //     ),
      //   )
      // ],
    );
  }
}
