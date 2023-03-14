import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Api/Api_services.dart';
import 'package:tosepatu/Comm/getSnackbar.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/Model/keranjangModel.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/Home.dart';
import 'package:tosepatu/Screen/Pesanan/checkout.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:http/http.dart' as http;

class Keranjang extends StatefulWidget {
  const Keranjang({Key key}) : super(key: key);

  @override
  State<Keranjang> createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  ApiServices apiServices = ApiServices();
  Future<List<myKeranjang>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getKeranjang();
    checkUser();
  }

  final CurrentUser _currentUser = Get.put(CurrentUser());
  updateqty(String qty, String idlayanan) async {
    var response = await http.post(Uri.parse(Api.updateqty), body: {
      'uid_akun_user': _currentUser.user.idUser,
      'qty': qty.toString(),
      'uid_layanan': idlayanan,
    });
    if (response.statusCode == 200) {
      setState(() {
        checkUser();
      });
      print('OK');
    } else {
      print('GA');
    }
  }

  deleteproduct(String idkeranjang) async {
    var response = await http.post(Uri.parse(Api.delete), body: {
      'id_keranjang': idkeranjang,
    });
    if (response.statusCode == 200) {
      MySnackbar(type: SnackbarType.success, title: "Berhasil menghapus barang")
          .showSnackbar(context);
      setState(() {
        listdata = apiServices.getKeranjang();
      });
    } else {
      print('GA');
    }
  }

  String grandtotal;

  Future checkUser() async {
    var res = await http.post(Uri.parse(Api.grandtotal), body: {
      "uid_akun_user": _currentUser.user.idUser,
    });
    if (res.statusCode == 200) {
      var link = json.decode(res.body);
      setState(() {
        grandtotal = link['grandtotal'].toString();
      });
      print(grandtotal);
    }
  }

  NumberFormat formatter = NumberFormat('0');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        backgroundColor: appcolor2,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                setState(() {
                  listdata = apiServices.getKeranjang();
                });
              });
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              color: whiteColor,
            ),
          ),
        ),
        title: Text(
          "Keranjang",
          style: mulishStyleLarge.copyWith(
              fontSize: 17, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              color: whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Harga",
                          style: mulishStyleMedium.copyWith(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        grandtotal == null
                            ? Container()
                            : Text(
                                "Rp. " + grandtotal,
                                style: mulishStyleMedium.copyWith(
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              )
                      ],
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Expanded(
                        child: GestureDetector(
                      onTap: () {
                        if (_currentUser.user.verifiedUser == '0') {
                          MySnackbar(
                                  type: SnackbarType.failed,
                                  title:
                                      "Silahkan verifikasi email anda terlebih dahulu")
                              .showSnackbar(context);
                        } else {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: CheckOut(),
                                  type: PageTransitionType.fade));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Lanjut",
                              textAlign: TextAlign.center,
                              style: mulishStyleLarge.copyWith(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
          FutureBuilder<List<myKeranjang>>(
            future: listdata,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<myKeranjang> isiData = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: isiData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            width: 90,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(Api.imageproduct +
                                        isiData[index].fotoLayanan),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 135,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 0, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isiData[index].namaLayanan,
                                    style: mulishStyleMedium.copyWith(
                                        color: blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Rp.${isiData[index].hargaLayanan}",
                                    style: mulishStyleMedium.copyWith(
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      deleteproduct(isiData[index].idKeranjang);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.grey.shade900,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (isiData[index].qty > 1) {
                                      setState(() {
                                        isiData[index].qty--;
                                        updateqty(isiData[index].qty.toString(),
                                            isiData[index].uidLayanan);
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  isiData[index].qty.toString(),
                                  style: mulishStyleMedium.copyWith(
                                      color: blackColor),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isiData[index].qty++;
                                      updateqty(isiData[index].qty.toString(),
                                          isiData[index].uidLayanan);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_rounded,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          )
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
          )
        ],
      ),
    );
  }
}
