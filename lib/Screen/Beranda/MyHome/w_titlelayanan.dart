import 'package:flutter/material.dart';
import 'package:tosepatu/Shared/theme.dart';

class TitleProduct extends StatelessWidget {
  const TitleProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Layanan",
                style: mulishStyleLarge.copyWith(
                    color: blackColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Berikut layanan terkait tosepatu',
                style: mulishStyleSmall.copyWith(
                    fontWeight: FontWeight.w500, color: blackColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
