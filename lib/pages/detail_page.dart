import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  int activeIndex = 0;

  final urlImages = [
    "https://raw.githubusercontent.com/HoqoBajoe/fe/master/src/Images/background.jpg",
    "https://i0.wp.com/labuanbajotour.com/wp-content/uploads/2019/08/Sawah-Lingko-Labuan-Bajo-sumber-ig-funadventure_.jpg?fit=750%2C500&ssl=1",
    "https://i0.wp.com/labuanbajotour.com/wp-content/uploads/2019/08/Sawah-Lingko-Labuan-Bajo-sumber-ig-funadventure_.jpg?fit=750%2C500&ssl=1"
  ];

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: appBar(),
        body: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Slider
              pictSlide(),
              const SizedBox(height: 6),

              //indicator dot
              Center(child: buildIndicator()),

              //Text
              titleAndPrice(),

              const SizedBox(height: 12),

              //widget TabBar
              tabBar(_tabController),
              tabBarView(_tabController),

              //button
              buttonPay(),
            ],
          ),
        );
  }

  AppBar appBar() {
    return AppBar(
        centerTitle: true,
        title: Text(
          "Hoqo Bajoe",
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
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
              Navigator.pushNamed(context, "/start")
            },
          ),
        ));
  }

  Padding titleAndPrice() {
    return Padding(
      padding: const EdgeInsets.only(left: 30,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Labuan Bajo",
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text("Harga : IDR 20.000")
        ],
      ),
    );
  }

  Container buttonPay() {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 35),
      alignment: Alignment.centerRight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: const Color(0XFF31A5BE),
          height: 45,
          width: 150,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_rounded,
                color: Colors.white, size: 18),
            label: Text("Pay Now",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            style: ElevatedButton.styleFrom(
              primary: const Color(0XFF31A5BE),
            ),
          ),
        ),
      ),
    );
  }

  Container tabBarView(TabController _tabController) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        height: 250,
        child: TabBarView(controller: _tabController, children: [
          Flexible(child: Text("Destinasi wisata seperti ini bisa ditemukan di Pulau Kelor di Flores yang merupakan pulau kecil dengan pasir putih dan tanaman hijau di tengahnya, serta riak-riak kecil ombak yang tenang di perairan sekitarnya.Objek wisata Labuan Bajo ini wajib dikunjungi bagi yang menyukai warna pink. Jika dilihat dari sudut manapun, lokasinya asyik, sejuk, dan sangat pink!Sekedar berenang, berjemur atau snorkeling, apapun yang Anda pilih, apa yang Anda lihat dan rasakan akan memberikan kepuasan batin karena Anda telah menyaksikan kemegahan ciptaan Tuhan. Keren! Flores adalah rumah bagi sejumlah besar tempat wisata menakjubkan yang layak dikunjungi.")),
          Text("Review") //buat list review
        ]));
  }

  Container tabBar(TabController _tabController) {
    return Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: TabBar(
          labelColor: Colors.black,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          indicatorColor: Colors.black,
          tabs: const [Tab(text: "Overview"), Tab(text: "Review")],
        ));
  }

  CarouselSlider pictSlide() {
    return CarouselSlider.builder(
        itemCount: urlImages.length,
        itemBuilder: (context, index, realIndex) {
          final urlImage = urlImages[index];
          return buildImage(urlImage, index);
        },
        options: CarouselOptions(
          height: 400,
          enableInfiniteScroll: true,
          viewportFraction: 1,
          onPageChanged: (index, reason) => setState(() => activeIndex = index),
        ));
  }

  Widget buildImage(String urlImage, int index) => ShaderMask(
        shaderCallback: (rectangle) {
          return const LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
              .createShader(const Rect.fromLTRB(0, 250, 0, 400));
        },
        blendMode: BlendMode.dstIn,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: const ScrollingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
        ),
      );
}
