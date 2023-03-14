import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Api/Api_services.dart';
import 'package:tosepatu/Comm/getSnackbar.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/Model/keranjangModel.dart';
import 'package:tosepatu/Model/layananModel.dart';
import 'package:tosepatu/Model/metodePengiriman.dart';
import 'package:tosepatu/Model/productModel.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/Home.dart';
import 'package:tosepatu/Screen/Pesanan/pesanan.dart';
import 'package:tosepatu/Screen/Setting/profile.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:http/http.dart' as http;

class CheckOut extends StatefulWidget {
  const CheckOut({Key key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut>
    with SingleTickerProviderStateMixin {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  ApiServices apiServices = ApiServices();
  Future<List<myLayanan>> listdata;
  Future<List<myKeranjang>> listkeranjang;
  Future<List<myPengiriman>> listpengiriman;

  String selectPengiriman;
  List categoryItem = List();
  Future getPengiriman() async {
    var url = Api.pengiriman;
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
    listdata = apiServices.getLayanan(currentUser.user.idWilayah);
    listkeranjang = apiServices.getKeranjang();
    listpengiriman = apiServices.getPengiriman();
    getPengiriman();
    checkUser();
  }

  Future<bool> onBack() {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: "Warning!",
      titleTextStyle: mulishStyleLarge.copyWith(
          fontSize: 25, fontWeight: FontWeight.bold, color: appcolor2),
      desc: 'Apakah anda yakin, untuk membatalkan transaksi',
      descTextStyle: mulishStyleMedium.copyWith(color: Colors.grey),
      btnOkOnPress: () {
        Navigator.of(context).pop(true);
      },
      btnOkIcon: Icons.done,
      btnCancelIcon: Icons.close,
      btnCancelOnPress: () {
        Navigator.of(context).pop(false);
      },
    ).show();
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

  pesan() async {
    var response = await http.post(Uri.parse(Api.pesanan), body: {
      'uid_akun_user': currentUser.user.idUser,
      'uid_wilayah': currentUser.user.idWilayah,
      'catatan': catatan.text,
      'alamat': alamatc.text + detailalamat.text
    });
    if (response.statusCode == 200) {
      setState(() {
        listkeranjang = apiServices.getKeranjang();
      });
      // ignore: use_build_context_synchronously
      MySnackbar(
              type: SnackbarType.success,
              title:
                  "Pesanan anda berhasil dipesan silahkan tunggu konfirmasi dari admin")
          .showSnackbar(context);
    } else {
      print('GA');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBack,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolor2,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Checkout",
              style: mulishStyleLarge.copyWith(
                  color: whiteColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: bg,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      widgetLokasi(),
                      const SizedBox(
                        height: 10,
                      ),
                      widgetKeranjang(),
                      const SizedBox(
                        height: 10,
                      ),
                      widgetKupon(),
                      const SizedBox(
                        height: 10,
                      ),
                      widgetinfopelanggan(),
                      const SizedBox(
                        height: 10,
                      ),
                      widgetMetodepengiriman(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: blackColor,
          child: Container(
            height: 80,
            color: whiteColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Total Pembayaran",
                        style: mulishStyleMedium.copyWith(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      grandtotal == null
                          ? Container()
                          : Text(
                              'Rp.' + grandtotal,
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
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.WARNING,
                        title: "Warning!",
                        titleTextStyle: mulishStyleLarge.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: appcolor2),
                        desc: 'Apakah anda yakin',
                        descTextStyle:
                            mulishStyleMedium.copyWith(color: Colors.grey),
                        btnOkOnPress: () {
                          pesan();
                        },
                        btnOkIcon: Icons.done,
                        btnCancelIcon: Icons.close,
                        btnCancelOnPress: () {
                          Navigator.of(context).pop(true);
                        },
                      ).show();
                    },
                    child: Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Checkout",
                            textAlign: TextAlign.center,
                            style: mulishStyleLarge.copyWith(
                                color: whiteColor, fontWeight: FontWeight.bold),
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
      ),
    );
  }

  Container widgetLokasi() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 125,
      width: MediaQuery.of(context).size.width,
      color: whiteColor,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lokasi Toko",
                  style: mulishStyleMedium.copyWith(
                      color: blackColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFFCFDFE),
                border: Border.all(color: Color(0xffF0F1F7))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Image.asset(
                    'images/logo/store.png',
                    height: 25,
                  ),
                  title: Text(
                    _currentUser.user.namaWilayah,
                    style: mulishStyleMedium.copyWith(color: blackColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  updateqty(String qty, String idlayanan) async {
    var response = await http.post(Uri.parse(Api.updateqty), body: {
      'uid_akun_user': _currentUser.user.idUser,
      'qty': qty.toString(),
      'uid_layanan': idlayanan,
    });
    if (response.statusCode == 200) {
      print('OK');
      setState(() {
        checkUser();
      });
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
        listkeranjang = apiServices.getKeranjang();
        checkUser();
      });
    } else {
      print('GA');
    }
  }

  AnimatedContainer widgetKeranjang() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
      padding: const EdgeInsets.all(10),
      height: isVisible ? 400 : 275,
      width: MediaQuery.of(context).size.width,
      color: whiteColor,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Keranjang",
                  style: mulishStyleMedium.copyWith(
                      color: blackColor, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: Pesanan(),
                            type: PageTransitionType.rightToLeft));
                  },
                  child: Text(
                    "+ Tambah Produk",
                    style: mulishStyleSmall.copyWith(
                        color: appcolor2, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder<List<myKeranjang>>(
            future: listkeranjang,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<myKeranjang> isiData = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: isiData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            // margin: EdgeInsets.all(5),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
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
                  color: appColor,
                  size: 30,
                ),
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Text(
                    "+ Tambah Catatan",
                    style: mulishStyleSmall.copyWith(
                        color: appcolor2, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 1000),
            vsync: this,
            curve: Curves.fastOutSlowIn,
            child: Visibility(
              visible: isVisible == true,
              child: SizedBox(
                height: maxLines * 24.0,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: maxLines,
                      textInputAction: TextInputAction.done,
                      controller: catatan,
                      style: GoogleFonts.mulish(fontSize: 13),
                      keyboardType: TextInputType.name,
                      enabled: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                        LengthLimitingTextInputFormatter(255)
                      ],
                      decoration: InputDecoration(
                        hintText: 'Masukan Alamat Anda',
                        isDense: true,
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
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
                        fillColor: Color(0xFFFCFDFE),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isVisible = false;

  Container widgetKupon() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 134,
      width: MediaQuery.of(context).size.width,
      color: whiteColor,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kupon",
                  style: mulishStyleMedium.copyWith(
                      color: blackColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.confirmation_num_outlined,
                    color: blackColor,
                  ),
                  title: Text(
                    "Tambah Kupon Promo",
                    style: mulishStyleMedium.copyWith(color: blackColor),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final alamatc = TextEditingController();
  final detailalamat = TextEditingController();
  final catatan = TextEditingController();
  final maxLines = 5;
  Container widgetinfopelanggan() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 510,
      width: MediaQuery.of(context).size.width,
      color: whiteColor,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Info Pelanggan",
                  style: mulishStyleMedium.copyWith(
                      color: blackColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                child: Row(
                  children: [
                    Text(
                      "Nama",
                      style: mulishStyleMedium.copyWith(
                          fontWeight: FontWeight.w500, color: blackColor),
                    ),
                    Text(
                      "*",
                      style: mulishStyleMedium.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.red),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: back1,
                    border: Border.all(color: lineback1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.account_box,
                        color: blackColor,
                      ),
                      title: Text(
                        _currentUser.user.usernameUser,
                        style: mulishStyleMedium.copyWith(color: blackColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                child: Row(
                  children: [
                    Text(
                      "No.WhatsApp",
                      style: mulishStyleMedium.copyWith(
                          fontWeight: FontWeight.w500, color: blackColor),
                    ),
                    Text(
                      "*",
                      style: mulishStyleMedium.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.red),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: back1,
                    border: Border.all(color: lineback1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.phone_rounded,
                        color: blackColor,
                      ),
                      title: Text(
                        _currentUser.user.noTelpUser,
                        style: mulishStyleMedium.copyWith(color: blackColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                child: Row(
                  children: [
                    Text(
                      "Alamat",
                      style: mulishStyleMedium.copyWith(
                          fontWeight: FontWeight.w500, color: blackColor),
                    ),
                    Text(
                      "*",
                      style: mulishStyleMedium.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: maxLines * 24.0,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: maxLines,
                      textInputAction: TextInputAction.done,
                      controller: alamatc,
                      style: GoogleFonts.mulish(fontSize: 13),
                      keyboardType: TextInputType.name,
                      enabled: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                        LengthLimitingTextInputFormatter(255)
                      ],
                      decoration: InputDecoration(
                        hintText: 'Masukan Alamat Anda',
                        isDense: true,
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
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
                        fillColor: Color(0xFFFCFDFE),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: detailalamat,
                style: GoogleFonts.mulish(fontSize: 13),
                keyboardType: TextInputType.name,
                enabled: true,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                  LengthLimitingTextInputFormatter(255)
                ],
                decoration: InputDecoration(
                  hintText: 'Detail Alamat Lainnya (Cth:Blok/Unit No/Patokan)',
                  isDense: true,
                  hintStyle: GoogleFonts.poppins(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xffF0F1F7), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xffF0F1F7), width: 1),
                  ),
                  filled: true,
                  fillColor: Color(0xFFFCFDFE),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Spacer(),
                  SizedBox(
                    height: 48,
                    width: 150,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5FD3D0),
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () async {
                          setState(() {
                            isWaiting = true;
                          });
                          Position position = await _getGeoLocationPosition();
                          getAddressFromLongLat(position);
                          setState(() {
                            isWaiting = false;
                          });
                        },
                        child: isWaiting
                            ? SpinKitFadingCircle(
                                size: 25,
                                color: whiteColor,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: whiteColor,
                                    size: 20,
                                  ),
                                  Text(
                                    'Temukan alamat',
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ],
                              )),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Container widgetMetodepengiriman() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 185,
      width: MediaQuery.of(context).size.width,
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Metode Pengambilan",
                  style: mulishStyleMedium.copyWith(
                      color: blackColor, fontWeight: FontWeight.bold),
                ),
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16))),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(20, 30, 10, 10),
                              height: 260,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Daftar Metode Pengambilan : ",
                                    style: mulishStyleMedium.copyWith(
                                        color: blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Expanded(
                                      child: FutureBuilder<List<myPengiriman>>(
                                    future: listpengiriman,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<myPengiriman> isiData =
                                            snapshot.data;
                                        return ListView.builder(
                                          itemCount: isiData.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    isiData[index]
                                                        .namaPengiriman,
                                                    style: mulishStyleMedium
                                                        .copyWith(
                                                            color: blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    isiData[index]
                                                        .descriptionPengiriman,
                                                    style: mulishStyleMedium
                                                        .copyWith(
                                                            color: blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                                          color: appColor,
                                          size: 30,
                                        ),
                                      );
                                    },
                                  ))
                                ],
                              ),
                            );
                          });
                    },
                    child: Icon(
                      Icons.info_outline_rounded,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kamu dapat ubah metode pengambilan",
                style: mulishStyleMedium.copyWith(
                    color: blackColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
            ),
            isExpanded: true,
            borderRadius: BorderRadius.circular(15),
            elevation: 0,
            dropdownColor: whiteColor,
            style: GoogleFonts.poppins(fontSize: 13, color: blackColor),
            iconDisabledColor: blackColor,
            iconEnabledColor: blackColor,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.directions_car,
                  color: blackColor,
                ),
                isDense: true,
                hintStyle: GoogleFonts.poppins(fontSize: 13),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xffF0F1F7), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xffF0F1F7), width: 1),
                ),
                filled: true,
                fillColor: Color(0xFFFCFDFE)),
            hint: Text(
              'Pilih metode pengambilan',
              style: GoogleFonts.poppins(fontSize: 13),
            ),
            value: selectPengiriman,
            items: categoryItem.map((category) {
              return DropdownMenuItem(
                  value: category['nama_pengiriman'],
                  child: Text(category['nama_pengiriman']));
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectPengiriman = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Spacer(),
          Text(
            "Nb: Khusus untuk metode pengambilan Pick Up dan COD terdapat biaya tambahan",
            style: GoogleFonts.mulish(fontSize: 12),
          )
        ],
      ),
    );
  }

  String address;
  String location;
  bool isWaiting = false;
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
      alamatc.text = address;
    });
  }
}
