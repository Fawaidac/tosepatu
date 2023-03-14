import 'package:flutter/material.dart';
import 'package:tosepatu/Shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ButuhBantuan extends StatefulWidget {
  const ButuhBantuan({Key key}) : super(key: key);

  @override
  State<ButuhBantuan> createState() => _ButuhBantuanState();
}

class _ButuhBantuanState extends State<ButuhBantuan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 8),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Butuh Bantuan?',
                    style: mulishStyleLarge.copyWith(
                        fontWeight: FontWeight.w600, color: blackColor),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Minta bantuan dan layanan terkait tosepatu',
                    style: mulishStyleSmall.copyWith(
                        fontWeight: FontWeight.w500, color: blackColor),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 75,
            // padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(2),
              // boxShadow: [
              //   BoxShadow(
              //       blurRadius: 10,
              //       spreadRadius: 1,
              //       color: appcolor2.withOpacity(0.1),
              //       offset: const Offset(1.0, 1.0))
              // ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () async {
                    _launchURL("https://wa.me/message/TJHCXV2IHL45I1");
                  },
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: appcolor2.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Icon(
                        Icons.call,
                        color: appcolor2,
                      ),
                    ),
                  ),
                  title: Text(
                    'Hubungi layanan kami',
                    style: mulishStyleMedium.copyWith(
                        color: blackColor, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Kami ada untukmu melalui WhatsApp',
                    style: mulishStyleSmall.copyWith(
                        color: blackColor, fontWeight: FontWeight.w300),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: appcolor2,
                    size: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
