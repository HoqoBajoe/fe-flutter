import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/components/bottom_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              // Container(
              //   height: 58,
              //   margin: EdgeInsets.only(top: 29,left: 29,right: 29),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 58,
              //         width: 58,
              //         padding: EdgeInsets.all(18),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           color: Colors.white,
              //         ),
              //         // child: Image.asset(),
              //       )
              //     ],
              //   ),
              // )

              //Text for title
              Padding(
                padding: EdgeInsets.only(top: 48, left: 29),
                child: Text("Explore",
                    style: GoogleFonts.poppins(
                        fontSize: 38, fontWeight: FontWeight.w700)),
              ),

              //Custom Tab bar
              Container(
                height: 30,
                margin: EdgeInsets.only(left: 15, top: 29),
                child: DefaultTabController(
                  length: 3,
                  child: TabBar(
                    labelPadding: EdgeInsets.only(left: 15, right: 15),
                    indicatorPadding: EdgeInsets.only(left: 15, right: 15),
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black54,
                    labelStyle: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Text('Recommended'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Popular'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Destination'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Recommendation
              Container(
                height: 219,
                margin: EdgeInsets.only(top: 16, left: 29),
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 29),
                      width: 335,
                      height: 219,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/HoqoBajoe/fe/master/src/Images/card.jpg")),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                                child: Container(
                                  height: 36,
                                  padding: EdgeInsets.only(left: 17, right: 14),
                                  alignment: Alignment.centerLeft,
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
              ),

              //Text Widget
              Padding(
                padding: EdgeInsets.only(top: 48, left: 29, right: 29),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
