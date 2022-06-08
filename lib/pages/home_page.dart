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
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          child: buildBody(),
        )
      ) ,
    );
  }

  ListView buildBody() {
    return ListView(
      children: [
      
        Column(
          children: [
            //Text
            Container(
              margin: const EdgeInsets.only(top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("World of Paradise,",
                    style: GoogleFonts.poppins(
                      fontSize: 38,fontWeight: FontWeight.bold, height: 0.5
                    ),
                  ),
                  Text("Indonesia",
                    style: GoogleFonts.poppins(
                      fontSize: 38,fontWeight: FontWeight.bold,color: Colors.red
                    ),
                  ),
                ],
              ),
            ),
      
            //search
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30,vertical: 20
              ),
              height: 50,
              width: 340,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search Place",
                  hintStyle: TextStyle(fontSize: 16,color: Colors.grey),
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14
                  )
                ),
              ),
            ),
      
            //Text Widget
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30,vertical: 10
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Category",
                      style: GoogleFonts.poppins(
                        fontSize: 22,fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        fontSize: 20,fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                ),
            ),
      
            //popular list
            Container(
              margin: const EdgeInsets.only(
                left: 30
              ),
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context,index) =>buildCard(), 
                separatorBuilder: (content,_) => SizedBox(width: 12), 
              ),
            ),
      
            //Text widget
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30,vertical: 20
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended",
                      style: GoogleFonts.poppins(
                        fontSize: 22,fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        fontSize: 20,fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 30
              ),
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (context,index) =>buildListRecs(), 
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
            ),
          ],
        )
      ]
    );
  
  }

  Widget buildCard() => Stack(
      children: [
        Container(
          height: 300,
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network("https://raw.githubusercontent.com/HoqoBajoe/fe/master/src/Images/card.jpg",fit: BoxFit.cover,),
          ),
        ),
        Positioned(
          top:250,
          left: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
              child: Container(
                padding: const EdgeInsets.all(6),
                alignment: Alignment.centerLeft,
                child: Text("Labuan Bajo, Indonesia",
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

  Widget buildListRecs() => Row(
    children: [
      Container(
        height: 75,
        width: 75,
        child: ClipRRect(
           borderRadius: BorderRadius.circular(12),
              child: Image.network("https://raw.githubusercontent.com/HoqoBajoe/fe/master/src/Images/card.jpg",fit: BoxFit.cover,), 
        ),
      ),
      SizedBox(width: 10,),
      Container(
        padding: const EdgeInsets.only(left:10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Labuan Bajo",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
              ),
              SizedBox(width:16),
              Text("Indonesia",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 14),
              ),
              Row(
                children: [
                  Icon(Icons.star_rounded),
                  Text("4.9",
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
          fontSize:16, fontWeight: FontWeight.bold,color:Colors.black
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left:10),
        child: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => {},
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right:10),
          child: IconButton(
            icon: const Icon(
              Icons.account_circle_rounded,
              color: Colors.black,
            ),
            onPressed: () => {},
          ),
        )
      ],
    );
  }
}
