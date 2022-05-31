import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          "Explore",
          style: GoogleFonts.poppins(
            fontSize: 38,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    Widget customListTabBar() {
      return Container(
        height: 30,
        margin: const EdgeInsets.only(top: 15),
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            labelPadding: const EdgeInsets.only(right: 15),
            indicatorPadding: const EdgeInsets.only(right: 15),
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            labelStyle:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700),
            unselectedLabelStyle:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700),
            tabs: const [
              Tab(
                child: Text('Recommended'),
              ),
              Tab(
                child: Text('Popular'),
              ),
              Tab(
                child: Text('Destination'),
              ),
            ],
          ),
        ),
      );
    }

    Widget recommendationTab() {
      return Container(
        height: 219,
        margin: const EdgeInsets.only(top: 16),
        child: PageView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 29),
              width: 335,
              height: 219,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://raw.githubusercontent.com/HoqoBajoe/fe/master/src/Images/card.jpg"),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaY: 20,
                          sigmaX: 20,
                        ),
                        child: Container(
                          height: 36,
                          padding: const EdgeInsets.only(
                            left: 17,
                            right: 14,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(
                                "Labuan Bajo, Indonesia",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget popularCategory() {
      return Padding(
        padding: const EdgeInsets.only(top: 48, right: 29),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Category",
              style: GoogleFonts.poppins(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            Text(
              "Show all",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: ListView(
            children: [
              title(),
              customListTabBar(),
              recommendationTab(),
              popularCategory(),
            ],
          ),
        ),
      ),
    );
  }
}
