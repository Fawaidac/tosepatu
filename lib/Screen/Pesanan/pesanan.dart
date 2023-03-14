import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Api/Api_services.dart';
import 'package:tosepatu/Comm/getSnackbar.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/Model/keranjangModel.dart';
import 'package:tosepatu/Model/layananModel.dart';
import 'package:tosepatu/Screen/Pesanan/keranjang.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:http/http.dart' as http;

class Pesanan extends StatefulWidget {
  const Pesanan({Key key}) : super(key: key);

  @override
  State<Pesanan> createState() => _PesananState();
}

class _PesananState extends State<Pesanan> {
  ApiServices apiServices = ApiServices();
  Future<List<myKeranjang>> list;
  Future<List<myLayanan>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = apiServices.getKeranjang();
    listdata = apiServices.getLayanan(currentUser.user.idWilayah);
  }

  final CurrentUser currentUser = CurrentUser();

  cekKeranjang(String idLayanan, String uid, String harga) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        "uid_akun_user": currentUser.user.idUser,
        "uid_layanan": idLayanan,
      });
      var response = await dio.post(Api.cekkeranjang, data: formData);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        if (data['status'] == true) {
          // ignore: use_build_context_synchronously
          MySnackbar(
                  type: SnackbarType.error,
                  title: "Produk sudah ditambahkan dikeranjang")
              .showSnackbar(context);
        } else {
          tambahkeranjang(uid, harga);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  tambahkeranjang(String idlayanan, String hargalayanan) async {
    var response = await http.post(Uri.parse(Api.tambahkeranjang), body: {
      'uid_akun_user': currentUser.user.idUser,
      'uid_layanan': idlayanan,
      'qty': "1",
      'harga_layanan': hargalayanan
    });
    if (response.statusCode == 200) {
      setState(() {
        list = apiServices.getKeranjang();
      });
      // ignore: use_build_context_synchronously
      MySnackbar(
              type: SnackbarType.success,
              title: "Berhasil menambahkan ke keranjang")
          .showSnackbar(context);
    } else {
      print('GA');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appcolor2,
        shadowColor: appcolor2,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pesanan',
          style: GoogleFonts.mulish(
              fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: whiteColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: Keranjang(), type: PageTransitionType.fade));
                  },
                ),
                FutureBuilder<List<myKeranjang>>(
                  future: list,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int itemCount = snapshot.data.length;
                      return Positioned(
                        right: 0,
                        top: 0,
                        child: Stack(
                          children: [
                            const Icon(
                              Icons.brightness_1,
                              size: 20,
                              color: Colors.red,
                            ),
                            Positioned(
                              top: 3,
                              right: 0,
                              left: 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    itemCount.toString(),
                                    textAlign: TextAlign.center,
                                    style: mulishStyleSmall.copyWith(
                                        fontSize: 11, color: whiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: appcolor2,
                          size: 30,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
      body: Scrollbar(
        thickness: 5,
        interactive: true,
        hoverThickness: 5,
        showTrackOnHover: true,
        radius: const Radius.circular(5),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Daftar Layanan : ",
                          style: GoogleFonts.mulish(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: blackColor,
                    height: 10,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: FutureBuilder<List<myLayanan>>(
                        future: listdata,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<myLayanan> isiData = snapshot.data;
                            return GridView.builder(
                              itemCount: isiData.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 250),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       blurRadius: 8,
                                    //       spreadRadius: 1,
                                    //       color: appcolor2.withOpacity(0.1),
                                    //       offset: Offset(1.0, 1.0))
                                    // ],
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 125,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          child: Image.network(
                                            Api.imageproduct +
                                                isiData[index].fotoLayanan,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          isiData[index].namaLayanan,
                                          style: mulishStyleMedium.copyWith(
                                              fontSize: 15,
                                              color: blackColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "Rp." +
                                                  isiData[index]
                                                      .hargaLayanan
                                                      .toString(),
                                              style: mulishStyleMedium.copyWith(
                                                  fontSize: 14,
                                                  color: blackColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (currentUser.user.noTelpUser ==
                                                      '' &&
                                                  currentUser.user.emailUser ==
                                                      '' &&
                                                  currentUser
                                                          .user.usernameUser ==
                                                      '') {
                                                MySnackbar(
                                                        type:
                                                            SnackbarType.error,
                                                        title:
                                                            "Silahkan lengkapi data akun anda terlebih dahulu")
                                                    .showSnackbar(context);
                                              } else {
                                                cekKeranjang(
                                                    isiData[index].idLayanan,
                                                    isiData[index].idLayanan,
                                                    isiData[index]
                                                        .hargaLayanan
                                                        .toString());
                                              }
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    appcolor2.withOpacity(0.1),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.shopping_cart,
                                                    color: appcolor2,
                                                    size: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.data}");
                          }
                          return Center(
                            child: SpinKitFadingCircle(
                              color: appcolor2,
                              size: 30,
                            ),
                          );
                        },
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
