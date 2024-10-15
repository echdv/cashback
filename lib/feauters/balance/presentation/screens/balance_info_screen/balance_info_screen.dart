import 'dart:io';

import 'package:cashback/feauters/balance/presentation/screens/balance_info_info_screen/balance_info_info_screen.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../internal/dependencies/get_it.dart';
import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/components/navbar.dart';
import '../../../../../internal/helpers/text_style_helper.dart';
import '../../../../profile/presentation/logic/bloc/profile_bloc.dart';
import '../../logic/bloc/sale_bloc.dart';

class BalanceInfoScreen extends StatefulWidget {
  final String date;
  const BalanceInfoScreen({
    super.key,
    required this.date,
  });

  @override
  State<BalanceInfoScreen> createState() => _BalanceInfoScreenState();
}

class _BalanceInfoScreenState extends State<BalanceInfoScreen> {
  late ProfileBloc pBloc;
  late SaleBloc bloc;

  @override
  void initState() {
    pBloc = getIt<ProfileBloc>();
    pBloc.add(GetProfileEvent());
    bloc = getIt<SaleBloc>();
    bloc.add(GetSaleInfoEvent(date: widget.date));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.w,
        backgroundColor: ColorHelper.green08,
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
              "БАЛАНС",
              style: TextStyleHelper.forAppBar,
            ),
          ],
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
        listener: (context, state) {},
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
                        bloc.add(GetSaleInfoEvent(date: widget.date));
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

          if (state is SaleInfoLoadedState) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 25.h,
              ),
              itemCount: state.saleInfoModel.results!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
          
                    customNavigatorPush(context, BalanceInfoInfoScreen(infoResult: state.saleInfoModel.results![index]));
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
                            timeFormater(state
                                .saleInfoModel.results![index].datetime
                                .toString()),
                            style: TextStyleHelper.forDate,
                          ),
                        ),
                        Text(
                          '+ ${state.saleInfoModel.results![index].finalCashback}',
                          style: TextStyleHelper.plPoint,
                        ),
                        if (state.saleInfoModel.results![index]
                                .fromBalanceAmount !=
                            '0.00')
                          Text(
                            ' / - ${state.saleInfoModel.results![index].fromBalanceAmount}',
                            style: TextStyleHelper.plPoint,
                          )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 20.h,
              ),
            );
          }
          return SizedBox();
        },
      ),
      bottomNavigationBar: BottomNavigator(currentPage: 1),
    );
  }
}
