import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Comm/getSnackbar.dart';
import 'package:tosepatu/Comm/getTextForm.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/CurrentUser/RememberUser.dart';
import 'package:tosepatu/HomePage/homePage.dart';
import 'package:tosepatu/Model/userModel.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:tosepatu/daftar.dart';
import 'package:tosepatu/LupaSandi/lupaKataSandi.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  bool showpass = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      // backgroundColor: const Color(0xFFDFE0EB),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  height: 530,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Center(
                            child: Image.asset(
                          'images/logo/logo2.jpg',
                          height: 150,
                        )),
                      ),
                      Text(
                        'Masuk',
                        style: GoogleFonts.mulish(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Masukkan email dan kata sandi Anda\ndi bawah ini',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
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
                                  'EMAIL',
                                  style: GoogleFonts.mulish(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          getTextForm(
                            controller: emailcontroller,
                            hintName: 'Masukan Email',
                            keyboardType: TextInputType.emailAddress,
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
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'KATA SANDI',
                                  style: GoogleFonts.mulish(fontSize: 12),
                                ),
                                InkWell(
                                  onTap: () async {
                                    String url =
                                        "https://tosepatu.wstif3d.id/home/page/forgot.php";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Text(
                                    'Lupa Kata Sandi?',
                                    style: GoogleFonts.mulish(fontSize: 12),
                                  ),
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
                                obscureText: showpass,
                                controller: passwordcontroller,
                                style: GoogleFonts.mulish(fontSize: 13),
                                keyboardType: TextInputType.name,
                                enabled: true,
                                onSaved: (val) => passwordcontroller =
                                    val as TextEditingController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Your Password';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                  LengthLimitingTextInputFormatter(20)
                                ],
                                decoration: InputDecoration(
                                  hintText: 'Masukan Kata Sandi',
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
                                  suffixIcon: InkWell(
                                    child: Icon(
                                      showpass
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 20,
                                      color: Color(0xFF5FD3D0),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        showpass = !showpass;
                                      });
                                    },
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
                            onPressed: () {
                              // verifyLogin();
                              verifyLogin();
                            },
                            child: loading
                                ? SpinKitCircle(
                                    size: 30,
                                    color: whiteColor,
                                  )
                                : Text(
                                    'Masuk',
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white),
                                  )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum memiliki akun ? ",
                              style: GoogleFonts.mulish(fontSize: 12),
                            ),
                            InkWell(
                              child: Text(
                                "Daftar Akun",
                                style: GoogleFonts.mulish(
                                    color: const Color(0xFF5FD3D0),
                                    fontSize: 13),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const DaftarAkun(),
                                        type: PageTransitionType
                                            .rightToLeftWithFade));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final CurrentUser _currentUser = Get.put(CurrentUser());
  FutureOr onGoing(dynamic value) {
    _currentUser.getUserInfo();
    RememberUser.readUser();
  }

  void navigator() {
    Route route = MaterialPageRoute(
      builder: (context) => const HomePage(),
    );
    Navigator.pushReplacement(context, route).then(onGoing);
  }

  void verifyLogin() {
    if (emailcontroller.text.isEmpty) {
      MySnackbar(type: SnackbarType.error, title: "Email tidak boleh kosong")
          .showSnackbar(context);
    } else if (passwordcontroller.text.isEmpty) {
      MySnackbar(
              type: SnackbarType.error, title: "Kata sandi tidak boleh kosong")
          .showSnackbar(context);
    } else if (passwordcontroller.text.length < 8) {
      MySnackbar(
              type: SnackbarType.error,
              title: "Kata sandi tidak boleh kurang dari 8 karakter")
          .showSnackbar(context);
    } else {
      login();
    }
  }

  Future login() async {
    try {
      var response = await http.post(Uri.parse(Api.signin), body: {
        "email_user": emailcontroller.text,
        "password_user": passwordcontroller.text
      });
      if (response.statusCode == 200) {
        final user = jsonDecode(response.body);
        if (user['success'] == true) {
          setState(() {
            loading = true;
          });
          snackBarSucces();
          User userInfo = User.fromJson(user['user']);
          await RememberUser().storeUser(json.encode(userInfo));
          // ignore: use_build_context_synchronously
          navigator();
        } else if (user['message'] == 'Password Salah') {
          setState(() {
            loading = false;
          });
          snackBarWrongPass();
        } else {
          setState(() {
            loading = false;
          });
          snackBarFailed();
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e.toString());
    }
  }

  snackBarSucces() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
            title: "Berhasil",
            message: "Selamat, Anda Berhasil Masuk",
            contentType: ContentType.success)));
  }

  snackBarFailed() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
            title: "Gagal",
            message: "Email dan Kata Sandi Salah",
            contentType: ContentType.failure)));
  }

  snackBarWrongPass() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
            title: "Gagal",
            message: "Kata Sandi Salah",
            contentType: ContentType.failure)));
  }
}
