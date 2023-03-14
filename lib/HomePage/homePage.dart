import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/CurrentUser/RememberUser.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/Home.dart';

import 'package:tosepatu/Screen/Pesanan/pesanan.dart';
import 'package:tosepatu/Screen/Setting/profile.dart';
import 'package:tosepatu/Screen/Riwayat/riwayat.dart';
import 'package:tosepatu/Shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int index = 0;
List<Widget> screen = <Widget>[
  const Home(),
  const Pesanan(),
  const Riwayat(),
  const Profile(),
];

List navbutton = [
  {
    "active_icon": Icons.home_rounded,
    "non_active_icon": Icons.home_outlined,
    "label": "Beranda"
  },
  {
    "active_icon": Icons.assignment,
    "non_active_icon": Icons.assignment_outlined,
    "label": "Pesanan"
  },
  {
    "active_icon": Icons.restore,
    "non_active_icon": Icons.restore,
    "label": "Riwayat"
  },
  {
    "active_icon": Icons.settings,
    "non_active_icon": Icons.settings,
    "label": "Pengaturan"
  },
];

class _HomePageState extends State<HomePage> {
  void onTap(value) {
    setState(() {
      index = value;
      // _currentUser.getUserInfo();
    });
  }

  final CurrentUser _currentUser = Get.put(CurrentUser());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (RememberUser.readUser() != null) {
      _currentUser.getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      // backgroundColor: Color(0xfffafafa),
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: onTap,
          backgroundColor: Colors.white,
          showSelectedLabels: true,
          unselectedLabelStyle: GoogleFonts.mulish(fontWeight: FontWeight.w300),
          selectedLabelStyle: GoogleFonts.mulish(fontWeight: FontWeight.w500),
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedItemColor: Color(0xFF5FD3D0),
          unselectedItemColor: Color(0xff595959),
          items: List.generate(4, (index) {
            var navBtn = navbutton[index];
            return BottomNavigationBarItem(
                icon: Icon(navBtn["non_active_icon"]),
                activeIcon: Icon(navBtn["active_icon"]),
                label: navBtn["label"]);
          })),
    );
  }
}
