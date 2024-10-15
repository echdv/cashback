// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../internal/helpers/text_style_helper.dart';

class CustomProfileText extends StatelessWidget {
  final bool? isError;
  final int flex1;
  final int flex2;
  final String title;
  final String info;

  const CustomProfileText({
    Key? key,
    this.isError = false,
    required this.flex1,
    required this.flex2,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isError == false) {
      return Row(
        children: [
          Expanded(
            flex: flex1,
            child: Text(
              title,
              style: TextStyleHelper.profileInfo,
            ),
          ),
          Expanded(
            flex: flex2,
            child: Text(
              info,
              style: TextStyleHelper.profileInfo,
            ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            flex: flex1,
            child: Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Text(
                title,
                style: TextStyleHelper.profileInfo,
              ),
            ),
          ),
          Expanded(
            flex: flex2,
            child: Padding(
              padding: EdgeInsets.only(top: 7.h),
              child: Text(
                info,
                style: TextStyleHelper.profileInfo,
              ),
            ),
          ),
        ],
      );
    }
  }
}
