import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../internal/helpers/colors_helper.dart';

class TextFieldCard extends StatefulWidget {
  final String title;
  final TextInputType type;
  final bool isPassword;
  final TextEditingController controller;
  final void Function(String) onChange;
  final Widget? prefixIcon;
  final bool center;

  const TextFieldCard({
    super.key,
    required this.title,
    required this.type,
    this.isPassword = false,
    required this.controller,
    required this.onChange,
    this.prefixIcon,
    this.center = true,
  });

  @override
  State<TextFieldCard> createState() => _TextFieldCardState();
}

class _TextFieldCardState extends State<TextFieldCard> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChange,
      controller: widget.controller,
      obscureText: widget.isPassword,
      cursorColor: ColorHelper.grey07,
      style: TextStyleHelper.forTextField,
      textAlign: widget.center ? TextAlign.center : TextAlign.start,
      keyboardType: widget.type,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        contentPadding: EdgeInsets.only(top: 20.h),
        hintText: widget.title,
        hintStyle: TextStyleHelper.forTextField,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorHelper.grey07,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorHelper.grey07,
          ),
        ),
      ),
    );
  }
}
