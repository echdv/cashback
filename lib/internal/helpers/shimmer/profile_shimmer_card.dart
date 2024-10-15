import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../colors_helper.dart';
import '../text_style_helper.dart';

class ProfileShimmerCard extends StatelessWidget {
  const ProfileShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.w),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Container(
            padding: EdgeInsets.only(
              top: 75.h,
              left: 30.w,
              right: 30.w,
              bottom: 30.h,
            ),
            width: 1.sw,
            decoration: BoxDecoration(
              color: ColorHelper.green08,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Изменить",
                            style: TextStyle(color: ColorHelper.green08),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          SvgPicture.asset(
                            "assets/icons/Pen.svg",
                            // ignore: deprecated_member_use
                            color: ColorHelper.green08,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      'Имя: ',
                      style: TextStyleHelper.profileInfo,
                    ),
                    SizedBox(width: 20.w),
                    if (Platform.isIOS)
                      CupertinoActivityIndicator(
                        radius: 9.r,
                        color: Colors.white,
                      ),
                    if (!Platform.isIOS)
                      Center(
                        child: SizedBox(
                          height: 15.r,
                          width: 14.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                Container(),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Text(
                      'Номер телефона: ',
                      style: TextStyleHelper.profileInfo,
                    ),
                    SizedBox(width: 60.w),
                    if (Platform.isIOS)
                      CupertinoActivityIndicator(
                        radius: 9.r,
                        color: Colors.white,
                      ),
                    if (!Platform.isIOS)
                      Center(
                        child: SizedBox(
                          height: 15.r,
                          width: 14.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(height: 54.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
