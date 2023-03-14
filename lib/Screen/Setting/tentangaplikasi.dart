import 'package:flutter/material.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class Tentang extends StatelessWidget {
  const Tentang({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appcolor2,
        shadowColor: Colors.transparent,
        centerTitle: true,
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
        title: Text(
          'Tentang',
          style: GoogleFonts.mulish(
              fontSize: 18, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: whiteColor,
          padding: const EdgeInsets.all(21),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/logo/logo2.jpg",
                  height: 200,
                ),
                Text(
                  "     ToSepatu Merupakan Usaha Dalam Bidang Jasa Cuci Sepatu Yang Menyediakan Beberapa Layanan Cuci Sepatu Dengan Harga Terjangkau, Layanan Cepat, Dan Hasil Yang Tepat.",
                  style: GoogleFonts.mulish(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: blackColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "     Terbentuknya Kami Ber-Awal Dari Sekelompok Pertemanan Yang Sedang Memikirkan Kehidupan Untuk Mengisi Waktu Luang. Dimulainya Bisnis Ini Pada Tanggal 21 September 2022, Sementara Sampai Saat Ini Tempatnya Berada Di Kabupaten Jember.",
                  style: GoogleFonts.mulish(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: blackColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
