import 'package:cashback/feauters/auth/presentation/screens/log_in_screen/log_in_screen.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/helpers/utils.dart';
import '../registration_screen/phone_number_screen.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 212.h),
          Center(
            child: SvgPicture.asset('assets/icons/logotip.svg'),
          ),
          SizedBox(height: 98.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.w),
            child: Text(
              'Добро пожаловать в cashback-сервис FELIZ.',
              textAlign: TextAlign.center,
              style: TextStyleHelper.forChooseAuth,
            ),
          ),
          SizedBox(height: 36.h),
          CustomButtonCard(
            onPressed: () {
              customNavigatorPush(context, LogInScreen());
            },
            backColor: ColorHelper.green08,
            height: 50.h,
            width: 300.w,
            title: 'ВХОД',
            bRadius: 20.r,
            textStyle: TextStyleHelper.forBold,
            color: Colors.white,
            isGreen: true,
          ),
          SizedBox(height: 26.h),
          CustomButtonCard(
            onPressed: () {
              customNavigatorPush(context, PhoneNumberScreen());
            },
            backColor: ColorHelper.green08,
            title: 'ЗАРЕГИСТРИРОВАТЬСЯ',
            width: 300.w,
            height: 50.h,
            bRadius: 20.r,
            color: Colors.white,
            textStyle: TextStyleHelper.forBold,
            isGreen: true,
          )
        ],
      ),
    );
  }
}
