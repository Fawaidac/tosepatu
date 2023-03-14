import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xff006ACC),
                Color(0xff00E0FF),
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
            )),
          )
        ],
      ),
    );
  }
}
