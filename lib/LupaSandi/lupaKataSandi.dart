import 'dart:math';

import 'package:email_auth/email_auth.dart';
import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:tosepatu/Comm/getTextForm.dart';
import 'package:tosepatu/LupaSandi/ubahKataSandi.dart';
import 'package:tosepatu/LupaSandi/verifikasiOtp.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:tosepatu/login.dart';
import 'package:mailer/smtp_server/gmail.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({Key key}) : super(key: key);

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();

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
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Icon(Icons.keyboard_arrow_left),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF5FD3D0),
        shadowColor: Colors.transparent,
        title: Text(
          'Lupa Kata Sandi',
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
                height: 80,
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
                      'Lupa Kata Sandi',
                      style: GoogleFonts.mulish(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Masukkan alamat email anda',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'EMAIL',
                                style: GoogleFonts.mulish(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: email,
                              style: GoogleFonts.mulish(fontSize: 13),
                              keyboardType: TextInputType.name,
                              enabled: true,
                              onSaved: (val) =>
                                  email = val as TextEditingController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Your Email';
                                }
                                return null;
                              },
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter,
                                LengthLimitingTextInputFormatter(100)
                              ],
                              decoration: InputDecoration(
                                hintText: 'Masukan Email Anda',
                                isDense: true,
                                hintStyle: GoogleFonts.poppins(fontSize: 13),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xffF0F1F7), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xffF0F1F7), width: 1),
                                ),
                                filled: true,
                                suffixIcon: email.text.isEmpty
                                    ? null
                                    : EmailValidator.validate(email.text)
                                        ? const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                            size: 20,
                                          )
                                        : const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                fillColor: Color(0xFFFCFDFE),
                              ),
                            ),
                          ],
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
                          onPressed: () async {
                            // verifyLogin();
                            myauth.setConfig(
                                appEmail: "me@rohitchouhan.com",
                                appName: "Email OTP",
                                userEmail: email.text,
                                otpLength: 4,
                                otpType: OTPType.digitsOnly);
                            if (await myauth.sendOTP() == true) {
                              Fluttertoast.showToast(
                                  msg:
                                      "OTP berhasil dikirimkan ke alamat email anda",
                                  backgroundColor: Colors.green);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifikasiOtp(),
                                  ));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Gagal mengirim OTP",
                                  backgroundColor: Colors.red);
                            }
                          },
                          child: Text(
                            'Kirim OTP',
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

  // void sendOtp() async {
  //   EmailAuth emailAuth = EmailAuth(sessionName: "Test");
  //   bool res =
  //       await emailAuth.sendOtp(recipientMail: email.value.text, otpLength: 4);

  //   if (res) {
  //     Fluttertoast.showToast(
  //         msg: 'OTP berhasil dikirim ke email anda',
  //         backgroundColor: Colors.green);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: 'Gagal mengirim OTP', backgroundColor: Colors.red);
  //   }
  // }

  // void verifyOtp() {
  //   EmailAuth emailAuth = EmailAuth(sessionName: "Test");
  //   var res =
  //       emailAuth.validateOtp(recipientMail: email.text, userOtp: otpc.text);
  //   if (res) {
  //     Fluttertoast.showToast(
  //         msg: "Verifikasi OTP berhasil", backgroundColor: Colors.green);
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const UbahKataSandi(),
  //         ));
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "OTP yang anda masukan invalid", backgroundColor: Colors.red);
  //   }
  // }

  // String otp = Random().nextInt(1000000).toString();

  // void sendOTP() async {
  //   // Create our email message.
  //   final message = Message()
  //     ..from = const Address('tosepatu.kc@gmail.com', 'tosepatu')
  //     ..recipients.add(email.text)
  //     ..subject = 'OTP'
  //     ..text = 'Your OTP is: $otp';

  //   // Create our email transport.
  //   final smtpServer = gmail('tosepatu.kc@gmail.com', 'tosepatuxkc123');

  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //     Fluttertoast.showToast(
  //         msg: 'OTP berhasil dikirim ke email anda',
  //         backgroundColor: Colors.green);
  //   } on MailerException catch (e) {
  //     print('Message not sent.');
  //     for (var p in e.problems) {
  //       print('Problem: ${p.code}: ${p.msg}');
  //       Fluttertoast.showToast(msg: 'Problem: ${p.code}: ${p.msg}'.toString());
  //     }
  //     Fluttertoast.showToast(
  //         msg: 'Gagal mengirim OTP', backgroundColor: Colors.red);
  //   }
  // }
}
