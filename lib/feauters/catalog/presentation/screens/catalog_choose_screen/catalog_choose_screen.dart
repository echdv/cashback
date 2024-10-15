import 'dart:io';

import 'package:cashback/feauters/catalog/presentation/screens/catalog_screen/catalog_screen.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import '../../../../../internal/dependencies/get_it.dart';
import '../../../../../internal/helpers/components/custom_flushbar.dart';
import '../../../../../internal/helpers/components/navbar.dart';
import '../../../../../internal/helpers/constants.dart';
import '../../../../../internal/helpers/utils.dart';
import '../../logic/bloc/catalog_bloc.dart';

class CatalogChooseScreen extends StatefulWidget {
  const CatalogChooseScreen({super.key});

  @override
  State<CatalogChooseScreen> createState() => _CatalogChooseScreenState();
}

class _CatalogChooseScreenState extends State<CatalogChooseScreen> {
  late CatalogBloc bloc;

  @override
  void initState() {
    bloc = getIt<CatalogBloc>();

    bloc.add(GetBranchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Constants.isUser
                      ? SvgPicture.asset(
                          'assets/icons/minilogo.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/sellerlogo.svg',
                        ),
                ],
              ),
          SizedBox(
            height: 98.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Выберите филиал",
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 26.sp,
                color: ColorHelper.green08,
              ),
            ),
          ),
          SizedBox(height: 43.h),
          Expanded(
            child: BlocConsumer<CatalogBloc, CatalogState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is CatalogErroeState) {
                  Exceptions.showFlushbar(state.error.message.toString(),
                      context: context);
                }
              },
              builder: (context, state) {
                if (state is CatalogLoadingState) {
                  if (Platform.isIOS) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 150),
                      child: CupertinoActivityIndicator(
                        radius: 15.r,
                        color: ColorHelper.green06,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 150),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: ColorHelper.green06,
                        ),
                      ),
                    );
                  }
                }

                if (state is CatalogErroeState) {
                  return Column(
                    children: [
                      CustomButtonCard(
                        onPressed: () {},
                        title: "Ошибка",
                        backColor: ColorHelper.green08,
                        width: 300.w,
                        height: 100.h,
                        bRadius: 20.r,
                        color: ColorHelper.green08,
                        textStyle: TextStyleHelper.forChooseBranch,
                        isGreen: true,
                      ),
                      SizedBox(height: 150.h),
                      SizedBox(
                        height: 50.h,
                        width: 180.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              backgroundColor: ColorHelper.green08,
                            ),
                            onPressed: () {
                              bloc.add(GetBranchEvent());
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                ),
                                const Text(
                                  "Повторить",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.replay_rounded,
                                  color: ColorHelper.white1,
                                )
                              ],
                            )),
                      )
                    ],
                  );
                }

                if (state is BranchLoadedState) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    itemCount: state.branchModel.length,
                    itemBuilder: (context, index) {
                      return CustomButtonCard(
                        onPressed: () {
                          customNavigatorPushAndRemove(
                            context,
                            CatalogScreen(
                              address: state.branchModel[index].address ?? '',
                              id: state.branchModel[index].id ?? 0,
                            ),
                          );
                        },
                        backColor: ColorHelper.green08,
                        width: 300.w,
                        height: 100.h,
                        title: state.branchModel[index].name ?? '',
                        bRadius: 20.r,
                        color: Colors.white,
                        textStyle: TextStyleHelper.forChooseBranch,
                        isGreen: true,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 47.h),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigator(currentPage: 0),
    );
  }
}
