import 'dart:developer';
import 'dart:io';

import 'package:cashback/feauters/seller_basket/presentation/screens/choose_basket_screen/choose_basket_screen.dart';
import 'package:cashback/feauters/seller_catalog/presentation/widgets/bloc/floating_bloc.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:cashback/internal/helpers/seller_navbar.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';

import '../../../../../internal/helpers/colors_helper.dart';
import '../../logic/bloc/seller_catalog_bloc.dart';
import '../../widgets/row_seller_card.dart';

class SellerCatalogInfoScreen extends StatefulWidget {
  final int id;
  const SellerCatalogInfoScreen({
    super.key,
    required this.id,
  });

  @override
  State<SellerCatalogInfoScreen> createState() =>
      _SellerCatalogInfoScreenState();
}

class _SellerCatalogInfoScreenState extends State<SellerCatalogInfoScreen> {
  late SellerCatalogBloc sbloc;
  late FloatingBloc fab_bloc;

  @override
  void initState() {
    fab_bloc = getIt<FloatingBloc>();
    if (Constants.totalBasket == false || Constants.totalBasket.isEmpty) {
      fab_bloc.add(HideFABEvent());
    } else {
      fab_bloc.add(ShowFABEvent());
    }
    sbloc = getIt<SellerCatalogBloc>();
    sbloc.add(GetSellerProductEvent(
      id: widget.id,
    ));
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
        title: Transform(
          transform: Matrix4.translationValues(-0.0, 0.0, 0.0),
          child: Text(
            "КАТАЛОГ",
            style: TextStyleHelper.forAppBar,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/logo_appbar.svg"),
                SizedBox(width: 20.w),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            BlocConsumer<SellerCatalogBloc, SellerCatalogState>(
              bloc: sbloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SellerCatalogLoadingState) {
                  if (Platform.isIOS) {
                    return Padding(
                      padding: EdgeInsets.only(top: 200.h),
                      child: Center(
                        child: CupertinoActivityIndicator(
                          radius: 15.r,
                          color: ColorHelper.brown08,
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorHelper.brown08,
                      ),
                    );
                  }
                }

                if (state is SellerCatalogErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: 200.w,
                          height: 200.h,
                          child:
                              SvgPicture.asset("assets/icons/sellerIcon.svg"),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          state.error.message ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyleHelper.forErrorSellerState,
                        ),
                        SizedBox(height: 70.h),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              backgroundColor: ColorHelper.brown08,
                            ),
                            onPressed: () {
                              sbloc.add(GetSellerProductEvent(
                                id: widget.id,
                              ));
                            },
                            label: const Text(
                              "Повторить",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: Colors.white,
                              ),
                            ),
                            icon: Icon(
                              Icons.replay_rounded,
                              color: ColorHelper.white1,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }

                if (state is ProductSellerLoadedState) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView.separated(
                        padding: EdgeInsets.only(bottom: 20.h),
                        itemCount: state.productModel.length,
                        itemBuilder: (context, index) {
                          return RowSellerCard(
                            nameProduct:
                                state.productModel[index].title.toString(),
                            typeProduct: state.productModel[index].typeProduct
                                .toString(),
                            image: state.productModel[index].image.toString(),
                            price: state.productModel[index].price.toString(),
                            productID: state.productModel[index].id ?? 0,
                            cashback: state.productModel[index].cashback ?? 0,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 30.h);
                        },
                      ),
                    ),
                  );
                }

                return const SizedBox();
              },
            )
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<FloatingBloc, FloatingState>(
        bloc: fab_bloc,
        builder: (context, state) {
          if (state is ShowFABState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    SmartDialog.show(builder: (_) {
                      return Container(
                        padding: EdgeInsets.all(20).r,
                        width: 300.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Вы точно хотите удалить все из корзины?',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: ColorHelper.brown08,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'это действие нельзя будет отменить после принятия',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      Constants.totalBasket.clear();
                                      log('basket == ${Constants.totalBasket}');
                                      SmartDialog.dismiss();
                                      fab_bloc.add(HideFABEvent());
                                      sbloc.add(
                                          GetSellerProductEvent(id: widget.id));
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size.fromWidth(110.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10).r,
                                    ),
                                    backgroundColor: ColorHelper.brown08,
                                  ),
                                  child: Text('Принять'),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    SmartDialog.dismiss();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size.fromWidth(110.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10).r,
                                    ),
                                    backgroundColor: ColorHelper.brown08,
                                  ),
                                  child: Text(
                                    'Отменить',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    });
                  },
                  backgroundColor: ColorHelper.brown1,
                  child: const Icon(Icons.delete_outline_rounded),
                ),
                SizedBox(width: 10.w),
                FloatingActionButton(
                  onPressed: () {
                    customNavigatorPushAndRemove(
                      context,
                      ChooseBasketScreen(),
                    );
                  },
                  backgroundColor: ColorHelper.brown1,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: SellerNavBar(
        currentPage: 0,
      ),
    );
  }
}
