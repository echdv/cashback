import 'dart:developer';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/feauters/seller_basket/data/models/basket_ui_model.dart';
import 'package:cashback/feauters/seller_catalog/presentation/widgets/bloc/floating_bloc.dart';
import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/components/custom_flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cashback/internal/helpers/constants.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';

import '../../../../internal/helpers/colors_helper.dart';

class RowSellerCard extends StatefulWidget {
  final String nameProduct;
  final String typeProduct;
  final String image;
  final String price;
  final int productID;
  final double cashback;

  const RowSellerCard({
    super.key,
    required this.nameProduct,
    required this.typeProduct,
    required this.image,
    required this.price,
    required this.productID,
    required this.cashback,
  });

  @override
  State<RowSellerCard> createState() => _RowSellerCardState();
}

class _RowSellerCardState extends State<RowSellerCard> {
  int count = 0;
  bool deleteFromBasket = false;

  late FloatingBloc fab_bloc;

  @override
  void initState() {
    fab_bloc = getIt<FloatingBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        border: Border.all(color: ColorHelper.brown08),
        borderRadius: BorderRadius.circular(20.r),
        color: ColorHelper.brown08,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 19.w,
          vertical: 19.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        if (Platform.isIOS) {
                          return Center(
                              child: CupertinoActivityIndicator(
                            radius: 15.r,
                            color: ColorHelper.brown08,
                          ));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                                color: ColorHelper.brown08),
                          );
                        }
                      },
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 10.r,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 13.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Text(
                        widget.nameProduct,
                        style: TextStyleHelper.forElementInfoSelNameProduct,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        widget.typeProduct,
                        style: TextStyleHelper.forElementInfoSelTypeProduct,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Spacer(),
                          Text(
                            "${widget.price} сом / ",
                            style: TextStyleHelper.forSellerPrice,
                          ),
                          Text(
                            "+ ${widget.cashback}",
                            style: TextStyleHelper.forPoint,
                          ),
                          SvgPicture.asset("assets/icons/coin.svg")
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () {
                          if (count > 0 && deleteFromBasket == false) {
                            count--;
                          }

                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.white),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(23, 69, 59, 0.25),
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: Offset(1, 4),
                              )
                            ],
                          ),
                          alignment: Alignment.center,
                          width: 25.r,
                          height: 25.r,
                          child: Icon(
                            Icons.remove,
                            color: ColorHelper.brown08,
                            size: 20.r,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.white),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(23, 69, 59, 0.25),
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: Offset(1, 4), //New
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        width: 40.r,
                        height: 25.r,
                        child: Text('$count'),
                      ),
                      SizedBox(width: 10.w),
                      InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () {
                          if (count < 99 && deleteFromBasket == false) {
                            count++;
                          }

                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.white),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(23, 69, 59, 0.25),
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: Offset(1, 4), //New
                              )
                            ],
                          ),
                          alignment: Alignment.center,
                          width: 25.r,
                          height: 25.r,
                          child: Icon(
                            Icons.add,
                            color: ColorHelper.brown08,
                            size: 20.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: () {
                      if (count != 0) {
                        if (deleteFromBasket == false) {
                          Constants.totalBasket.add(
                            BasketModel(
                              price: widget.price,
                              productID: widget.productID,
                              amount: count,
                              cashback: widget.cashback,
                              productName: widget.nameProduct,
                            ),
                          );
                          log('Constants.totalBasket add == ${Constants.totalBasket}');

                          if (Constants.totalBasket.isNotEmpty) {
                            fab_bloc.add(ShowFABEvent());
                          }

                          Exceptions.showFlushbar(
                            'Успешно добавлено',
                            context: context,
                            isSuccess: true,
                            flushbarPosition: FlushbarPosition.TOP,
                          );

                          setState(() {});
                        } else {
                          log('Constants.totalBasket before remove == ${Constants.totalBasket}');

                          Constants.totalBasket.removeWhere((element) =>
                              element.productID == widget.productID);

                          log('Constants.totalBasket after remove == ${Constants.totalBasket}');
                          if (Constants.totalBasket.isEmpty) {
                            fab_bloc.add(HideFABEvent());
                          }

                          Exceptions.showFlushbar(
                            'Успешно удалено',
                            context: context,
                            isSuccess: true,
                            flushbarPosition: FlushbarPosition.TOP,
                          );

                          count = 0;
                          setState(() {});
                        }

                        deleteFromBasket = !deleteFromBasket;
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(23, 69, 59, 0.25),
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(1, 4), //New
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      width: 40.w,
                      height: 25.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            deleteFromBasket
                                ? 'Удалить из корзины'
                                : 'Добавить в корзину',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11.sp),
                          ),
                          const Spacer(),
                          deleteFromBasket
                              ? Icon(
                                  Icons.delete_outline_rounded,
                                  color: ColorHelper.brown08,
                                  size: 18.r,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/market.svg",
                                  height: 18.r,
                                ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
