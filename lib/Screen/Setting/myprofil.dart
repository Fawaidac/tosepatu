import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Comm/getSnackbar.dart';
import 'package:tosepatu/Comm/getTextFielduser.dart';
import 'package:tosepatu/Comm/getTextForm.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/CurrentUser/RememberUser.dart';
import 'package:tosepatu/HomePage/homePage.dart';
import 'package:tosepatu/Model/userModel.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:http/http.dart' as http;
import 'package:tosepatu/login.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var nama = TextEditingController();
  var email = TextEditingController();
  var nohp = TextEditingController();

  CurrentUser currentUser = CurrentUser();
  bool ename = true;
  bool eemail = true;
  bool enohp = true;
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

  int _currentImage = 0;
  int _currentImageIndex = 0;

  void _changeProfilePicture() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % 2;
    });
  }

  List<String> images = [
    "images/logo/user3.png",
    "images/logo/man1.png",
    "images/logo/man2.png",
    "images/logo/man3.png",
    "images/logo/man4.png",
    "images/logo/man5.png",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nama.text = currentUser.user.usernameUser;
    email.text = currentUser.user.emailUser;
    nohp.text = currentUser.user.noTelpUser;
    selectWilayah = currentUser.user.namaWilayah;
    getLokasi();
  }

  deleteproduct() async {
    var response = await http.post(Uri.parse(Api.deleteaa), body: {
      'uid_akun_user': currentUser.user.idUser,
    });
    if (response.statusCode == 200) {
      print('ok');
    } else {
      print('GA');
    }
  }

  showDialog() {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: "Warning!",
      titleTextStyle: mulishStyleLarge.copyWith(
          fontSize: 25, fontWeight: FontWeight.bold, color: appcolor2),
      desc: 'Apakah anda yakin, untuk memperbarui data anda',
      descTextStyle: mulishStyleMedium.copyWith(color: Colors.grey),
      btnOkOnPress: () async {
        if (ename == false &&
            eemail == false &&
            enohp == false &&
            nama.text.isNotEmpty &&
            email.text.isNotEmpty &&
            selectWilayah != null &&
            nohp.text.isNotEmpty) {
          var selectedWilayahData;
          categoryItem.forEach((category) {
            if (category['nama_wilayah'] == selectWilayah) {
              selectedWilayahData = category;
            }
          });
          try {
            var uri = Api.editprofil;
            var res = await http.post(Uri.parse(uri), body: {
              "id_user": currentUser.user.idUser,
              "username_user": nama.text,
              "email_user": email.text,
              "no_tlp_user": nohp.text,
              "uid_wilayah": selectedWilayahData['id_wilayah'],
            });
            if (res.statusCode == 200) {
              final user = jsonDecode(res.body);
              if (user["success"] == true) {
                snackBarSucces();

                User userInfo = User.fromJson(user['user']);
                await RememberUser().storeUser(json.encode(userInfo));
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const HomePage(),
                        type: PageTransitionType.fade));
                setState(() async {
                  ename = true;
                  eemail = true;
                  enohp = true;
                  currentUser.getUserInfo();
                  deleteproduct();
                });
              } else {
                setState(() async {
                  ename = true;
                  eemail = true;
                  enohp = true;
                });
                snackBarFailed();
              }
            }
          } catch (e) {
            print(e.toString());
          }
        } else {
          snackBarFailed();
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const HomePage(), type: PageTransitionType.fade));
        }
      },
      btnOkIcon: Icons.done,
      btnCancelIcon: Icons.close,
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }

  snackBarSucces() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
            title: "Berhasil",
            message: "Selamat, Data anda berhasil diperbarui",
            contentType: ContentType.success)));
  }

  snackBarFailed() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
            title: "Gagal",
            message: "Data anda gagal diperbarui",
            contentType: ContentType.failure)));
  }

  logOut() {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: "Warning!",
      titleTextStyle: mulishStyleLarge.copyWith(
          fontSize: 25, fontWeight: FontWeight.bold, color: appcolor2),
      desc: 'Apakah anda yakin, untuk logout?',
      descTextStyle: mulishStyleMedium.copyWith(color: Colors.grey),
      btnOkOnPress: () async {
        RememberUser.removeUserSessions()
            .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                )));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            content: AwesomeSnackbarContent(
                title: "Berhasil",
                message: "Selamat, Anda Berhasil Keluar",
                contentType: ContentType.success)));
      },
      btnOkIcon: Icons.done,
      btnCancelIcon: Icons.close,
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nama.dispose();
    email.dispose();
    nohp.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Profil',
          style: GoogleFonts.mulish(
              fontSize: 18, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
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
                            height: 113,
                            width: 113,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'images/logo/man$_currentImageIndex.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xff00E0FF),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  _changeProfilePicture();
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: whiteColor,
                                  ),
                                  child: Icon(
                                    Icons.mode_edit_outline_rounded,
                                    color: appcolor2,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
                  child: GetTextFieldUser(
                    controller: nama,
                    hintName: "Masukan username anda",
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                    length: 100,
                    icon: Icons.person_rounded,
                    isEnable: ename,
                    label: "Username",
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                  child: GetTextFieldUser(
                    controller: email,
                    hintName: "Masukan email anda",
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                    length: 100,
                    icon: Icons.mail,
                    isEnable: eemail,
                    label: "E-mail",
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                  child: GetTextFieldUser(
                    controller: nohp,
                    hintName: "Masukan No.WhatApp anda",
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                    length: 100,
                    icon: Icons.phone,
                    isEnable: enohp,
                    label: "No.WhatApp",
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Text(
                            "Lokasi Toko",
                            style: GoogleFonts.mulish(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DropdownButtonFormField(
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                      ),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 0,
                      dropdownColor: bg,
                      style:
                          GoogleFonts.mulish(fontSize: 13, color: blackColor),
                      iconDisabledColor: Colors.grey,
                      iconEnabledColor: Colors.grey,
                      decoration: InputDecoration(
                          isDense: false,
                          hintStyle: GoogleFonts.mulish(fontSize: 13),
                          prefixIcon: Icon(
                            Icons.storefront,
                            size: 20,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Color(0xFFFCFDFE)),
                      // hint: Text(
                      //   'Pilih Lokasi Toko',
                      //   style: GoogleFonts.poppins(fontSize: 13),
                      // ),
                      value: selectWilayah,
                      items: categoryItem.map((category) {
                        return DropdownMenuItem(
                            value: category['nama_wilayah'],
                            child: Text(category['nama_wilayah']));
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
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: appcolor2,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () {
                        setState(() {
                          ename = false;
                          eemail = false;
                          enohp = false;
                        });
                        showDialog();
                      },
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  logOut();
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: appcolor2),
                      color: appcolor2.withOpacity(0.1)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20,
                          color: appcolor2,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Keluar",
                          textAlign: TextAlign.center,
                          style: mulishStyleMedium.copyWith(color: appcolor2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Versi Aplikasi 1.2.1",
                      style: GoogleFonts.mulish(
                          fontSize: 12, color: Colors.grey.withOpacity(0.5)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
