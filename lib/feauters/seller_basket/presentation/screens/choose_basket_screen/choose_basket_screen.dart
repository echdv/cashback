import 'package:cashback/feauters/seller_basket/presentation/screens/camera_screen.dart';
import 'package:cashback/feauters/seller_basket/presentation/screens/take_order_qr_screen/take_order_qr.dart';
import 'package:cashback/feauters/seller_basket/presentation/screens/take_order_without_qr_screen/take_order_without_qr_screen.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/constants.dart';

import '../../../../../internal/helpers/seller_navbar.dart';
import '../../../data/models/basket_ui_model.dart';

class ChooseBasketScreen extends StatefulWidget {
  const ChooseBasketScreen({super.key});

  @override
  State<ChooseBasketScreen> createState() => _ChooseBasketScreenState();
}

class _ChooseBasketScreenState extends State<ChooseBasketScreen> {
  double totalPrice = 0;
  double totalCashBack = 0;

  List<BasketModel> asd = [];
  @override
  void initState() {
    Constants.totalBasket.forEach((element) {
      asd.addAll(List<BasketModel>.generate(
        element.amount,
        (index) => BasketModel(
          productID: element.productID,
          amount: element.amount,
          productName: element.productName,
          cashback: element.cashback,
          price: element.price,
        ),
      ));
    });

    for (int i = 0; i < asd.length; i++) {
      totalPrice += double.parse(asd[i].price);
      totalCashBack += asd[i].cashback;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 53.w,
        backgroundColor: ColorHelper.red08,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        toolbarHeight: 139.h,
        title: Text(
          'КОРЗИНА',
          style: TextStyleHelper.forAppBar,
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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 220.h),
            ElevatedButton(
              onPressed: () {
                customNavigatorPush(
                  context,
                  CameraScreen(
                    totalCashBack: totalCashBack,
                    totalPrice: totalPrice,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 0.5.r,
                  color: ColorHelper.red05,
                ),
                backgroundColor: Colors.white,
                fixedSize: Size(320.w, 40.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 30.w),
                  Expanded(
                    flex: 8,
                    child: Text(
                      'Сканировать QR-код',
                      style: TextStyleHelper.sellerButtonCard,
                    ),
                  ),
                  Expanded(
                    child: SvgPicture.asset('assets/icons/camera.svg'),
                  )
                ],
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () {
                customNavigatorPush(
                  context,
                  TakeOrderWithoutQr(
                    totalCashBack: totalCashBack,
                    totalPrice: totalPrice,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                alignment: const Alignment(-0.5, 0),
                side: BorderSide(
                  width: 0.5.r,
                  color: ColorHelper.red05,
                ),
                backgroundColor: Colors.white,
                fixedSize: Size(320.w, 40.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 30.w),
                  Expanded(
                    flex: 10,
                    child: Text(
                      'Без приложения',
                      style: TextStyleHelper.sellerButtonCard,
                    ),
                  ),
                  Expanded(
                    child: SvgPicture.asset('assets/icons/arrow.svg'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const SellerNavBar(currentPage: 1),
    );
  }
}
