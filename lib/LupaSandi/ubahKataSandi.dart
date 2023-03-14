import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tosepatu/Comm/getTextForm.dart';
import 'package:tosepatu/LupaSandi/lupaKataSandi.dart';
import 'package:tosepatu/login.dart';

class UbahKataSandi extends StatefulWidget {
  const UbahKataSandi({Key key}) : super(key: key);

  @override
  State<UbahKataSandi> createState() => _UbahKataSandiState();
}

class _UbahKataSandiState extends State<UbahKataSandi> {
  var password = TextEditingController();
  var conpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LupaPassword()));
            },
            child: Icon(Icons.keyboard_arrow_left),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF5FD3D0),
        shadowColor: Colors.transparent,

        title: Text(
          'Ubah Kata Sandi',
          style: GoogleFonts.mulish(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //   borderRadius: const BorderRadius.only(
        //       bottomLeft: Radius.circular(20),
        //       bottomRight: Radius.circular(20)),
        //   color: Color(0xFF5FD3D0),
        // )),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 540,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Image.asset(
                      'images/logo/logo2.jpg',
                      height: 150,
                    )),
                    Text(
                      'Ubah Kata Sandi',
                      style: GoogleFonts.mulish(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Masukkan kata sandi baru anda dan konfirmasi kata sandi di bawah ini',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'KATA SANDI BARU',
                                style: GoogleFonts.mulish(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        getTextForm(
                          controller: password,
                          hintName: 'Masukan Kata Sandi Baru',
                          keyboardType: TextInputType.name,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                          length: 100,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'KONFIRMASI KATA SANDI BARU',
                                style: GoogleFonts.mulish(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        getTextForm(
                          controller: conpassword,
                          hintName: 'Masukan Konfirmasi Kata Sandi',
                          keyboardType: TextInputType.name,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                          length: 100,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5FD3D0),
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () {
                            // verifyLogin();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          },
                          child: Text(
                            'Ubah Kata Sandi',
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "@tosepatu.kc",
                          style: GoogleFonts.mulish(
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.5)),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
