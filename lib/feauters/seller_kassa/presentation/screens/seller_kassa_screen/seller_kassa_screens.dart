import 'dart:developer';
import 'dart:io';

import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:cashback/internal/helpers/seller_navbar.dart';
import 'package:cashback/internal/helpers/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/components/custom_flushbar.dart';
import '../../../../../internal/helpers/text_style_helper.dart';
import '../../../../../internal/helpers/utils.dart';
import '../../../../auth/presentation/logic/bloc/auth_bloc.dart';
import '../../logic/bloc/seller_kassa_bloc.dart';
import '../../widgets/custom_textfield_kassa.dart';
import '../seller_kassa_info_screen/seller_kassa_info_screen.dart';

class SellerKassaScreen extends StatefulWidget {
  const SellerKassaScreen({super.key});

  @override
  State<SellerKassaScreen> createState() => _SellerKassaScreenState();
}

class _SellerKassaScreenState extends State<SellerKassaScreen> {
  late AuthBloc authBloc;
  late SellerKassaBloc bloc;

  late ScrollController scrollController;
  late int currentCounter;
  int totalCounter = 0;
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    log(' dateList == ${Constants.dateList}');
    print('uraaaaa');
    bloc = getIt<SellerKassaBloc>();
    authBloc = getIt<AuthBloc>();
    Constants.dateList = [];
    Constants.dateList.clear();

    bloc.add(GetSellerKassaDateEvent(
      date: '',
      isFirstCall: true,
      page: 1,
    ));

    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (Constants.dateList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        print('uraaa');
        isLoading = true;

        if (isLoading && currentCounter < totalCounter) {
          currentPage = currentPage + 1;

          bloc.add(GetSellerKassaDateEvent(
            date: '',
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
        titleSpacing: 0.w,
        leading: SizedBox(width: 10.w),
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
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: Column(
          children: [
            BlocListener<AuthBloc, AuthState>(
              bloc: authBloc,
              listener: (context, state) {
                if (state is AuthLoadingState) {
                  SmartDialog.showLoading(msg: 'Загрузка...');
                }

                if (state is SuccessLogoutState) {
                  SmartDialog.dismiss();

                  customNavigatorPush(context, SplashScreen());
                }

                if (state is AuthErrorState) {
                  SmartDialog.dismiss();

                  Exceptions.showFlushbar(
                    state.error.message ?? '',
                    context: context,
                  );
                }
              },
              child: CustomButtonCard(
                onPressed: () {
                  authBloc.add(LogoutEvent());
                },
                backColor: Colors.white,
                bRadius: 10.r,
                height: 30.h,
                title: 'ВЫЙТИ',
                width: 209.w,
                color: ColorHelper.brown08,
                textStyle: TextStyleHelper.forClientSellerButton,
                isGreen: true,
              ),
            ),
            SizedBox(height: 22.h),
            const CustomTextFieldKassa(),
            SizedBox(height: 20.h),
            BlocConsumer<SellerKassaBloc, SellerKassaState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is SellerKassaDateLoadedState) {
                  totalCounter = state.sellerKassaDateModel.count ?? 0;

                  Constants.dateList
                      .addAll(state.sellerKassaDateModel.results ?? []);
                  currentCounter = Constants.dateList.length;

                  isLoading = false;
                }
              },
              builder: (context, state) {
                print(state);
                if (state is SellerKassaErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h),
                        SizedBox(
                            width: 200.w,
                            height: 200.h,
                            child: SvgPicture.asset(
                                "assets/icons/sellerIcon.svg")),
                        SizedBox(height: 30.h),
                        Text(
                          state.error.message ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyleHelper.forErrorSellerState,
                        ),
                        SizedBox(height: 30.h),
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
                              bloc.add(GetSellerKassaDateEvent(
                                date: '',
                                isFirstCall: true,
                                page: 1,
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

                if (state is SellerKassaAllLoadingState) {
                  if (Platform.isIOS) {
                    return Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Center(
                        child: CupertinoActivityIndicator(
                          radius: 15.r,
                          color: ColorHelper.red05,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: ColorHelper.red05,
                        ),
                      ),
                    );
                  }
                }

                if (state is SellerKassaDateLoadedState) {
                  if (Constants.dateList.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 70.h,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: ColorHelper.brown08,
                            size: 100.sp,
                          ),
                          Text(
                            'За данную дату не было совершено продаж',
                            textAlign: TextAlign.center,
                            style: TextStyleHelper.forErrorSellerState,
                          ),
                        ],
                      ),
                    );
                  }

                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        Constants.dateList.clear();

                        currentPage = 1;

                        bloc.add(GetSellerKassaDateEvent(
                          date: '',
                          isFirstCall: true,
                          page: 1,
                        ));
                      },
                      child: ListView.separated(
                        itemCount: Constants.dateList.length,
                        padding: EdgeInsets.only(top: 10.h),
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          String dateKey =
                              Constants.dateList[index].date.toString();

                          return InkWell(
                            onTap: () {
                              customNavigatorPush(
                                  context,
                                  SellerKassInfoScreen(
                                    minDate: dateKey.substring(0, 10),
                                  ));
                            },
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
                                        dateFormater(Constants
                                            .dateList[index].date
                                            .toString()),
                                        style: TextStyle(
                                          color: ColorHelper.brown08,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Constants.dateList[index].finalCost
                                            .toString(),
                                        style: TextStyle(
                                          color: ColorHelper.green1,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/coin.svg",
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            Constants
                                                .dateList[index].finalCashback
                                                .toString(),
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
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20.h);
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
      bottomNavigationBar: SellerNavBar(
        currentPage: 2,
      ),
    );
  }
}
