import 'package:cashback/feauters/seller_catalog/presentation/screens/seller_catalog_screen/seller_catalog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cashback/feauters/seller_basket/presentation/logic/bloc/basket_bloc.dart';
import 'package:cashback/feauters/seller_basket/presentation/widgets/order_list_card.dart';
import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/components/custom_flushbar.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:cashback/internal/helpers/utils.dart';
import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/seller_navbar.dart';
import '../../../../../internal/helpers/text_style_helper.dart';

class TakeOrderWithoutQr extends StatefulWidget {
  final double totalCashBack;
  final double totalPrice;
  final bool? isWithApp;

  const TakeOrderWithoutQr({
    super.key,
    this.isWithApp,
    required this.totalCashBack,
    required this.totalPrice,
  });

  @override
  State<TakeOrderWithoutQr> createState() => _TakeOrderWithoutQrState();
}

class _TakeOrderWithoutQrState extends State<TakeOrderWithoutQr> {
  late BasketBloc bloc;

  @override
  void initState() {
    bloc = getIt<BasketBloc>();
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
              isWithApp: false,
              totalCashBack: widget.totalCashBack,
              totalPrice: widget.totalPrice,
            ),
            SizedBox(height: 29.h),
            BlocListener<BasketBloc, BasketState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is SuccessOrderCreateState) {
                  SmartDialog.dismiss();

                  customNavigatorPushAndRemove(context, SellerCatalogScreen());

                  Exceptions.showFlushbar(
                    'Успешно!',
                    context: context,
                    isSuccess: true,
                  );
                }
                if (state is OrderCreateErrorState) {
                  Exceptions.showFlushbar(
                    'Ошибка!',
                    context: context,
                  );
                }
              },
              child: CustomButtonCard(
                onPressed: () {
                  if (Constants.totalBasket.isNotEmpty) {
                    SmartDialog.showLoading(msg: 'Загрузка...');
                    bloc.add(
                      OrderCreateEvent(cashback: '0', id: 'client'),
                    );
                  } else {
                    Exceptions.showFlushbar('Корзина пуста!', context: context);
                  }
                },
                backColor: Colors.white,
                title: 'Оплатить',
                width: 150.w,
                height: 40.h,
                bRadius: 20.r,
                color: ColorHelper.red08,
                textStyle: TextStyleHelper.sellerButtonCard,
                isGreen: true,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const SellerNavBar(currentPage: 1),
    );
  }
}
