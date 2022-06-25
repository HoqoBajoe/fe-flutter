import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class editUser {
  final String nama;
  final String email;
  final String role;

  editUser({
    required this.nama,
    required this.email,
    required this.role,
  });

  factory editUser.fromJson(Map<String, dynamic> json) {
    return editUser(
      nama: json['nama'],
      email: json['email'],
      role: json['role'],
    );
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  final storage = const FlutterSecureStorage();

  Future<editUser> fetchUser() async {
    var token = await storage.read(key: "TOKEN");
    var response = await http.get(
        Uri.parse('https://hoqobajoe.herokuapp.com/api/account'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token '
        });

    var responseJson = json.decode(response.body)['data'];
    return editUser.fromJson(responseJson);
  }

  Future<void> editProfileBTN(String nama, String? email) async {
    var token = await storage.read(key: "TOKEN");
    final response = await http.put(
      Uri.parse('https://hoqobajoe.herokuapp.com/api/user/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token '
      },
      body: jsonEncode(
        <String, String?>{
          'nama': nama,
          'email': email,
        },
      ),
    );

    if (response.statusCode == 200) {
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Success',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff3ccd71),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Update profile sukses",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff12313E),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff3ccd71), // Background color
                    ),
                    child: Text(
                      'Close',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/start'),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Gagal',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xfff04f4e),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Update profile gagal",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff12313E),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xfff04f4e), // Background color
                    ),
                    child: Text(
                      'Close',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> doLogout() async {
    var storage = const FlutterSecureStorage();
    await storage.deleteAll();
    print('logout');
    Navigator.pushNamed(context, '/start');
  }

  @override
  Widget build(BuildContext context) {
    var txtEditName = TextEditingController();
    var txtEditEmail = TextEditingController();
    Widget logOutButton() {
      return Container(
        height: 40,
        width: 100,
        margin: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: alertColor,
          ),
          child: Text(
            'Log Out',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: bold,
            ),
          ),
          onPressed: () {
            doLogout();
          },
        ),
      );
    }

    AppBar buildAppbar() {
      return AppBar(
        centerTitle: true,
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
              fontSize: 20, color: Colors.black, fontWeight: bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            child: logOutButton(),
          )
        ],
      );
    }

    Widget profilePicture() {
      // return Icon(Icons.account_circle_sharp, size: 150);
      return Container(
        child: Column(
          children: [
            const Center(
              child: Image(
                image: AssetImage("assets/images/user_vector.png"),
                width: 190,
              ),
            )
          ],
        ),
      );
    }

    Widget nameField(String nama) {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: txtEditName,
                        decoration: InputDecoration.collapsed(
                          hintText: nama,
                          hintStyle: hintTextStyle,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      );
    }

    Widget emailField(String email) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.mail_outline,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: txtEditEmail,
                      decoration: InputDecoration.collapsed(
                        hintText: email,
                        hintStyle: hintTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget editButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: secondaryColor,
          ),
          child: Text(
            'Edit Profile',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: bold,
            ),
          ),
          onPressed: () {
            editProfileBTN(txtEditName.text, txtEditEmail.text);
          },
        ),
      );
    }

    Widget showRole(String role) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      role,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: buildAppbar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
          child: FutureBuilder(
            future: fetchUser(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                editUser _profile = snapshot.data as editUser;
                return Column(
                  children: [
                    profilePicture(),
                    nameField(_profile.nama),
                    emailField(_profile.email),
                    showRole(_profile.role),
                    editButton(),
                  ],
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
      ),
    );
  }
}
