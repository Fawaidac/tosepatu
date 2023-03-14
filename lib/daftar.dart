import 'dart:convert';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Comm/getSnackbar.dart';
import 'package:tosepatu/Comm/getTextForm.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:tosepatu/login.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';

class DaftarAkun extends StatefulWidget {
  const DaftarAkun({Key key}) : super(key: key);

  @override
  State<DaftarAkun> createState() => _DaftarAkunState();
}

class _DaftarAkunState extends State<DaftarAkun> {
  var username = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var cpasswordcontroller = TextEditingController();

  bool showpass = true;
  bool showpass2 = true;

  String selectIdWilayah;
  String selectWilayah;
  List categoryItem = List();
  Future getLokasi() async {
    var url = Api.lokasi;
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      setState(() {
        categoryItem = data;
      });
    }
    print(categoryItem);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailcontroller.addListener(() {
      setState(() {});
    });
    getLokasi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Center(
                    child: Container(
                      height: 740,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Center(
                                child: Image.asset(
                              'images/logo/logo2.jpg',
                              height: 150,
                            )),
                          ),
                          Text(
                            'Daftar Akun',
                            style: GoogleFonts.mulish(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Masukkan data anda di bawah ini',
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
                                      'NAMA PENGGUNA',
                                      style: GoogleFonts.mulish(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              getTextForm(
                                controller: username,
                                hintName: 'Masukan Nama Pengguna',
                                keyboardType: TextInputType.name,
                                inputFormatters: FilteringTextInputFormatter
                                    .singleLineFormatter,
                                length: 100,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
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
                                    controller: emailcontroller,
                                    style: GoogleFonts.mulish(fontSize: 13),
                                    keyboardType: TextInputType.name,
                                    enabled: true,
                                    onSaved: (val) => emailcontroller =
                                        val as TextEditingController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Your Email';
                                      }
                                      return null;
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .singleLineFormatter,
                                      LengthLimitingTextInputFormatter(100)
                                    ],
                                    decoration: InputDecoration(
                                      hintText: 'Masukan Email Anda',
                                      isDense: true,
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
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
                                      suffixIcon: emailcontroller.text.isEmpty
                                          ? null
                                          : EmailValidator.validate(
                                                  emailcontroller.text)
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
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'LOKASI TOKO',
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
                                  DropdownButtonFormField(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 20,
                                    ),
                                    isExpanded: true,
                                    borderRadius: BorderRadius.circular(15),
                                    elevation: 0,
                                    dropdownColor: whiteColor,
                                    style: GoogleFonts.poppins(
                                        fontSize: 13, color: blackColor),
                                    iconDisabledColor: blackColor,
                                    iconEnabledColor: blackColor,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 13),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xffF0F1F7),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xffF0F1F7),
                                              width: 1),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFFCFDFE)),
                                    hint: Text(
                                      'Pilih Lokasi Toko',
                                      style: GoogleFonts.poppins(fontSize: 13),
                                    ),
                                    value: selectWilayah,
                                    items: categoryItem.map((category) {
                                      return DropdownMenuItem(
                                          value: category['nama_wilayah'],
                                          child:
                                              Text(category['nama_wilayah']));
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectWilayah = value;
                                        selectIdWilayah = categoryItem
                                            .firstWhere((element) =>
                                                element['nama_wilayah'] ==
                                                value)['id_wilayah']
                                            .toString();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'KATA SANDI',
                                      style: GoogleFonts.mulish(fontSize: 12),
                                    ),
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
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
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
                            height: 15,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'KONFIRMASI KATA SANDI',
                                      style: GoogleFonts.mulish(fontSize: 12),
                                    ),
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
                                    obscureText: showpass2,
                                    controller: cpasswordcontroller,
                                    style: GoogleFonts.mulish(fontSize: 13),
                                    keyboardType: TextInputType.name,
                                    enabled: true,
                                    onSaved: (val) => cpasswordcontroller =
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
                                      hintText: 'Masukan Konfirmasi Kata Sandi',
                                      isDense: true,
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
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
                                          showpass2
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          size: 20,
                                          color: Color(0xFF5FD3D0),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            showpass2 = !showpass2;
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
                                  verifyDaftarAkun();
                                },
                                child: Text(
                                  'Daftar',
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
                                  "Sudah memiliki akun ? ",
                                  style: GoogleFonts.mulish(fontSize: 12),
                                ),
                                InkWell(
                                  child: Text(
                                    "Masuk",
                                    style: GoogleFonts.mulish(
                                        color: const Color(0xFF5FD3D0),
                                        fontSize: 13),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void valEmail() async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({"email_user": emailcontroller.text});
    try {
      var response = await dio.post(Api.valemail, data: formData);
      if (response.statusCode == 200) {
        var user = jsonDecode(response.data);
        if (user['status'] == true) {
          MySnackbar(
                  type: SnackbarType.error,
                  title:
                      "Email sudah digunakan, Silahkan menggunakan email yang lain")
              .showSnackbar(context);
        } else {
          daftarAkun();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void valUsername() async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({"username_user": username.text});
      var response = await dio.post(Api.valusername, data: formData);
      if (response.statusCode == 200) {
        var user = jsonDecode(response.data);
        if (user['status'] == true) {
          MySnackbar(
                  type: SnackbarType.error,
                  title:
                      "Nama pengguna sudah digunakan, Silahkan menggunakan nama pengguna yang lain")
              .showSnackbar(context);
        } else {
          valEmail();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void verifyDaftarAkun() {
    if (username.text.isEmpty) {
      MySnackbar(
              type: SnackbarType.error,
              title: "Nama pengguna tidak boleh kosong")
          .showSnackbar(context);
    } else if (emailcontroller.text.isEmpty) {
      MySnackbar(type: SnackbarType.error, title: "Email tidak boleh kosong")
          .showSnackbar(context);
    } else if (selectWilayah == null) {
      MySnackbar(
              type: SnackbarType.error, title: "Lokasi toko tidak boleh kosong")
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
    } else if (passwordcontroller.text.contains(RegExp(r'[A-Z]')) == false) {
      MySnackbar(
              type: SnackbarType.error,
              title: "Format kata sandi harus mengandung huruf kapital")
          .showSnackbar(context);
    } else if (passwordcontroller.text.contains(RegExp(r'[a-z]')) == false) {
      MySnackbar(
              type: SnackbarType.error,
              title: "Format kata sandi harus mengandung huruf kecil")
          .showSnackbar(context);
    } else if (passwordcontroller.text.contains(RegExp(r'\d')) == false) {
      MySnackbar(
              type: SnackbarType.error,
              title: "Format kata sandi harus mengandung huruf angka")
          .showSnackbar(context);
    } else if (passwordcontroller.text
            .contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]')) ==
        false) {
      MySnackbar(
              type: SnackbarType.error,
              title: "Format kata sandi harus mengandung spesial karakter")
          .showSnackbar(context);
    } else if (cpasswordcontroller.text.isEmpty) {
      MySnackbar(
              type: SnackbarType.error,
              title: "Konfirmasi kata sandi tidak boleh kosong")
          .showSnackbar(context);
    } else if (passwordcontroller.text != cpasswordcontroller.text) {
      MySnackbar(type: SnackbarType.error, title: "Kata sandi tidak sama")
          .showSnackbar(context);
    } else {
      valUsername();
    }
  }

  Future daftarAkun() async {
    var selectedWilayahData;
    categoryItem.forEach((category) {
      if (category['nama_wilayah'] == selectWilayah) {
        selectedWilayahData = category;
      }
    });

    try {
      var response = await http.post(Uri.parse(Api.daftarakun), body: {
        "id_user": generateAccountId(),
        "username_user": username.text,
        "email_user": emailcontroller.text,
        "password_user": passwordcontroller.text,
        "uid_wilayah": selectedWilayahData['id_wilayah']
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == false) {
          snackBarFailed();
        } else {
          setState(() {
            username.clear();
            passwordcontroller.clear();
            cpasswordcontroller.clear();
            emailcontroller.clear();
          });
          snackBarSucces();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    }
  }

  snackBarSucces() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
            title: "Berhasil",
            message: "Selamat, Pendaftaran akun anda berhasil",
            contentType: ContentType.success)));
  }

  snackBarFailed() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
            title: "Gagal",
            message: "Pendaftaran akun gagal",
            contentType: ContentType.failure)));
  }

  int counter = 0;

  String generateAccountId() {
    counter += 1;
    return "PT220921000$counter";
  }
}
