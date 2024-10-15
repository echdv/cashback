import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyleHelper {
  static TextStyle forBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle forErrorState = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: ColorHelper.green08,
    fontFamily: 'Lato',
  );

   static TextStyle forInfoKassaUserNumPhone = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color:  ColorHelper.brown08,
    fontFamily: 'Lato',
  );

  static TextStyle forErrorSellerState = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: ColorHelper.brown08,
    fontFamily: 'Lato',
  );

  static TextStyle forTextField = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: ColorHelper.grey07,
    fontFamily: 'Lato',
  );

  static TextStyle forAuthInfoL = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle forAuthInfoS = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle forClientButton = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: ColorHelper.green1,
    fontFamily: 'Lato',
  );

  static TextStyle forClientSellerButton = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: ColorHelper.brown08,
    fontFamily: 'Lato',
  );

  static TextStyle forChooseBranch = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle forCategoryButton = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: ColorHelper.green08,
    fontFamily: 'Lato',
  );

  static TextStyle forAppBar = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle forChooseAuth = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    color: ColorHelper.green08,
    fontFamily: 'Lato',
  );

  static TextStyle forElementInfoL = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: ColorHelper.green08,
    fontFamily: 'Lato',
  );

  static TextStyle forElementInfoSelNameProduct = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: ColorHelper.white1,
    fontFamily: 'Lato',
  );

  static TextStyle forElementInfoSelTypeProduct = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: ColorHelper.white1,
    fontFamily: 'Lato',
  );

  static TextStyle forElementInfoS = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: ColorHelper.green06,
    fontFamily: 'Lato',
  );

  static TextStyle forPrice = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: ColorHelper.green08,
    fontFamily: 'Lato',
  );

  static TextStyle forSellerPrice = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: ColorHelper.white1,
    fontFamily: 'Lato',
  );

  static TextStyle forPoint = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: ColorHelper.yellow1,
    fontFamily: 'Lato',
  );

  static TextStyle forDate = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorHelper.green1,
    fontFamily: 'Lato',
  );

  static TextStyle plPoint = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: ColorHelper.green1,
    fontFamily: 'Lato',
  );

  static TextStyle forFood = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle plPointWhite = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle dayInfoPoint = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle profileInfo = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle forPointL = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
    color: ColorHelper.yellow1,
    fontFamily: 'Lato',
  );

  static TextStyle forErrorPointL = TextStyle(
    fontSize: 27.sp,
    fontWeight: FontWeight.w700,
    color: ColorHelper.yellow1,
    fontFamily: 'Lato',
  );

  static TextStyle forCatalogCard = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Constants.isUser ? ColorHelper.green08 : ColorHelper.brown08,
    fontFamily: 'Lato',
  );

  static TextStyle forCatalogSellerCard = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: ColorHelper.brown08,
    fontFamily: 'Lato',
  );

  static TextStyle sellerButtonCard = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorHelper.brown08,
    fontFamily: 'Lato',
  );

  static TextStyle basket1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: 'Lato',
  );

  static TextStyle basket2 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: ColorHelper.white08,
    fontFamily: 'Lato',
  );

  static TextStyle basket3 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: ColorHelper.white08,
    fontFamily: 'Lato',
  );

  static TextStyle basket4 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: ColorHelper.white08,
    fontFamily: 'Lato',
  );

  static TextStyle basket5 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: ColorHelper.white08,
    fontFamily: 'Lato',
  );

  static TextStyle basket6 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorHelper.white08,
    fontFamily: 'Lato',
  );

  static TextStyle basket7 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: ColorHelper.white08,
    fontFamily: 'Lato',
  );
}
