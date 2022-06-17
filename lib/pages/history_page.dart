import 'package:flutter/material.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:hoqobajoe/model/history_transaction.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';



class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);
  
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final storage = const FlutterSecureStorage();

  Future<List<HistTrans>> fetchHistory() async {
  var token = await storage.read(key: "TOKEN");
  var response =
      await http.get(Uri.parse('https://hoqobajoe.herokuapp.com/api/history'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer $token '
        }
      );
  return (json.decode(response.body)['data'] as List)
      .map((e) => HistTrans.fromJson(e))
      .toList();
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
                Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 5),
                  child: Text(
                    "History Transaction",
                    style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 1000,
                  child: FutureBuilder(
                    future: fetchHistory(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                        List<HistTrans> history = snapshot.data as List<HistTrans>;
                        return ListView.separated(
                          itemCount: 3,
                          itemBuilder: (context, index) => listTransaction(history[index]),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 5),
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card listTransaction(HistTrans history) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.namaPaket,
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 5),
                Text(
                  "${history.pax} x Rp. ${history.harga}",
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12),
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    history.metode,
                    style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "June 16,2022",
                    style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total",
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 5),
                Text(
                  history.total.toString(),
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
