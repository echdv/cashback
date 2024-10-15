// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:cashback/internal/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cashback/internal/dependencies/get_it.dart';

import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/seller_navbar.dart';
import '../../../../../internal/helpers/text_style_helper.dart';
import '../../../data/model/seller_kassa_model.dart';
import '../../logic/bloc/seller_kassa_bloc.dart';

class SellerKassInfoScreen extends StatefulWidget {
  final String minDate;

  const SellerKassInfoScreen({
    Key? key,
    required this.minDate,
  }) : super(key: key);

  @override
  State<SellerKassInfoScreen> createState() => _SellerKassInfoState();
}

class _SellerKassInfoState extends State<SellerKassInfoScreen> {
  late SellerKassaBloc bloc;
  late ScrollController scrollController;
  late int currentCounter;
  int totalCounter = 1;
  int currentPage = 1;
  bool isLoading = false;
  final List<SaleResultSeller> infoList = [];

  @override
  void initState() {
    bloc = getIt<SellerKassaBloc>();
    bloc.add(GetSellerKassaInfoEvent(
      minDate: widget.minDate,
      isFirstCall: true,
    ));
    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (infoList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        print('uraaa');
        isLoading = true;

        if (isLoading && currentCounter < totalCounter) {
          currentPage += 1;

          bloc.add(GetSellerKassaInfoEvent(
            minDate: widget.minDate,
            isFirstCall: false,
            page: currentPage,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Platform.isIOS
            ? InkWell(
                onTap: () {
                  Navigator.of(context).pop();

                  if (Constants.date.isEmpty) {
                    Constants.dateList = [];
                    Constants.dateList.clear();
                    bloc.add(
                      GetSellerKassaDateEvent(
                        date: '',
                        isFirstCall: true,
                        page: 1,
                      ),
                    );
                  } else {
                    Constants.dateList = [];
                    Constants.dateList.clear();
                    bloc.add(
                      GetSellerKassaDateEvent(
                        date: Constants.date,
                        isFirstCall: true,
                        page: 1,
                      ),
                    );
                  }
                },
                child: const Icon(Icons.arrow_back_ios),
              )
            : InkWell(
                onTap: () {
                  Navigator.pop(context);
                  if (Constants.date.isEmpty) {
                    Constants.dateList = [];
                    Constants.dateList.clear();
                    bloc.add(
                      GetSellerKassaDateEvent(
                        date: '',
                        isFirstCall: true,
                        page: 1,
                      ),
                    );
                  } else {
                    Constants.dateList = [];
                    Constants.dateList.clear();
                    bloc.add(
                      GetSellerKassaDateEvent(
                        date: Constants.date,
                        isFirstCall: true,
                        page: 1,
                      ),
                    );
                  }
                },
                child: const Icon(Icons.arrow_back),
              ),
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
            "КАССА",
            style: TextStyleHelper.forAppBar,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/logo_appbar.svg"),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: Column(
          children: [
            BlocConsumer<SellerKassaBloc, SellerKassaState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is SellerKassaInfoLoadedState) {
                  log('count === ${state.sellerKassaModel.count}');
                  totalCounter = state.sellerKassaModel.count ?? 0;
                  infoList.addAll(state.sellerKassaModel.results ?? []);

                  currentCounter = infoList.length;

                  isLoading = false;
                }
              },
              builder: (context, state) {
                print(state);
                if (state is SellerKassaLoadingState) {
                  if (Platform.isIOS) {
                    return Padding(
                      padding: EdgeInsets.only(top: 260.h),
                      child: Center(
                        child: CupertinoActivityIndicator(
                          radius: 15.r,
                          color: ColorHelper.red05,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 260.h),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: ColorHelper.red05,
                        ),
                      ),
                    );
                  }
                }

                if (state is SellerKassaErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.error.message ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyleHelper.forErrorSellerState,
                        ),
                        SizedBox(height: 200.h),
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
                              bloc.add(GetSellerKassaDateEvent());
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

                if (state is SellerKassaInfoLoadedState) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        bloc.add(
                          GetSellerKassaInfoEvent(
                            minDate: widget.minDate,
                            isFirstCall: false,
                            page: 1,
                          ),
                        );
                      },
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: infoList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 22.h,
                              ),
                              Text(
                                infoList[index].clientPhoneNumber ?? "client",
                                style: TextStyleHelper.forInfoKassaUserNumPhone,
                              ),
                              SizedBox(height: 5.h),
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorHelper.brown08,
                                    borderRadius: BorderRadius.circular(20.r)),
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                width: 1.sw,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 22,
                                            child: Text(
                                              'Наименование',
                                              style: TextStyleHelper.basket1,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 16,
                                            child: Text(
                                              'Стоимость',
                                              style: TextStyleHelper.basket1,
                                            ),
                                          ),
                                          Text(
                                            'Кэшбек',
                                            style: TextStyleHelper.basket1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      itemCount:
                                          infoList[index].products.length,
                                      itemBuilder: (context, idx) {
                                        List<ProductElement> listProduct =
                                            infoList[index].products;
                                        return ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              listProduct[idx].amount ?? 0,
                                          separatorBuilder: (context, ix) =>
                                              SizedBox(height: 5),
                                          itemBuilder: (context, i) => Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 110.w,
                                                child: Text(
                                                  listProduct[idx]
                                                      .product
                                                      .toString(),
                                                  style:
                                                      TextStyleHelper.basket2,
                                                ),
                                              ),
                                              SizedBox(width: 35.h),
                                              Expanded(
                                                flex: 22,
                                                child: Text(
                                                  '${listProduct[idx].totalCost! / double.parse(listProduct[idx].amount.toString())}',
                                                  style:
                                                      TextStyleHelper.basket2,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 11,
                                                child: Text(
                                                  (listProduct[idx]
                                                              .totalCashback! /
                                                          double.parse(
                                                              listProduct[idx]
                                                                  .amount
                                                                  .toString()))
                                                      .toStringAsFixed(2),
                                                  style:
                                                      TextStyleHelper.basket2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 6.h);
                                      },
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Итого',
                                            style: TextStyleHelper.basket1,
                                          ),
                                          SizedBox(width: 105.w),
                                          Expanded(
                                            flex: 10,
                                            child: Text(
                                              double.parse(infoList[index]
                                                      .finalCost
                                                      .toString())
                                                  .toStringAsFixed(1),
                                              style: TextStyleHelper.basket1,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              double.parse(infoList[index]
                                                      .finalCashback
                                                      .toString())
                                                  .toStringAsFixed(1),
                                              style: TextStyleHelper.basket1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    if (infoList[index].fromBalanceAmount ==
                                        '0.0')
                                      Text(
                                        'Баллов снятно: ${double.parse(infoList[index].fromBalanceAmount.toString()).toStringAsFixed(1)}',
                                        style: TextStyleHelper.basket1,
                                      )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 16.w,
                          );
                        },
                      ),
                    ),
                  );
                }

                return Container();
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: SellerNavBar(
        currentPage: 2,
      ),
    );
  }
}
