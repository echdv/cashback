import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../internal/helpers/colors_helper.dart';

class SellerButtonCard extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final double height;
  final double width;

  const SellerButtonCard({
    super.key,
    required this.onPressed,
    required this.title,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: Colors.white,
          side: BorderSide(
            width: 0.4.r,
            color: ColorHelper.red05,
          )),
      child: Text(
        title,
        style: TextStyleHelper.sellerButtonCard,
      ),
    );
  }
}
