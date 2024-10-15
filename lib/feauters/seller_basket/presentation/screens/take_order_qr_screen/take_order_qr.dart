import 'dart:developer';

import 'package:cashback/feauters/seller_basket/presentation/screens/take_point_screen/take_point_screen.dart';
import 'package:cashback/internal/helpers/components/custom_flushbar.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cashback/internal/helpers/utils.dart';

import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/seller_navbar.dart';
import '../../widgets/order_list_card.dart';

class TakeOrderQrScreen extends StatefulWidget {
  final String userID;
  final double totalPrice;
  final double totalCashBack;

  const TakeOrderQrScreen({
    super.key,
    required this.userID,
    required this.totalPrice,
    required this.totalCashBack,
  });

  @override
  State<TakeOrderQrScreen> createState() => _TakeOrderQrScreenState();
}

class _TakeOrderQrScreenState extends State<TakeOrderQrScreen> {
  @override
  void initState() {
    log("list === ${Constants.totalBasket}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.w,
        centerTitle: false,
        backgroundColor: ColorHelper.brown08,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        toolbarHeight: 139.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "КОРЗИНА",
              style: TextStyleHelper.forAppBar,
            ),
          ],
        ),
        actions: [
          SizedBox(
            height: 58.h,
            width: 58.w,
            child: SvgPicture.asset("assets/icons/logo_appbar.svg"),
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: Column(
          children: [
            SizedBox(height: 82.h),
            OrderListCard(
              totalCashBack: widget.totalCashBack,
              totalPrice: widget.totalPrice,
            ),
            SizedBox(height: 29.h),
            CustomButtonCard(
              onPressed: () {
                if (Constants.totalBasket.isNotEmpty) {
                  customNavigatorPush(
                    context,
                    TakePoinScreen(
                      userId: widget.userID,
                      totalPrice: widget.totalPrice,
                    ),
                  );
                } else {
                  Exceptions.showFlushbar('Корзина пуста!', context: context);
                }
              },
              backColor: Colors.white,
              title: 'Далee',
              width: 150.w,
              height: 40.h,
              bRadius: 20.r,
              color: ColorHelper.red08,
              textStyle: TextStyleHelper.sellerButtonCard,
              isGreen: true,
            )
          ],
        ),
      ),
      bottomNavigationBar: const SellerNavBar(currentPage: 1),
    );
  }
}
