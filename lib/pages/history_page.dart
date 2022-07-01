import 'package:flutter/material.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:hoqobajoe/model/history_transaction.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  late Future<List<HistTrans>> future;
  bool? dataStatus;

  Future<List<HistTrans>> fetchHistory() async {
    var token = await storage.read(key: "TOKEN");
    var response = await http.get(
        Uri.parse('https://hoqobajoe.herokuapp.com/api/history'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token '
        });

    if (response.statusCode == 200) {
      dataStatus = true;
      var responseJson = json.decode(response.body)['data'];
      return (responseJson as List).map((e) => HistTrans.fromJson(e)).toList();
    } else {
      dataStatus = false;
      return <HistTrans>[];
    }
  }

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    _tabController.addListener(() {
      setState(() {});
    });
    future = fetchHistory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Padding text() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        "History Transaction",
        style:
            blackTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }

  SizedBox listHistory(String status) {
    return SizedBox(
      height: 700,
      child: FutureBuilder(
        future: future,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              print('no data');
              return Text('Null Data');
            } else {
              List<HistTrans> history = snapshot.data as List<HistTrans>;
              history = history.where((a) => a.status == status).toList();
              return ListView.separated(
                itemCount: history.length,
                itemBuilder: (context, index) => transaction(history[index]),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 5),
              );
            }
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
        },
      ),
    );
  }

  Card transaction(HistTrans history) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              history.namaPaket,
              style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tanggal pemesanan",
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                Text(
                  DateFormat.yMMMMd().format(history.createdAt),
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 14),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  history.metode,
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                Row(children: [
                  const Icon(Icons.airplane_ticket),
                  const SizedBox(width: 3),
                  Text(
                    "Pax (${history.pax}) x ${history.harga}",
                    style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ])
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "Rp. ${history.total.toString()}",
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container tabBarView(TabController _tabController) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 700,
      child: TabBarView(
        controller: _tabController,
        children: [
          listHistory("Pending"),
          listHistory("Accepted"),
          listHistory("Rejected"),
        ],
      ),
    );
  }

  SizedBox tabBar(TabController _tabController) {
    return SizedBox(
      height: 40,
      child: TabBar(
        labelColor: Colors.black,
        labelStyle: plainTextStyle.copyWith(
          fontWeight: bold,
        ),
        controller: _tabController,
        indicatorColor: _tabController.index == 0
            ? Colors.black
            : _tabController.index == 1
                ? Colors.green[600]
                : Colors.red,
        tabs: [
          Tab(
            child: Row(
              children: const [
                Icon(Icons.pending_outlined),
                Text(" Pending"),
              ],
            ),
          ),
          Tab(
            child: Row(children: [
              Icon(
                Icons.check_circle_outline,
                color: _tabController.index == 1
                    ? Colors.green[700]
                    : Colors.green[300],
              ),
              Text(
                " Success",
                style: TextStyle(
                    color: _tabController.index == 1
                        ? Colors.green[700]
                        : Colors.green[300]),
              )
            ]),
          ),
          Tab(
            child: Row(
              children: [
                Icon(
                  Icons.sms_failed_outlined,
                  color:
                      _tabController.index == 2 ? Colors.red : Colors.red[300],
                ),
                Text(
                  " Rejected",
                  style: TextStyle(
                      color: _tabController.index == 2
                          ? Colors.red
                          : Colors.red[300]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(),
                tabBar(_tabController),
                tabBarView(_tabController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
