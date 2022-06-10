import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoqobajoe/model/paket.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  
  int activeIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    
    Paket paket= ModalRoute.of(context)!.settings.arguments as Paket;
    
    List<String> urlImages = paket.photo_wisata;

    TabController _tabController = TabController(length: 2, vsync: this);
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Slider
          pictSlide(urlImages),
          const SizedBox(height: 6),

          //indicator dot
          Center(child: buildIndicator(urlImages)),

          //Text
          titleAndPrice(paket.nama_paket,paket.harga),

          const SizedBox(height: 12),

          //widget TabBar
          tabBar(_tabController),
          tabBarView(_tabController,paket.deskripsi,paket.destinasi_wisata),

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
            onPressed: () => {Navigator.pushNamed(context, "/start")},
          ),
        ));
  }

  Padding titleAndPrice(String title, int price) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text("Harga : IDR $price")
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

  Container tabBarView(TabController _tabController,String paket,List<String> destinasi) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        padding: const EdgeInsets.all(10),
        height: 150,
        child: TabBarView(controller: _tabController, children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(paket),
                SizedBox(height: 10),
                Text("Daftar Destinasi :"),
                Text("  • ${destinasi[0]} "),
                Text("  • ${destinasi[1]}"),
                Text("  • ${destinasi[2]}"),
              ],
            ),
          ),

          //buat list review
          _buildListView()
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

  CarouselSlider pictSlide(List<String> urlImages) {
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

  Widget buildIndicator(List<String> urlImages) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: const ScrollingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
        ),
      );

  ListView _buildListView() {
    return ListView.builder(
            itemCount: 2,
            itemBuilder: (_, index) {
              return const Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text("Nama Orang"),
                    subtitle: Text(
                        "sdfffffffffffffffffffffdsffffffffdssssssssssssssssssssssssssssssssssssssssssssssssssss"),
                  ));
            });
  }
}
