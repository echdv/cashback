import 'dart:io';

import 'package:cashback/internal/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../internal/helpers/colors_helper.dart';

class ArrowBackCard extends StatelessWidget {
  const ArrowBackCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        return Navigator.pop(context);
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: SizedBox(
        width: 80.w,
        child: Row(
          children: [
            if (!Platform.isIOS)
              Icon(
                Icons.arrow_back,
                color: ColorHelper.green08,
              ),
            if (Platform.isIOS)
              Icon(
                Icons.arrow_back_ios,
                size: 17.r,
                color: ColorHelper.green08,
              ),
            Text(
              'Назад',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 16.sp,
                color: ColorHelper.green08,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
