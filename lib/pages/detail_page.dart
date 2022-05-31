import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                width: 500,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    'Image',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text(
                  "Paket Bajoe Banget!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text(
                  "Rp. 500000",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: const Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text(
                  "Liburan yang sangat mengasyikan di 3 tempat ini, kalian bisa menikmati Pulau Padar yang merupakan “sepotong kecil surga yang bertebaran di bumi”, Wae Rebo Desa ini sangat terkenal, hampir eksotis. ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey),
                ),
              ),
              Container(
                width: 700,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  // color: const Color(0xffC30010),
                  child: const Text(
                    "Book",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return const NewPass();
                    // }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
