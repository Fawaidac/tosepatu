import 'package:flutter/material.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoAplikasi extends StatelessWidget {
  const InfoAplikasi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: whiteColor,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  "images/logo/logo2.jpg",
                  height: 200,
                ),
              ),
              Text(
                "Versi Aplikasi : 1.2.1",
                style: GoogleFonts.mulish(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: blackColor),
              ),
              Text(
                "@tosepatu.kc",
                style: GoogleFonts.mulish(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: blackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
