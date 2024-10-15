import 'dart:io';

import 'package:cashback/feauters/catalog/presentation/screens/catalog_info_screen/catalog_info_screen.dart';
import 'package:cashback/feauters/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/dependencies/get_it.dart';

import '../../../../../internal/helpers/components/navbar.dart';
import '../../logic/bloc/catalog_bloc.dart';

class CatalogScreen extends StatefulWidget {
  final String address;
  final int id;
  const CatalogScreen({
    super.key,
    required this.address,
    required this.id,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late CatalogBloc bloc;
  late ProfileBloc pBloc;
  @override
  void initState() {
    Constants.totalBasket.clear();
    bloc = getIt<CatalogBloc>();
    bloc.add(GetCategoryEvent(id: widget.id));
    pBloc = getIt<ProfileBloc>();

    pBloc.add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 53.w,
        centerTitle: false,
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
            SizedBox(height: 39.h),
            SizedBox(height: 30.h),
            BlocBuilder<CatalogBloc, CatalogState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is CatalogErroeState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: 200.w,
                          height: 200.h,
                          child: SvgPicture.asset(
                            "assets/icons/userIcon.svg",
                          ),
                        ),
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
                              bloc.add(GetCategoryEvent(id: widget.id));
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

                if (state is CatalogLoadingState) {
                  if (Platform.isIOS) {
                    return Padding(
                      padding: EdgeInsets.only(top: 170.h),
                      child: Center(
                        child: CupertinoActivityIndicator(
                          radius: 15.r,
                          color: ColorHelper.green06,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 170.h),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: ColorHelper.green06,
                        ),
                      ),
                    );
                  }
                }

                if (state is CatalogLoadedState) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {},
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
                              customNavigatorPush(
                                context,
                                CatalogInfoScreen(
                                  address:
                                      state.categoryModel.address.toString(),
                                  listCategory: state
                                      .categoryModel.listCategories![index],
                                ),
                              );
                            },
                            child: Container(
                              width: 140.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromRGBO(23, 69, 59, 0.25),
                                    blurRadius: 10.r,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: ColorHelper.green08,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                state.categoryModel.listCategories![index]
                                        .name ??
                                    '',
                                textAlign: TextAlign.center,
                                style: TextStyleHelper.forCatalogCard,
                              ),
                            ),
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
