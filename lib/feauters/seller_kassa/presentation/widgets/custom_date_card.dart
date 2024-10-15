import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../internal/helpers/colors_helper.dart';
import '../../../../internal/helpers/utils.dart';

class CustomDateCard extends StatelessWidget {
  final String date;
  final String fullPrice;
  final String fullCashback;
  const CustomDateCard({
    super.key,
    required this.date,
    required this.fullPrice,
    required this.fullCashback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(23, 69, 59, 0.25),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(1, 3),
            )
          ],
          color: Colors.white,
          border: Border.all(
            color: const Color.fromRGBO(83, 42, 42, 0.5),
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        width: 334.w,
        height: 61.h,
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dateFormater(date),
                  style: TextStyleHelper.forCatalogSellerCard,
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '+$fullPrice сом',
                ),
                SizedBox(height: 2.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/coin.svg",
                      height: 15.r,
                      width: 15.r,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      fullCashback,
                      style: TextStyle(
                        color: ColorHelper.yellow1,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
