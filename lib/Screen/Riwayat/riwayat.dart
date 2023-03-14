import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tosepatu/Screen/Riwayat/tabview/dibatalkan.dart';
import 'package:tosepatu/Screen/Riwayat/tabview/proses.dart';
import 'package:tosepatu/Screen/Riwayat/tabview/selesai.dart';
import 'package:tosepatu/Screen/Riwayat/tabview/semua.dart';
import 'package:tosepatu/Screen/Riwayat/tabview/menunggu_konfirmasi.dart';
import 'package:tosepatu/Shared/theme.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({Key key}) : super(key: key);

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: appcolor2,
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Riwayat',
            style: GoogleFonts.mulish(
                fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: TabBar(
                    unselectedLabelColor: Colors.grey.shade700,
                    labelColor: Colors.black,
                    labelStyle: GoogleFonts.mulish(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: GoogleFonts.mulish(
                        fontSize: 14, fontWeight: FontWeight.w500),
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(),
                    ),
                    tabs: const [
                      Tab(text: "Semua Pesanan"),
                      Tab(text: "Menunggu Konfirmasi"),
                      Tab(text: "Proses"),
                      Tab(text: "Selesai"),
                      Tab(text: "Dibatalkan"),
                    ]),
              ),
              const Expanded(
                  child: TabBarView(children: [
                SizedBox(
                  child: SemuaRiwayat(),
                ),
                SizedBox(
                  child: MenungguKonfirmasi(),
                ),
                SizedBox(
                  child: Proses(),
                ),
                SizedBox(
                  child: Selesai(),
                ),
                SizedBox(
                  child: Dibatalkan(),
                ),
              ]))
            ],
          ),
        )),
      ),
    );
  }
}
