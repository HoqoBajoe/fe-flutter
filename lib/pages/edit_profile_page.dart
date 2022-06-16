import 'package:flutter/material.dart';
import 'package:hoqobajoe/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppbar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
          child: Column(
            children: [
              profilePicture(),
              nameField(),
              emailField(),
              editButton(),
              showRole(),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar buildAppbar() {
  return AppBar(
    leading: Container(
      padding: EdgeInsets.only(left: 10),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        color: Colors.black,
        onPressed: () => {},
      ),
    ),
    centerTitle: true,
    title: Text(
      'My Profile',
      style: GoogleFonts.poppins(
          fontSize: 20, color: Colors.black, fontWeight: bold),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

Widget profilePicture() {
  return Icon(Icons.account_circle_sharp, size: 150);
}

Widget nameField() {
  return Container(
    margin: const EdgeInsets.only(top: 20),
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
                      hintText: 'Muhammad Ghifari Adrian',
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

Widget emailField() {
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
                    hintText: 'ghifari@mail.com',
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
    margin: const EdgeInsets.only(top: 190),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: backgroundColor5,
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

Widget showRole() {
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
                  'USER',
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
