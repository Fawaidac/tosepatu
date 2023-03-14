import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Api/Api_services.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/Model/layananModel.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/Home.dart';
import 'package:tosepatu/Shared/theme.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({Key key}) : super(key: key);

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  ApiServices apiServices = ApiServices();
  Future<List<myLayanan>> listdata;
  final CurrentUser _currentUser = Get.put(CurrentUser());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_currentUser.user.idWilayah != '') {
      listdata = apiServices.getLayanan(_currentUser.user.idWilayah);
    } else {
      _currentUser.getUserInfo().then((value) {
        setState(() {
          listdata = apiServices.getLayanan(_currentUser.user.idWilayah);
        });
      });
    }
    _currentUser.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FutureBuilder<List<myLayanan>>(
        future: listdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<myLayanan> isiData = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: isiData.length,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: 350,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 150,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              // boxShadow: [
                              //   BoxShadow(
                              //       blurRadius: 10,
                              //       spreadRadius: 1,
                              //       color: appcolor2.withOpacity(0.1),
                              //       offset: Offset(1.0, 1.0))
                              // ],
                              borderRadius: BorderRadius.circular(2)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            Api.imageproduct +
                                                isiData[index].fotoLayanan,
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isiData[index].namaLayanan,
                                        style: mulishStyleMedium.copyWith(
                                            fontSize: 14,
                                            color: blackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        isiData[index].desciption,
                                        style: mulishStyleMedium.copyWith(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        )));
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
