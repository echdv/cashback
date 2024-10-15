import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'colors_helper.dart';

class SellerCustomTextField extends StatelessWidget {
  const SellerCustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      width: 334.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(23, 69, 59, 0.1),
            offset: const Offset(4, 4),
            blurRadius: 20.r,
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 20.h),
          filled: true,
          fillColor: ColorHelper.brown02,
          prefixIcon: Icon(
            Icons.search,
            color: ColorHelper.brown08,
          ),
          hintText: "Поиск",
          hintStyle: TextStyle(
            fontFamily: 'Lato',
            color: ColorHelper.brown08,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldScreen extends StatelessWidget {
  const CustomTextFieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      width: 334.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
              color: ColorHelper.green01,
              offset: const Offset(4, 4),
              blurRadius: 20.r,
              blurStyle: BlurStyle.outer)
        ],
      ),
      child: TextField(
        cursorColor: ColorHelper.green08,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 0.1.h),
          filled: true,
          fillColor: ColorHelper.green02,
          prefixIcon: Icon(
            Icons.search,
            color: ColorHelper.green08,
            weight: 100,
          ),
          hintText: "Поиск",
          hintStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: ColorHelper.green08,
            fontFamily: 'Lato',
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              width: 0.1.r,
              color: ColorHelper.green05,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              width: 0.1.r,
              color: ColorHelper.green05,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonCard extends StatelessWidget {
  final void Function() onPressed;
  final String title;

  final double width;
  final double height;
  final double bRadius;
  final Color color;
  final TextStyle textStyle;
  final Color backColor;

  const CustomButtonCard({
    super.key,
    required this.onPressed,
    required this.title,
    required this.width,
    required this.height,
    required this.bRadius,
    required this.color,
    required this.textStyle,
    required this.backColor,
    required bool isGreen,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backColor,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.4.r,
            color: color,
          ),
          borderRadius: BorderRadius.circular(bRadius),
        ),
      ),
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}

dateFormater(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  String formattedDate = DateFormat('dd.MM.yyyy').format(date);
  return formattedDate;
}

dateFormaterForKassa(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  String formattedDate = DateFormat('dd/MM/yy').format(date);
  return formattedDate;
}

dateCounter(String maxDate) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'").parse(maxDate);

  DateTime finalDate =
      DateTime(parseDate.year, parseDate.month, parseDate.day + 1);

  return finalDate;
}

timeFormater(String date) {
  DateTime nDate = DateTime.parse(date);
  String parseDate = DateFormat('Hm').format(nDate);

  return parseDate;
}

customNavigatorPush(BuildContext context, Widget widget) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, _, __) => widget,
        transitionDuration: const Duration(microseconds: 300),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ));
}

customNavigatorPushAndRemove(BuildContext context, Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, _, __) => widget,
        transitionDuration: const Duration(microseconds: 300),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
      (Route<dynamic> route) => false);
}
