import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/Api/Api_services.dart';
import 'package:tosepatu/Model/beritaModel.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/w_detailpromo.dart';
import 'package:tosepatu/Screen/Setting/profile.dart';
import 'package:tosepatu/Shared/theme.dart';

class Promo extends StatefulWidget {
  const Promo({Key key}) : super(key: key);

  @override
  State<Promo> createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  ApiServices apiServices = ApiServices();
  Future<List<myBerita>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getPromo(currentUser.user.idWilayah);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<myBerita>>(
      future: listdata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<myBerita> isiData = snapshot.data;
          return ListView.builder(
            itemCount: isiData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: DetailPromo(
                            berita: isiData[index],
                          ),
                          type: PageTransitionType.fade));
                },
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: NetworkImage(
                              Api.imageberita + isiData[index].fotoBerita),
                          fit: BoxFit.cover)),
                ),
              );
            },
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
    );
  }
}
