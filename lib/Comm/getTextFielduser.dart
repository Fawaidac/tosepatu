import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tosepatu/Shared/theme.dart';

class GetTextFieldUser extends StatefulWidget {
  TextEditingController controller;
  String hintName;
  bool isEnable;
  TextInputType keyboardType;
  TextInputFormatter inputFormatters;
  int length;
  String label;
  IconData icon;
  TextInputAction textInputAction;
  GetTextFieldUser(
      {Key key,
      this.controller,
      this.hintName,
      this.keyboardType,
      this.inputFormatters,
      this.length,
      this.icon,
      this.label,
      this.isEnable,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  @override
  State<GetTextFieldUser> createState() => _GetTextFieldUserState();
}

class _GetTextFieldUserState extends State<GetTextFieldUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.mulish(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          style: GoogleFonts.mulish(fontSize: 13),
          keyboardType: widget.keyboardType,
          enabled: widget.isEnable,
          inputFormatters: [
            widget.inputFormatters,
            LengthLimitingTextInputFormatter(widget.length)
          ],
          decoration: InputDecoration(
            hintText: widget.hintName,
            isDense: false,
            prefixIcon: Icon(
              widget.icon,
              size: 20,
              color: Colors.grey,
            ),
            suffixIcon: Icon(
              Icons.mode_edit,
              size: 20,
              color: Colors.grey,
            ),
            border:
                UnderlineInputBorder(borderSide: BorderSide(color: appcolor2)),
          ),
        )
      ],
    );
  }
}
