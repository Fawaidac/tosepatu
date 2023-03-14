import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/CurrentUser/RememberUser.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/w_bantuanlayanan.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/w_jadwal.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/w_layanan.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/w_promo.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/w_titlelayanan.dart';
import 'package:tosepatu/Screen/Beranda/MyHome/w_headers.dart';
import 'package:http/http.dart' as http;
import 'package:tosepatu/Screen/Setting/myprofil.dart';
import 'package:tosepatu/Shared/theme.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<String> tabs = [
  "Semua",
  "Promo",
];
int current = 0;
double changePositionedOfLine() {
  switch (current) {
    case 0:
      return 0;
    case 1:
      return 70;
    default:
      return 0;
  }
}

double changeContainerWidth() {
  switch (current) {
    case 0:
      return 60;
    case 1:
      return 105;
    default:
      return 0;
  }
}

final CurrentUser _currentUser = Get.put(CurrentUser());

class _HomeState extends State<Home> with TickerProviderStateMixin {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (RememberUser.readUser() != null) {
      _currentUser.getUserInfo();
    }
    getLokasi();
    tabController = TabController(length: 2, vsync: this);
  }

  TabController tabController;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: SafeArea(
          child: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/logo/logo.png',
                        height: 70,
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _currentUser.user.usernameUser,
                                style: mulishStyleMedium.copyWith(
                                    color: blackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _currentUser.user.emailUser,
                                style: mulishStyleSmall.copyWith(
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: MyProfile(),
                                      type: PageTransitionType.fade));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
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
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'images/logo/man0.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const WidgetHeaders(),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                        width: double.maxFinite,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TabBar(
                            controller: tabController,
                            labelColor: blackColor,
                            isScrollable: true,
                            labelPadding:
                                const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            unselectedLabelColor: Colors.grey,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorPadding:
                                const EdgeInsets.only(top: 33, bottom: 2),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: appcolor2,
                            ),
                            labelStyle: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            tabs: const [
                              Tab(
                                text: "Semua",
                              ),
                              Tab(
                                text: "Promo",
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 1,
                        padding: const EdgeInsets.only(top: 10),
                        child: TabBarView(controller: tabController, children: [
                          Column(
                            children: [
                              const JadwalToko(),
                              const TitleProduct(),
                              const MyProduct(),
                              const ButuhBantuan(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "@tosepatu.kc",
                                    style: GoogleFonts.mulish(
                                        fontSize: 12,
                                        color: Colors.grey.withOpacity(0.5)),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Promo(),
                                )
                              ],
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
