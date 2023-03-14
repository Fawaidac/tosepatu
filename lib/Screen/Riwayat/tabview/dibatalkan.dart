import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tosepatu/Api/Api_services.dart';
import 'package:tosepatu/Comm/getSnackbar.dart';
import 'package:tosepatu/Model/riwayatModel.dart';
import 'package:tosepatu/Shared/theme.dart';

class Dibatalkan extends StatefulWidget {
  const Dibatalkan({Key key}) : super(key: key);

  @override
  State<Dibatalkan> createState() => _DibatalkanState();
}

class _DibatalkanState extends State<Dibatalkan>
    with SingleTickerProviderStateMixin {
  ApiServices apiServices = ApiServices();
  Future<List<myRiwayat>> listdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getRiwayatStatus("Dibatalkan");
  }

  List<bool> _isVisible = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: appcolor2,
      onRefresh: () async {
        setState(() {
          listdata = apiServices.getRiwayat();
        });
      },
      child: FutureBuilder<List<myRiwayat>>(
        future: listdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<myRiwayat> isiData = snapshot.data;
            if (_isVisible.length == 0) {
              for (int i = 0; i < isiData.length; i++) {
                _isVisible.add(false);
              }
            }
            return ListView.builder(
              itemCount: isiData.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastOutSlowIn,
                  height: _isVisible[index] ? 225 : 175,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(10),
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tosepatu",
                                style: mulishStyleMedium.copyWith(
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                isiData[index].tanggalMasuk,
                                style: mulishStyleSmall.copyWith(
                                    color: Colors.grey.shade600),
                              )
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 100,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red.withOpacity(0.1)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.highlight_off_rounded,
                                      color: Colors.red),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    isiData[index].statusPesanan,
                                    style: mulishStyleSmall.copyWith(
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'images/logo/shoes.png',
                                              height: 35,
                                              width: 35,
                                              color: whiteColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: 200,
                                        child: Text(
                                          isiData[index].namaLayanan,
                                          textAlign: TextAlign.start,
                                          style: mulishStyleLarge.copyWith(
                                              fontSize: 14,
                                              color: blackColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total :',
                                  style: mulishStyleSmall.copyWith(
                                      color: Colors.grey.shade600),
                                ),
                                Text(
                                  'Rp.' + isiData[index].grandTotal,
                                  style: mulishStyleMedium.copyWith(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isVisible[index] = !_isVisible[index];
                                });
                              },
                              child: Icon(
                                _isVisible[index]
                                    ? Icons.keyboard_arrow_down_rounded
                                    : Icons.keyboard_arrow_right_rounded,
                                color: blackColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastOutSlowIn,
                        vsync: this,
                        child: Visibility(
                          visible: _isVisible[index],
                          child: SizedBox(
                            height: _isVisible[index] ? 40 : 0,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isiData[index].statusPesanan ==
                                                "Menunggu Konfirmasi"
                                            ? const Color(0xFF5FD3D0)
                                            : Colors.grey.shade300,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onPressed: () {
                                  // verifyLogin();
                                  if (isiData[index].statusPesanan ==
                                      "Menunggu Konfirmasi") {
                                    MySnackbar(
                                            type: SnackbarType.success,
                                            title:
                                                "Pesanan berhasil dibatalkan")
                                        .showSnackbar(context);
                                  } else {
                                    MySnackbar(
                                            type: SnackbarType.failed,
                                            title:
                                                "Pesanan tidak bisa dibatalkan ketika pesanan anda telah ${isiData[index].statusPesanan}")
                                        .showSnackbar(context);
                                  }
                                },
                                child: Text(
                                  'Batalkan pesanan',
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.white),
                                )),
                          ),
                        ),
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
      ),
    );
  }
}
