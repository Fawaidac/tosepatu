import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_otp/email_otp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tosepatu/LupaSandi/lupaKataSandi.dart';
import 'package:tosepatu/LupaSandi/ubahKataSandi.dart';

class Otp extends StatelessWidget {
  const Otp({Key key, this.otpController}) : super(key: key);

  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: GoogleFonts.mulish(fontSize: 20),
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        onSaved: (newValue) {},
      ),
    );
  }
}

class VerifikasiOtp extends StatefulWidget {
  const VerifikasiOtp({Key key}) : super(key: key);

  @override
  State<VerifikasiOtp> createState() => _VerifikasiOtpState();
}

class _VerifikasiOtpState extends State<VerifikasiOtp> {
  final EmailOTP emailotp = EmailOTP();
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Verifikasi OTP',
          style: GoogleFonts.mulish(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
                height: 450,
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
                      'Verifikasi OTP Anda',
                      style: GoogleFonts.mulish(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Masukkan otp yang telah dikirimkan ke alamat email anda',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Otp(
                          otpController: otp1,
                        ),
                        Otp(
                          otpController: otp2,
                        ),
                        Otp(
                          otpController: otp3,
                        ),
                        Otp(
                          otpController: otp4,
                        )
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
                          onPressed: () async {
                            if (await emailotp.verifyOTP(
                                    otp: otp1.text +
                                        otp2.text +
                                        otp3.text +
                                        otp4.text) ==
                                true) {
                              Fluttertoast.showToast(
                                  msg: "Verifikasi OTP Berhasil",
                                  backgroundColor: Colors.green);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UbahKataSandi(),
                                  ));
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Verifikasi OTP yang anda masukan invalid",
                                  backgroundColor: Colors.red);
                            }
                            // verifyLogin();
                          },
                          child: Text(
                            'Verifikasi',
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
