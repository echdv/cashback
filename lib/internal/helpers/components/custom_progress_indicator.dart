/* External dependencies */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/* Local dependencies */
import 'package:cashback/internal/helpers/colors_helper.dart';

class CustomProgressIndicator extends StatelessWidget {
  final String? msg;

  const CustomProgressIndicator({super.key, this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: 130.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white, // TO:DO возможно поменять цвет
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularProgressIndicator(
            color: ColorHelper.green1, // TO:DO возможно поменять цвет
            strokeWidth: 2.0,
          ),
          Text(
            msg ?? 'Загрузка...',
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorHelper.green1,
            ), // TO:DO вынести TextHelper как в SmartTips
          ),
        ],
      ),
    );
  }
}
