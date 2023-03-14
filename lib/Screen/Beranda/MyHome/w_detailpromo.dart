import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Model/beritaModel.dart';
import 'package:tosepatu/Shared/theme.dart';

class DetailPromo extends StatelessWidget {
  final myBerita berita;
  const DetailPromo({Key key, this.berita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appcolor2,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Detail Promo',
          style: GoogleFonts.mulish(
              fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              color: whiteColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: NetworkImage(Api.imageberita + berita.fotoBerita),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    berita.namaBerita,
                    style: mulishStyleLarge.copyWith(
                        color: blackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    berita.descriptionBerita,
                    style: mulishStyleLarge.copyWith(
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
