import 'dart:io';

import 'package:cashback/feauters/balance/presentation/screens/balance_info_screen/balance_info_screen.dart';
import 'package:cashback/feauters/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cashback/internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/components/navbar.dart';
import '../../../../../internal/helpers/utils.dart';
import '../../../data/models/sale_model.dart';
import '../../logic/bloc/sale_bloc.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  late ProfileBloc pBloc;
  late SaleBloc bloc;
  bool isLoading = false;

  late ScrollController scrollController;
  List<SaleResult> balanceList = [];
  late int currentCounter;
  int totalCounter = 0;

  int currentPage = 1;

  @override
  void initState() {
    bloc = getIt<SaleBloc>();
    pBloc = getIt<ProfileBloc>();
    bloc.add(GetSaleEvent(
      isFirstCall: true,
      page: currentPage,
    ));
    pBloc.add(GetProfileEvent());
    super.initState();

    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (balanceList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        print('uraaa');
        isLoading = true;

        if (isLoading && currentCounter < totalCounter) {
          currentPage = currentPage + 1;

          bloc.add(GetSaleEvent(
            isFirstCall: false,
            page: currentPage,
          ));
        }
      }
    }
  }

  @override
  void dispose() {
    bloc.close();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 53.w,
        backgroundColor: ColorHelper.green08,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        toolbarHeight: 139.h,
        title: Text(
          "БАЛАНС",
          style: TextStyleHelper.forAppBar,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              children: [
                BlocConsumer<ProfileBloc, ProfileState>(
                  bloc: pBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ProfileErrorState) {
                      return Text(
                        'Ошибка',
                        style: TextStyleHelper.forErrorPointL,
                      );
                    }

                    if (state is ProfileLoadingState) {
                      if (Platform.isIOS) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            radius: 15.r,
                            color: ColorHelper.yellow1,
                          ),
                        );
                      } else {
                        return Center(
                          child: SizedBox(
                            height: 25.r,
                            width: 25.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              color: ColorHelper.yellow1,
                            ),
                          ),
                        );
                      }
                    }

                    if (state is ProfileLoadedState) {
                      return Text(
                        '${state.profileModel.cashbackBalance}',
                        style: TextStyleHelper.forPointL,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(
                  width: 5.w,
                ),
                SvgPicture.asset('assets/icons/coin.svg'),
                SizedBox(width: 21.w),
              ],
            ),
          )
        ],
      ),
      body: BlocConsumer<SaleBloc, SaleState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is SaleLoadedState) {
            totalCounter = state.saleModel.count ?? 0;

            balanceList.addAll(state.saleModel.results ?? []);
            currentCounter = balanceList.length;

            isLoading = false;
          }
        },
        builder: (context, state) {
          if (state is SaleLoadingState) {
            if (Platform.isIOS) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: CupertinoActivityIndicator(
                    radius: 15.r,
                    color: ColorHelper.green06,
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: ColorHelper.green06,
                ),
              );
            }
          }
          print(state);

          if (state is SaleErrorSate) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  Container(
                      width: 200.w,
                      height: 200.h,
                      child: SvgPicture.asset("assets/icons/userIcon.svg")),
                  SizedBox(height: 30.h),
                  Text(
                    state.error.message ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyleHelper.forErrorState,
                  ),
                  SizedBox(height: 70.h),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        backgroundColor: ColorHelper.green08,
                      ),
                      onPressed: () {
                        pBloc.add(GetProfileEvent());
                        bloc.add(
                            GetSaleEvent(isFirstCall: true, page: currentPage));
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

          if (state is SaleLoadedState) {
            if (state.saleModel.results!.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 170.h,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: ColorHelper.green08,
                      size: 100.sp,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Здесь пока что пусто',
                        textAlign: TextAlign.center,
                        style: TextStyleHelper.forErrorState,
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                balanceList.clear();

                currentPage = 1;

                bloc.add(GetSaleEvent(
                  isFirstCall: true,
                  page: 1,
                ));
              },
              child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 25.h,
                ),
                itemCount: balanceList.length,
                itemBuilder: (context, index) {
                  if (index >= balanceList.length - 1 &&
                      balanceList.length != totalCounter) {
                    return Platform.isIOS
                        ? CupertinoActivityIndicator(radius: 15.r)
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  }

                  return InkWell(
                    onTap: () {
                      customNavigatorPush(
                        context,
                        BalanceInfoScreen(
                          date: balanceList[index].date.toString(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 33.w,
                        right: 18.w,
                      ),
                      height: 40.h,
                      width: 334.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7.r,
                            offset: const Offset(0, 4),
                            color: ColorHelper.green05,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          width: 0.4.r,
                          color: ColorHelper.green08,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              dateFormater(balanceList[index].date.toString()),
                              style: TextStyleHelper.forDate,
                            ),
                          ),
                          Text('+ ${balanceList[index].finalCashback} ',
                              style: TextStyleHelper.plPoint),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
              ),
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: BottomNavigator(currentPage: 1),
    );
  }
}
