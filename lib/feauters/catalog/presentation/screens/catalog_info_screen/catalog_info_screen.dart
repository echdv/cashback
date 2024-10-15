import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/feauters/catalog/presentation/logic/bloc/catalog_bloc.dart';
import 'package:cashback/feauters/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/dependencies/get_it.dart';
import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/components/navbar.dart';
import '../../../data/model/catalog_model.dart';

class CatalogInfoScreen extends StatefulWidget {
  final String address;
  final ListCategorys listCategory;

  const CatalogInfoScreen({
    super.key,
    required this.address,
    required this.listCategory,
  });

  @override
  State<CatalogInfoScreen> createState() => _CatalogInfoScreenState();
}

class _CatalogInfoScreenState extends State<CatalogInfoScreen> {
  late CatalogBloc bloc;
  late ProfileBloc pBloc;

  @override
  void initState() {
    bloc = getIt<CatalogBloc>();
    pBloc = getIt<ProfileBloc>();
    pBloc.add(GetProfileEvent());
    bloc.add(GetProductEvent(id: widget.listCategory.id ?? 0));
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
              "КАТАЛОГ",
              style: TextStyleHelper.forAppBar,
            ),
            Text(
              widget.address,
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  bloc: pBloc,
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

                    return Text(
                      '0 ',
                      style: TextStyleHelper.forPointL,
                    );
                  },
                ),
                SizedBox(width: 5.w),
                SvgPicture.asset('assets/icons/coin.svg'),
                SizedBox(width: 21.w),
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
              height: 39.h,
            ),
            SizedBox(
              height: 21.h,
            ),
            BlocBuilder<CatalogBloc, CatalogState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is CatalogLoadingState) {
                  if (Platform.isIOS) {
                    return Padding(
                      padding: EdgeInsets.all(150.r),
                      child: CupertinoActivityIndicator(
                        radius: 15.r,
                        color: ColorHelper.green06,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(150.r),
                      child: SizedBox(
                        height: 25.r,
                        width: 25.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.r,
                          color: ColorHelper.green06,
                        ),
                      ),
                    );
                  }
                }

                if (state is CatalogErroeState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h),
                        SizedBox(
                            width: 200.w,
                            height: 200.h,
                            child:
                                SvgPicture.asset("assets/icons/userIcon.svg")),
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
                              bloc.add(GetProductEvent(
                                  id: widget.listCategory.id ?? 0));
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

                if (state is ProductLoadedState) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        bloc.add(GetProductEvent(
                          id: widget.listCategory.id ?? 0,
                        ));
                      },
                      child: ListView.separated(
                        itemCount: state.productModel.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 1.sw,
                            height: 110.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: ColorHelper.green05,
                                width: 0.8.w,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromRGBO(23, 69, 59, 0.25),
                                  blurRadius: 4.r,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 15.h,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 60.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      color: ColorHelper.green02,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          state.productModel[index].image ?? '',
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) {
                                        if (Platform.isIOS) {
                                          return Center(
                                            child: CupertinoActivityIndicator(
                                              radius: 10.r,
                                              color: ColorHelper.green06,
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: SizedBox(
                                              height: 25.r,
                                              width: 25.r,
                                              child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                                strokeWidth: 3.r,
                                                color: ColorHelper.green06,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
                                        size: 10.r,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 13.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        width: 180.w,
                                        child: Text(
                                          state.productModel[index].title ?? '',
                                          style:
                                              TextStyleHelper.forElementInfoL,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      SizedBox(
                                        width: 130.w,
                                        child: Text(
                                          state.productModel[index]
                                                  .typeProduct ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyleHelper.forElementInfoS,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 0.58.sw,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Spacer(),
                                            Text(
                                              "${state.productModel[index].price}сом/",
                                              style: TextStyleHelper.forPrice,
                                            ),
                                            Text(
                                              "+${state.productModel[index].cashback}",
                                              style: TextStyleHelper.forPoint,
                                            ),
                                            SizedBox(width: 2.w),
                                            SvgPicture.asset(
                                                "assets/icons/coin.svg")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 21.h,
                          );
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
      bottomNavigationBar: BottomNavigator(currentPage: 0),
    );
  }
}
