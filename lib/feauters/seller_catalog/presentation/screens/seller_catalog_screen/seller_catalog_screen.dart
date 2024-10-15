import 'dart:developer';
import 'dart:io';

import 'package:cashback/feauters/seller_catalog/presentation/logic/bloc/seller_catalog_bloc.dart';
import 'package:cashback/feauters/seller_catalog/presentation/screens/seller_catalog_info_screen/seller_catalog_info_screen.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:cashback/internal/helpers/seller_navbar.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../internal/dependencies/get_it.dart';
import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/text_style_helper.dart';

class SellerCatalogScreen extends StatefulWidget {
  final int? branch;
  // final SellerCategoryModel sellerCategoryModel;

  const SellerCatalogScreen({
    super.key,
    this.branch,
  });

  @override
  State<SellerCatalogScreen> createState() => _SellerCatalogScreenState();
}

class _SellerCatalogScreenState extends State<SellerCatalogScreen> {
  late SellerCatalogBloc bloc;

  @override
  void initState() {
    bloc = getIt<SellerCatalogBloc>();
    bloc.add(SellerGetCategoryEvent());
    Constants.totalBasket.clear();
    Constants.totalBasket = [];
    log("list == ${Constants.totalBasket}");
    super.initState();
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
          // you can forcefully translate values left side using Transform
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
            SizedBox(
              height: 100.h,
            ),
            BlocConsumer<SellerCatalogBloc, SellerCatalogState>(
              bloc: bloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SellerCatalogLoadingState) {
                  if (Platform.isIOS) {
                    return Padding(
                      padding: EdgeInsets.only(top: 150.h),
                      child: Center(
                        child: CupertinoActivityIndicator(
                          radius: 15.r,
                          color: ColorHelper.red05,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 150.h),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: ColorHelper.red05,
                        ),
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
                            child: SvgPicture.asset(
                                "assets/icons/sellerIcon.svg")),
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
                              bloc.add(SellerGetCategoryEvent());
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

                if (state is SellerCatalogLoadedState) {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: state.categoryModel.listCategories!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 54,
                        mainAxisSpacing: 53,
                        childAspectRatio: 2,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // context.push('/sellerCatalogInfoScreen', extra: {
                            //   "id": state
                            //       .categoryModel.listCategories![index].id!
                            //       .toInt(),
                            // });

                            customNavigatorPush(
                              context,
                              SellerCatalogInfoScreen(
                                id: state
                                    .categoryModel.listCategories![index].id!
                                    .toInt(),
                              ),
                            );
                          },
                          child: Container(
                            width: 140.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(23, 69, 59, 0.25),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                  offset: Offset(1, 4),
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: ColorHelper.brown08,
                                width: 0.7.w,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              state.categoryModel.listCategories![index].name
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyleHelper.forCatalogSellerCard,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: SellerNavBar(currentPage: 0,),
    );
  }
}
