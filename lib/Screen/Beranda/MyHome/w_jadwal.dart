import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tosepatu/Api/Api_services.dart';
import 'package:tosepatu/Model/jadwalModel.dart';
import 'package:tosepatu/Screen/Setting/profile.dart';
import 'package:tosepatu/Shared/theme.dart';

class JadwalToko extends StatefulWidget {
  const JadwalToko({Key key}) : super(key: key);

  @override
  State<JadwalToko> createState() => _JadwalTokoState();
}

class _JadwalTokoState extends State<JadwalToko> {
  ApiServices apiServices = ApiServices();
  Future<List<myJadwal>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (currentUser.user.idWilayah != '') {
      listdata = apiServices.getJamOperasional(currentUser.user.idWilayah);
    } else {
      currentUser.getUserInfo().then((value) {
        setState(() {
          listdata = apiServices.getJamOperasional(currentUser.user.idWilayah);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List<myJadwal>>(
      future: listdata,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          List<myJadwal> item = snapshot.data;
          var now = DateTime.now();
          var jamBuka = item[0].jamBuka;
          var jamTutup = item[0].jamTutup;
          // if (now.hour < int.parse(jamBuka[0]) ||
          //     now.hour >= int.parse(jamTutup[0])) {
          return Container(
            height: 60,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: item[0].statusToko == '1'
                  ? Colors.green.withOpacity(0.2)
                  : Color(0xfffde5a7),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: item[0].statusToko == '1'
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
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
                                        FutureBuilder<List<myJadwal>>(
                                          future: listdata,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<myJadwal> isiData =
                                                  snapshot.data;
                                              return Flexible(
                                                fit: FlexFit.loose,
                                                // height: 450,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: isiData.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DateTime now =
                                                        DateTime.now();
                                                    int hariSekarang =
                                                        now.weekday;
                                                    Color warnaHariSekarang;
                                                    if (isiData[index].hari ==
                                                            "Minggu" &&
                                                        hariSekarang == 7) {
                                                      warnaHariSekarang =
                                                          Colors.grey.shade200;
                                                    } else if (isiData[index]
                                                                .hari ==
                                                            "Senin" &&
                                                        hariSekarang == 1) {
                                                      warnaHariSekarang =
                                                          Colors.grey.shade200;
                                                    } else if (isiData[index]
                                                                .hari ==
                                                            "Selasa" &&
                                                        hariSekarang == 2) {
                                                      warnaHariSekarang =
                                                          Colors.grey.shade200;
                                                    } else if (isiData[index]
                                                                .hari ==
                                                            "Rabu" &&
                                                        hariSekarang == 3) {
                                                      warnaHariSekarang =
                                                          Colors.grey.shade200;
                                                    } else if (isiData[index]
                                                                .hari ==
                                                            "Kamis" &&
                                                        hariSekarang == 4) {
                                                      warnaHariSekarang =
                                                          Colors.grey.shade200;
                                                    } else if (isiData[index]
                                                                .hari ==
                                                            "Jum'at" &&
                                                        hariSekarang == 5) {
                                                      warnaHariSekarang =
                                                          Colors.grey.shade200;
                                                    } else if (isiData[index]
                                                                .hari ==
                                                            "Sabtu" &&
                                                        hariSekarang == 6) {
                                                      warnaHariSekarang =
                                                          Colors.grey.shade200;
                                                    } else {
                                                      warnaHariSekarang =
                                                          whiteColor;
                                                    }

                                                    return Container(
                                                      height: 72,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color:
                                                              warnaHariSekarang),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ListTile(
                                                            leading: Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                color: appcolor2
                                                                    .withOpacity(
                                                                        0.1),
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .timer_outlined,
                                                                  color:
                                                                      appcolor2,
                                                                ),
                                                              ),
                                                            ),
                                                            title: Text(
                                                                "${isiData[index].hari} :",
                                                                style: mulishStyleMedium.copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    color:
                                                                        blackColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                            subtitle: Text(
                                                                "${isiData[index].jamBuka} - ${isiData[index].jamTutup}",
                                                                style: mulishStyleMedium.copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    color:
                                                                        blackColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
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
                                                color: appcolor2,
                                                size: 30,
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          );
                        }
                      : null,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item[0].statusToko == '1'
                            ? 'images/logo/store.png'
                            : 'images/cover/closed.png',
                        height: 25,
                      ),
                    ],
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          item[0].statusToko == '1'
                              ? "Tap untuk melihat jam operasional toko"
                              : "Toko tutup sementara anda dapat melakukan order saat kami buka",
                          style: mulishStyleSmall.copyWith(
                              color: blackColor, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          );

          // return Container(
          //   height: 60,
          //   width: size.width,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(2),
          //       color: Colors.green.withOpacity(0.2),
          //       border: Border.all(width: 1, color: Colors.green)),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ListTile(
          //         onTap: item[0].statusToko == '1'
          //             ? () {
          //                 showDialog(
          //                   context: context,
          //                   builder: (context) {
          //                     return AlertDialog(
          //                         shape: RoundedRectangleBorder(
          //                             borderRadius:
          //                                 BorderRadius.circular(20)),
          //                         content: Column(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.start,
          //                           children: [
          //                             Image.asset(
          //                               "images/logo/logo.png",
          //                               height: 100,
          //                             ),
          //                             Text(
          //                               "Jadwal Toko Buka",
          //                               style: mulishStyleMedium.copyWith(
          //                                   color: blackColor,
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 16),
          //                             ),
          //                             // Divider(),
          //                             const SizedBox(
          //                               height: 10,
          //                             ),
          //                             SizedBox(
          //                               height: 500,
          //                               child: Column(
          //                                 children: [
          //                                   FutureBuilder<List<myJadwal>>(
          //                                     future: listdata,
          //                                     builder: (context, snapshot) {
          //                                       if (snapshot.hasData) {
          //                                         List<myJadwal> isiData =
          //                                             snapshot.data;
          //                                         return SizedBox(
          //                                           height: 450,
          //                                           child: ListView.builder(
          //                                             scrollDirection:
          //                                                 Axis.vertical,
          //                                             itemCount:
          //                                                 isiData.length,
          //                                             itemBuilder:
          //                                                 (context, index) {
          //                                               DateTime now =
          //                                                   DateTime.now();
          //                                               int hariSekarang =
          //                                                   now.weekday;
          //                                               Color
          //                                                   warnaHariSekarang;
          //                                               if (isiData[index]
          //                                                           .hari ==
          //                                                       "Minggu" &&
          //                                                   hariSekarang ==
          //                                                       7) {
          //                                                 warnaHariSekarang =
          //                                                     Colors.grey
          //                                                         .shade200;
          //                                               } else if (isiData[
          //                                                               index]
          //                                                           .hari ==
          //                                                       "Senin" &&
          //                                                   hariSekarang ==
          //                                                       1) {
          //                                                 warnaHariSekarang =
          //                                                     Colors.grey
          //                                                         .shade200;
          //                                               } else if (isiData[
          //                                                               index]
          //                                                           .hari ==
          //                                                       "Selasa" &&
          //                                                   hariSekarang ==
          //                                                       2) {
          //                                                 warnaHariSekarang =
          //                                                     Colors.grey
          //                                                         .shade200;
          //                                               } else if (isiData[
          //                                                               index]
          //                                                           .hari ==
          //                                                       "Rabu" &&
          //                                                   hariSekarang ==
          //                                                       3) {
          //                                                 warnaHariSekarang =
          //                                                     Colors.grey
          //                                                         .shade200;
          //                                               } else if (isiData[
          //                                                               index]
          //                                                           .hari ==
          //                                                       "Kamis" &&
          //                                                   hariSekarang ==
          //                                                       4) {
          //                                                 warnaHariSekarang =
          //                                                     Colors.grey
          //                                                         .shade200;
          //                                               } else if (isiData[
          //                                                               index]
          //                                                           .hari ==
          //                                                       "Jum'at" &&
          //                                                   hariSekarang ==
          //                                                       5) {
          //                                                 warnaHariSekarang =
          //                                                     Colors.grey
          //                                                         .shade200;
          //                                               } else if (isiData[
          //                                                               index]
          //                                                           .hari ==
          //                                                       "Sabtu" &&
          //                                                   hariSekarang ==
          //                                                       6) {
          //                                                 warnaHariSekarang =
          //                                                     Colors.grey
          //                                                         .shade200;
          //                                               } else {
          //                                                 warnaHariSekarang =
          //                                                     whiteColor;
          //                                               }

          //                                               return Container(
          //                                                 height: 72,
          //                                                 width:
          //                                                     MediaQuery.of(
          //                                                             context)
          //                                                         .size
          //                                                         .width,
          //                                                 decoration: BoxDecoration(
          //                                                     borderRadius:
          //                                                         BorderRadius
          //                                                             .circular(
          //                                                                 15),
          //                                                     color:
          //                                                         warnaHariSekarang),
          //                                                 child: Column(
          //                                                   mainAxisAlignment:
          //                                                       MainAxisAlignment
          //                                                           .center,
          //                                                   children: [
          //                                                     ListTile(
          //                                                       leading:
          //                                                           Container(
          //                                                         width: 40,
          //                                                         height: 40,
          //                                                         decoration:
          //                                                             BoxDecoration(
          //                                                           borderRadius:
          //                                                               BorderRadius.circular(
          //                                                                   100),
          //                                                           color: appcolor2
          //                                                               .withOpacity(
          //                                                                   0.1),
          //                                                         ),
          //                                                         child:
          //                                                             Center(
          //                                                           child:
          //                                                               Icon(
          //                                                             Icons
          //                                                                 .timer_outlined,
          //                                                             color:
          //                                                                 appcolor2,
          //                                                           ),
          //                                                         ),
          //                                                       ),
          //                                                       title: Text(
          //                                                           "${isiData[index].hari} :",
          //                                                           style: mulishStyleMedium.copyWith(
          //                                                               fontSize:
          //                                                                   13,
          //                                                               color:
          //                                                                   blackColor,
          //                                                               fontWeight:
          //                                                                   FontWeight.w600)),
          //                                                       subtitle: Text(
          //                                                           "${isiData[index].jamBuka} - ${isiData[index].jamTutup}",
          //                                                           style: mulishStyleMedium.copyWith(
          //                                                               fontSize:
          //                                                                   13,
          //                                                               color:
          //                                                                   blackColor,
          //                                                               fontWeight:
          //                                                                   FontWeight.w500)),
          //                                                     ),
          //                                                   ],
          //                                                 ),
          //                                               );
          //                                             },
          //                                           ),
          //                                         );
          //                                       } else if (snapshot
          //                                           .hasError) {
          //                                         return Text(
          //                                             "${snapshot.data}");
          //                                       }
          //                                       return Center(
          //                                         child: SpinKitFadingCircle(
          //                                           color: appcolor2,
          //                                           size: 30,
          //                                         ),
          //                                       );
          //                                     },
          //                                   )
          //                                 ],
          //                               ),
          //                             )
          //                           ],
          //                         ));
          //                   },
          //                 );
          //               }
          //             : null,
          //         leading: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Image.asset(
          //               item[0].statusToko == '1'
          //                   ? 'images/cover/open.png'
          //                   : 'images/cover/closed.png',
          //               height: 25,
          //             ),
          //           ],
          //         ),
          //         title: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //                 item[0].statusToko == '1'
          //                     ? "Toko buka, Klik untuk melihat jam operasional toko"
          //                     : "Toko tutup sementara anda dapat melakukan order saat kami buka",
          //                 style: mulishStyleSmall.copyWith(
          //                     color: blackColor,
          //                     fontWeight: FontWeight.w500)),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // );

        } else if (snapshot.hasError) {
          return Text("Masalah koneksi",
              style: mulishStyleSmall.copyWith(
                  color: blackColor, fontWeight: FontWeight.w500));
        }
        return Center(
          child: SpinKitFadingCircle(
            color: appcolor2,
            size: 30,
          ),
        );
      },
    );
  }
}
