import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
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
  final String token;

  editUser({
    required this.nama,
    required this.email,
    required this.role,
    required this.token,
  });

  factory editUser.fromJson(Map<String, dynamic> json) {
    return editUser(
      nama: json['nama'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  final storage = const FlutterSecureStorage();

  Future<editUser> fetchUser() async {
    var token = await storage.read(key: "TOKEN");
    final response = await http.get(
      Uri.parse('https://hoqobajoe.herokuapp.com/api/account'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token '
      },
    );

    if (response.statusCode == 200) {
      return editUser.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to fetch User');
    }
  }

  Future<editUser> editProfileBTN(String nama, String email) async {
    var token = await storage.read(key: "TOKEN");
    final response = await http.put(
      Uri.parse('https://hoqobajoe.herokuapp.com/api/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token '
      },
      body: jsonEncode(
        <String, String>{'nama': nama, 'email': email},
      ),
    );

    if (response.statusCode == 200) {
      return editUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to edit');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.pushNamed(context, '/start');
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
        margin: const EdgeInsets.only(top: 150),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            primary: secondaryColor,
          ),
          child: Text(
            'Edit Profile',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: bold,
            ),
          ),
          onPressed: () {},
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
