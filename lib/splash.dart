import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/CurrentUser/RememberUser.dart';
import 'package:tosepatu/HomePage/homePage.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/Home.dart';
import 'package:tosepatu/Screen/Setting/profile.dart';
import 'package:tosepatu/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  @override
  void initState() {
    // TODO: implement initState
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FutureBuilder(
            future: RememberUser.readUser(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const LoginPage();
              } else if (snapshot.data != null) {
                currentUser.getUserInfo();
                return const HomePage();
              }
              return null;
            },
          ),
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo/logo2.jpg',
            height: 180,
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
              child: SpinKitFadingCircle(
            size: 30,
            color: Color(0xFF5FD3D0),
          ))
        ],
      ),
    );
  }
}
