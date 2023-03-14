import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Api/Api_services.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/Model/beritaModel.dart';
import 'package:tosepatu/Screen/Setting/profile.dart';
import 'package:tosepatu/Shared/theme.dart';

class WidgetHeaders extends StatefulWidget {
  const WidgetHeaders({Key key}) : super(key: key);

  @override
  State<WidgetHeaders> createState() => _WidgetHeadersState();
}

class _WidgetHeadersState extends State<WidgetHeaders> {
  final pageCtrl =
      PageController(initialPage: 0, viewportFraction: 0.8, keepPage: true);

  ApiServices apiServices = ApiServices();
  Future<List<myBerita>> listdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageCtrl;
    _currentUser.getUserInfo();
    if (currentUser.user.idWilayah != '') {
      listdata = apiServices.getBerita(currentUser.user.idWilayah);
    } else {
      currentUser.getUserInfo().then((value) {
        setState(() {
          listdata = apiServices.getBerita(currentUser.user.idWilayah);
        });
      });
    }
  }

  final CurrentUser _currentUser = Get.put(CurrentUser());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        height: 150,
        width: size.width,
        child: FutureBuilder<List<myBerita>>(
          future: listdata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<myBerita> isiData = snapshot.data;
              return SizedBox(
                height: 150,
                child: Swiper(
                  itemCount: isiData.length,
                  autoplay: true,
                  itemBuilder: (context, index) {
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      padding: const EdgeInsets.all(10),
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(
                                Api.imageberita + isiData[index].fotoBerita),
                          )),
                    );
                  },
                ),
              );
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
        ));
  }
}
// FutureBuilder<List<myBerita>>(
//           future: listdata,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
              
//             } else if (snapshot.hasError) {
//               return Text("Masalah koneksi",
//                   style: mulishStyleSmall.copyWith(
//                       color: blackColor, fontWeight: FontWeight.w500));
//             }
//             return Center(
//               child: SpinKitFadingCircle(
//                 color: appcolor2,
//                 size: 30,
//               ),
//             );
//           },
//         )
// Swiper(
//         itemCount: 3,
//         autoplay: true,
//         itemBuilder: (context, index) {
//           return Container(
//             clipBehavior: Clip.hardEdge,
//             margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//             padding: const EdgeInsets.all(10),
//             height: 150,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.transparent,
//                 image: DecorationImage(
//                   image: AssetImage('images/cover/Cover.png'),
//                 )),
            
//           );
//         },
//       ),