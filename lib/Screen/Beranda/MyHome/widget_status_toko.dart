import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Api/Api_services.dart';
import 'package:tosepatu/Model/jadwalModel.dart';
import 'package:tosepatu/Model/jamOperasionalModel.dart';
import 'package:tosepatu/Screen/Setting/profile.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:http/http.dart' as http;

class WidgetStatusToko extends StatefulWidget {
  WidgetStatusToko({Key key}) : super(key: key);

  @override
  State<WidgetStatusToko> createState() => _WidgetStatusTokoState();
}

class _WidgetStatusTokoState extends State<WidgetStatusToko> {
  ApiServices apiServices = ApiServices();
  Future<List<myJadwal>> listdata;

  String selectedValue;
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

  // final hariIni = DateFormat.E().format(DateTime.now());
  final int jamBuka = 9;
  final int jamTutup = 21;
  // final hariIni = [
  //   "Minggu",
  //   "Senin",
  //   "Selasa",
  //   "Rabu",
  //   "Kamis",
  //   "Jum'at",
  //   "Sabtu"
  // ][DateTime.now().weekday];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLokasi();
    listdata = apiServices.getJamOperasional(currentUser.user.idWilayah);
  }

  Future<List<myJamOperasional>> getJamOperasional() async {
    final response = await http.post(Uri.parse(Api.jamoperasional), body: {
      "id_wilayah": selectedValue,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => myJamOperasional.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sekarang = DateTime.now();
    var jamSekarang = sekarang.hour;
    if (jamSekarang >= jamBuka && jamSekarang < jamTutup) {
      return Container(
        height: 60,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.green.withOpacity(0.2),
            border: Border.all(width: 1, color: Colors.green)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        content: SizedBox(
                          height: 560,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/logo/logo.png",
                                height: 100,
                              ),
                              Text(
                                "Jadwal Toko Buka",
                                style: mulishStyleMedium.copyWith(
                                    color: blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              // Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  // getjadwal(hariIni == "Mon", context,
                                  //     "Senin : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Tue", context,
                                  //     "Selasa : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Wed", context,
                                  //     "Rabu : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Thu", context,
                                  //     "Kamis : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Fri", context,
                                  //     "Jumat : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Sat", context,
                                  //     "Sabtu : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Sun", context,
                                  //     "Minggu : 09.00 - 21.00"),
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                );
              },
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/cover/open.png',
                    height: 25,
                  ),
                ],
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Toko telah buka, Klik untuk melihat jam operasinal toko",
                      style: mulishStyleSmall.copyWith(
                          color: blackColor, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 60,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.red.withOpacity(0.2),
            border: Border.all(width: 1, color: Colors.red)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "images/logo/logo.png",
                              height: 100,
                            ),
                            Text(
                              "Jadwal Toko Buka",
                              style: mulishStyleMedium.copyWith(
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10, left: 10),
                            //   child: Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: SizedBox(
                            //       height: 50,
                            //       width: 150,
                            //       child: Column(
                            //         children: [
                            //           DropdownButton(
                            //             icon: const Icon(
                            //               Icons.keyboard_arrow_down_rounded,
                            //               size: 20,
                            //             ),
                            //             isExpanded: true,
                            //             borderRadius: BorderRadius.circular(15),
                            //             elevation: 0,
                            //             dropdownColor: whiteColor,
                            //             style: mulishStyleMedium.copyWith(
                            //                 color: blackColor,
                            //                 fontSize: 14,
                            //                 fontWeight: FontWeight.w500),
                            //             iconDisabledColor: blackColor,
                            //             iconEnabledColor: blackColor,
                            //             underline: Container(
                            //               height: 0,
                            //             ),
                            //             hint: Text(
                            //               'Pilih Lokasi Anda',
                            //               style: mulishStyleMedium.copyWith(
                            //                   color: blackColor,
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.w500),
                            //             ),
                            //             value: selectedValue,
                            //             items: categoryItem.map((category) {
                            //               return DropdownMenuItem(
                            //                   value: category['nama_wilayah'],
                            //                   child: Text(
                            //                       category['nama_wilayah']));
                            //             }).toList(),
                            //             onChanged: (value) {
                            //               setState(() {
                            //                 selectedValue = value;
                            //                 if (selectedValue != null &&
                            //                     categoryItem != null &&
                            //                     categoryItem.length > 0) {
                            //                   getJamOperasional();
                            //                 }
                            //               });
                            //             },
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Divider(),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            SizedBox(
                              height: 450,
                              child: Column(
                                children: [
                                  getjambuka(),
                                  // getjadwal(hariIni == "Mon", context,
                                  //     "Senin : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Tue", context,
                                  //     "Selasa : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Wed", context,
                                  //     "Rabu : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Thu", context,
                                  //     "Kamis : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Fri", context,
                                  //     "Jumat : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Sat", context,
                                  //     "Sabtu : 09.00 - 21.00"),
                                  // getjadwal(hariIni == "Sun", context,
                                  //     "Minggu : 09.00 - 21.00"),
                                ],
                              ),
                            )
                          ],
                        ));
                  },
                );
              },
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/cover/closed.png',
                    height: 25,
                  ),
                ],
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Toko tutup sementara, Kamu dapat melakukan order ketika toko telah buka",
                      style: mulishStyleSmall.copyWith(
                          color: blackColor, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Container getjadwal(bool isToday, context, String title) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isToday ? darkBlue.withOpacity(0.1) : whiteColor),
      child: Center(
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: darkBlue.withOpacity(0.1),
            ),
            child: Icon(
              Icons.timer_outlined,
              color: darkBlue,
            ),
          ),
          title: Text(title,
              style: mulishStyleMedium.copyWith(
                  color: blackColor, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }

  FutureBuilder getjambuka() {
    return FutureBuilder<List<myJadwal>>(
      future: listdata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<myJadwal> isiData = snapshot.data;
          return SizedBox(
            height: 450,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: isiData.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 72,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: whiteColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: darkBlue.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.timer_outlined,
                              color: darkBlue,
                            ),
                          ),
                        ),
                        title: Text("${isiData[index].hari} :",
                            style: mulishStyleMedium.copyWith(
                                fontSize: 13,
                                color: blackColor,
                                fontWeight: FontWeight.w600)),
                        subtitle: Text(
                            "${isiData[index].jamBuka} - ${isiData[index].jamTutup}",
                            style: mulishStyleMedium.copyWith(
                                fontSize: 13,
                                color: blackColor,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.data}");
        }
        return Center(
          child: SpinKitFadingCircle(
            color: darkBlue,
            size: 30,
          ),
        );
      },
    );
  }
}
// hariIni == isiData[index].hari
//                           ? darkBlue.withOpacity(0.1)
//                           :