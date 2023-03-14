import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class getTextForm extends StatelessWidget {
  TextEditingController controller;
  String hintName;
  bool isObscureText;
  bool isEnable;
  bool isReadOnly;
  TextInputType keyboardType;
  TextInputFormatter inputFormatters;
  int length;
  TextInputAction textInputAction;
  getTextForm(
      {Key key,
      this.controller,
      this.hintName,
      this.isObscureText = false,
      this.keyboardType,
      this.inputFormatters,
      this.length,
      this.isReadOnly = false,
      this.isEnable = true,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          textInputAction: textInputAction,
          obscureText: isObscureText,
          controller: controller,
          // maxLines: 5,
          // minLines: 3,
          style: GoogleFonts.mulish(fontSize: 13),
          keyboardType: keyboardType,
          enabled: isEnable,
          onSaved: (val) => controller = val as TextEditingController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hintName';
            }
            return null;
          },
          inputFormatters: [
            inputFormatters,
            LengthLimitingTextInputFormatter(length)
          ],
          decoration: InputDecoration(
            // labelText: hintName,
            hintText: hintName,
            isDense: true,
            hintStyle: GoogleFonts.mulish(fontSize: 13),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xffF0F1F7), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xffF0F1F7), width: 1),
            ),
            filled: true,
            fillColor: const Color(0xFFFCFDFE),
          ),
        )
      ],
    );
  }
}
