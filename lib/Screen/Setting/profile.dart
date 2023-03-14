import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/Screen/Setting/infoaplikasi.dart';
import 'package:tosepatu/Screen/Setting/tentangaplikasi.dart';
import 'package:tosepatu/Screen/Setting/theme/theme_manager.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

final CurrentUser currentUser = Get.put(CurrentUser());

class _ProfileState extends State<Profile> {
  String verifyLink;

  Future checkUser() async {
    var res = await http.post(Uri.parse(Api.check), body: {
      "email_user": currentUser.user.emailUser,
    });
    var responseJson = json.decode(res.body);
    if (responseJson['status'] == 'success') {
      setState(() {
        verifyLink = responseJson['verify_link'];
        sendVerificationEmail();
      });
    } else {
      Fluttertoast.showToast(msg: responseJson['message']);
    }
  }

  Future<void> sendVerificationEmail() async {
    String username = 'karnando1994@gmail.com';
    String password = 'jziaaypfikqyvkcd';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username)
      ..recipients.add(currentUser.user.emailUser)
      ..subject = 'Verifikasi Email Anda di Tosepatu'
      ..html =
          "<h3>Klik link berikut untuk mengaktifkan email Anda</h3>\n<p> <a href='$verifyLink'>Verifikasi Sekarang</a></p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Email Verifikasi Terkirim: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Email Verifikasi Gagal Terkirim.\n' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          height: MediaQuery.of(context).size.height * 1.0,
          child: Stack(
            children: [
              Container(),
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1d6ea3),
                      Color(0xff2c8eb3),
                      Color(0xFF5FD3D0)
                    ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                right: 0,
                left: 0,
                bottom: currentUser.user.verifiedUser == '1' ? 120 : 70,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 1,
                              color: darkBlue.withOpacity(0.1),
                              offset: Offset(1.0, 1.0))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "Pengaturan",
                                  style: mulishStyleMedium.copyWith(
                                      fontSize: 16,
                                      color: blackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: currentUser.user.verifiedUser == '1',
                            child: Container(
                              height: 60,
                              margin: const EdgeInsets.only(bottom: 5, top: 15),
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red.withOpacity(0.2),
                                  border:
                                      Border.all(width: 1, color: Colors.red)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      checkUser();
                                    },
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'images/logo/gmail.png',
                                          height: 25,
                                          width: 25,
                                        )
                                      ],
                                    ),
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Verifikasi Email anda sekarang",
                                            style: mulishStyleSmall.copyWith(
                                                color: blackColor,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          color: blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: getSetting(Icons.account_circle_rounded,
                                'Pengaturan pengguna', 0),
                          ),
                          Divider(
                            height: 0,
                          ),
                          getSetting(
                              Icons.info_outline_rounded, 'Info Aplikasi', 1),
                          Divider(
                            height: 0,
                          ),
                          getSetting(Icons.book, 'Tentang', 2),
                          Divider(
                            height: 0,
                          ),
                          getSetting(Icons.help_outline_rounded,
                              'Bantuan dan dukungan', 3),
                          Divider(
                            height: 0,
                          ),
                          getSetting(Icons.room, 'Lokasi Toko', 4),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xff006ACC),
                                  Color(0xff00E0FF),
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            'https://tse3.mm.bing.net/th?id=OIP.E5BiGdDfDxAR89VNmxP8RQHaHa&pid=Api&P=0'),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser.user.usernameUser,
                              style: mulishStyleMedium.copyWith(
                                  fontSize: 18,
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              currentUser.user.emailUser,
                              style: mulishStyleMedium.copyWith(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 40,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Text(
                    //     "Pengaturan",
                    //     style: mulishStyleMedium.copyWith(
                    //         fontSize: 16,
                    //         color: whiteColor,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "@tosepatu.kc",
                      style: GoogleFonts.mulish(
                          fontSize: 12, color: Colors.grey.withOpacity(0.5)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ThemeManager _themeManager = ThemeManager();
  ListTile getSetting(IconData icon, String text, int i) {
    return ListTile(
      onTap: () {
        if (i == 0) {
        } else if (i == 1) {
          Navigator.push(
              context,
              PageTransition(
                  child: InfoAplikasi(), type: PageTransitionType.fade));
        } else if (i == 2) {
          Navigator.push(context,
              PageTransition(child: Tentang(), type: PageTransitionType.fade));
        } else if (i == 3) {
          _launchURL("https://wa.me/message/TJHCXV2IHL45I1");
        }
      },
      leading: Icon(
        icon,
        color: blackColor,
      ),
      title: Text(
        text,
        style: mulishStyleSmall.copyWith(
            color: blackColor, fontWeight: FontWeight.w500),
      ),
      trailing: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: appcolor2.withOpacity(0.1)),
        child: Icon(
          Icons.keyboard_arrow_right_rounded,
          color: appcolor2,
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
