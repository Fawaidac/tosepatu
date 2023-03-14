import 'package:flutter/material.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/Home.dart';
import 'package:tosepatu/Screen/Setting/theme/theme_manager.dart';
import 'package:tosepatu/login.dart';
import 'package:tosepatu/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tosepatu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const Splash(),
    );
  }
}
