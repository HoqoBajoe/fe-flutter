import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hoqobajoe/model/paket.dart';
import 'package:hoqobajoe/model/review.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late TabController _tabController;
  int activeIndex = 0;
  late Future<List<ReviewUser>> future;
  TextEditingController controllerReview = TextEditingController();
  String? token;
  int? ratingStars;

  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  Future<void> getStorage() async {
    var storage = const FlutterSecureStorage();
    var getToken = await storage.read(key: "TOKEN");
    setState(() {
      token = getToken;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    ratingStars = 1;
    getStorage();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Paket paket = ModalRoute.of(context)!.settings.arguments as Paket;

    // Get Review
    Future<List<ReviewUser>> fetchReview() async {
      var response = await http.get(Uri.parse(
          'https://hoqobajoe.herokuapp.com/api/review/paket/' +
              paket.id.toString()));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body)['data'];
        return (responseJson as List)
            .map((e) => ReviewUser.fromJson(e))
            .toList();
      } else {
        return <ReviewUser>[];
      }
    }

    List<String> urlImages = paket.photo_wisata;

    Padding titleAndPrice(String title, int price) {
      return Padding(
        padding: const EdgeInsets.only(left: 30, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: plainTextStyle.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Text(
                "Harga ",
                style: blackTextStyle,
              ),
              Text(
                formatCurrency.format(price),
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '/pax',
                style: blackTextStyle.copyWith(fontSize: 12),
              )
            ])
          ],
        ),
      );
    }

    Container buttonAddReview() {
      return Container(
        margin: const EdgeInsets.only(left: 35),
        alignment: Alignment.centerRight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: const Color(0XFF31A5BE),
            height: 45,
            width: 150,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/add_review', arguments: paket);
              },
              icon:
                  const Icon(Icons.rate_review, color: Colors.white, size: 18),
              label: Text(
                "Tambah Review",
                style: plainTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: secondaryColor,
              ),
            ),
          ),
        ),
      );
    }

    Container buttonPay() {
      if (token != null) {
        return Container(
          margin: const EdgeInsets.only(right: 35),
          alignment: Alignment.centerRight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: const Color(0XFF31A5BE),
              height: 45,
              width: 150,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/transaction',
                      arguments: paket);
                },
                icon: const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white, size: 18),
                label: Text(
                  "Beli",
                  style: plainTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0XFF31A5BE),
                ),
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    }

    Widget buildReview(
        String nama, String comment, String rating, DateTime waktu) {
      double newRating = double.parse(rating);
      return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  itemSize: 20,
                  initialRating: newRating,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0.1),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Text(
                  DateFormat.yMMMMd().format(waktu),
                  style: blackTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              comment,
              style: blackTextStyle,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
    }

    Container listReview() {
      return Container(
          height: 300,
          child: FutureBuilder(
              future: fetchReview(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return const Text("No Data");
                  }
                  List<ReviewUser> reviewData =
                      snapshot.data as List<ReviewUser>;
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.separated(
                      itemCount: reviewData.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        child: buildReview(
                            reviewData[index].nama,
                            reviewData[index].review,
                            reviewData[index].stars.toString(),
                            reviewData[index].createdAt),
                      ),
                      separatorBuilder: (content, _) => const Divider(
                        height: 3,
                        color: Colors.black,
                      ),
                    ),
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

    // Overview
    Container tabBarView(
        TabController _tabController, String paket, List<String> destinasi) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        padding: const EdgeInsets.all(10),
        height: 175,
        child: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paket,
                    style: blackTextStyle,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Daftar Destinasi : ",
                    style: blackTextStyle,
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "  • ${destinasi[0]}",
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "  • ${destinasi[1]}",
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "  • ${destinasi[2]}",
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            listReview(),
          ],
        ),
      );
    }

    Container tabBar(TabController _tabController) {
      return Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: TabBar(
          labelColor: Colors.black,
          labelStyle: plainTextStyle.copyWith(
            fontWeight: medium,
          ),
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(text: "Overview"),
            Tab(text: "Review"),
          ],
        ),
      );
    }

    Widget buildImage(String urlImage, int index) => ShaderMask(
          shaderCallback: (rectangle) {
            return const LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)
                .createShader(
              const Rect.fromLTRB(0, 250, 0, 400),
            );
          },
          blendMode: BlendMode.dstIn,
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );

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
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ));
    }

    Widget buildIndicator(List<String> urlImages) => AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: urlImages.length,
          effect: const ScrollingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
          ),
        );

    AppBar appBar() {
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          titleAndPrice(paket.nama_paket, paket.harga),
          const SizedBox(height: 12),
          //widget TabBar
          tabBar(_tabController),
          tabBarView(_tabController, paket.deskripsi, paket.destinasi_wisata),
          //button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonAddReview(),
              buttonPay(),
            ],
          )
        ],
      ),
    );
  }
}
