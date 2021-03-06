import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hoqobajoe/components/modal_message.dart';
import 'package:hoqobajoe/model/user.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final storage = const FlutterSecureStorage();

  // Get Data User
  Future<User> fetchUser() async {
    var nullResponse = User(
      id: null,
      nama: null,
      email: null,
      role: null,
    );
    var token = await storage.read(key: "TOKEN");
    var response = await http.get(
        Uri.parse('https://hoqobajoe.herokuapp.com/api/account'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token '
        });

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body)['data'];
      return User.fromJson(responseJson);
    } else {
      return nullResponse;
    }
  }

  // Edit User Profile
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
      await storage.write(key: "NAMA", value: nama);
      modalMessageNamed(
        'Success',
        successColor,
        'Update profile success',
        messageColor,
        context,
        '/start',
      );
    } else {
      modalMessage(
        'Gagal',
        gagalColor,
        'Update profile gagal',
        messageColor,
        context,
      );
    }
  }

  Future<void> doLogout() async {
    var storage = const FlutterSecureStorage();
    await storage.deleteAll();
    modalMessageNamed(
      'Success',
      successColor,
      'Logout sukses',
      messageColor,
      context,
      '/start',
    );
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
            style: plainTextStyle.copyWith(
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
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.all(5),
            child: logOutButton(),
          )
        ],
      );
    }

    Widget profilePicture() {
      return Column(
        children: const [
          Center(
            child: Image(
              image: AssetImage("assets/images/user_vector.png"),
              width: 190,
            ),
          )
        ],
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
            style: plainTextStyle.copyWith(
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
                      style: blackTextStyle.copyWith(
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
                User _profile = snapshot.data as User;
                return Column(
                  children: [
                    profilePicture(),
                    nameField(_profile.nama.toString()),
                    emailField(_profile.email.toString()),
                    showRole(_profile.role.toString()),
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
