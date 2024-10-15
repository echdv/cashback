import 'package:cashback/feauters/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:cashback/feauters/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:cashback/feauters/profile/presentation/screens/profile_redact_screen/profile_redact_screen.dart';
import 'package:cashback/feauters/profile/presentation/widgets/CustomProfileText.dart';
import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/components/custom_flushbar.dart';
import 'package:cashback/internal/helpers/splash_screen.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/components/navbar.dart';
import '../../../../../internal/helpers/shimmer/profile_shimmer_card.dart';
import '../../../../../internal/helpers/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthBloc authBloc;
  late ProfileBloc bloc;

  @override
  void initState() {
    bloc = getIt<ProfileBloc>();
    authBloc = getIt<AuthBloc>();

    bloc.add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: Text(
          "ПРОФИЛЬ",
          style: TextStyleHelper.forAppBar,
        ),
        actions: [
          SizedBox(
              height: 58.h,
              width: 58.w,
              child: SvgPicture.asset("assets/icons/logo_appbar.svg")),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      body: Column(
        children: [
          BlocListener<ProfileBloc, ProfileState>(
            bloc: bloc,
            listener: (context, state) {
              print('state == $state');
              if (state is SuccessProfileDeleteState) {
                customNavigatorPushAndRemove(context, SplashScreen());
                SmartDialog.dismiss();
              }

              if (state is ProfileErrorState) {
                SmartDialog.dismiss();

                Exceptions.showFlushbar(
                  state.error.message ?? '',
                  context: context,
                );
              }
            },
            child: ElevatedButton(
              onPressed: () {
                SmartDialog.show(
                    clickMaskDismiss: false,
                    builder: (_) {
                      return Container(
                        padding: EdgeInsets.all(20).r,
                        height: 215.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20).r,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'вы уверены что хотите удалить свой аккаунт?',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15.sp,
                                color: ColorHelper.green08,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'вы не можете отменить это действие в дальнейшем',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15.sp,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SmartDialog.dismiss();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size.fromWidth(120.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10).r,
                                    ),
                                    backgroundColor: ColorHelper.green08,
                                  ),
                                  child: Text(
                                    'Отменить',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    bloc.add(DeleteProfileEvent());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size.fromWidth(120.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10).r,
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                  child: Text(
                                    'Удалить',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: Size.fromWidth(209.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10).r,
                ),
              ),
              child: Text('УДАЛИТЬ'),
            ),
          ),
          BlocConsumer<ProfileBloc, ProfileState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is ProfileErrorState) {
                Exceptions.showFlushbar(state.error.message.toString(),
                    context: context);
              }
            },
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return const ProfileShimmerCard();
              }
              if (state is ProfileErrorState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.w),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      Container(
                        padding: EdgeInsets.only(
                          top: 75.h,
                          left: 30.w,
                          right: 30.w,
                          bottom: 30.h,
                        ),
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: ColorHelper.green08,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Изменить",
                                        style: TextStyle(
                                          color: ColorHelper.green08,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/Pen.svg",
                                        // ignore: deprecated_member_use
                                        color: ColorHelper.green08,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            const CustomProfileText(
                              isError: true,
                              flex1: 2,
                              flex2: 9,
                              title: 'Имя:',
                              info: 'Ошибка',
                            ),
                            Container(),
                            SizedBox(height: 20.h),
                            const CustomProfileText(
                              isError: true,
                              flex1: 10,
                              flex2: 9,
                              title: 'Номер телефона:',
                              info: 'Ошибка',
                            ),
                            SizedBox(height: 20.h),
                            ElevatedButton.icon(
                              onPressed: () {
                                bloc.add(GetProfileEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  backgroundColor: Colors.white),
                              label: Text(
                                'повторить',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorHelper.green08,
                                  fontFamily: 'Lato',
                                ),
                              ),
                              icon: Icon(
                                Icons.refresh_outlined,
                                color: ColorHelper.green08,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state is ProfileLoadedState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.w),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      Container(
                        padding: EdgeInsets.only(
                          top: 75.h,
                          left: 30.w,
                          right: 30.w,
                          bottom: 30.h,
                        ),
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: ColorHelper.green08,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    customNavigatorPush(
                                        context,
                                        ProfileRedactScreen(
                                            username:
                                                state.profileModel.username ??
                                                    ''));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Изменить",
                                        style: TextStyle(
                                          color: ColorHelper.green08,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/Pen.svg",
                                        // ignore: deprecated_member_use
                                        color: ColorHelper.green08,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            CustomProfileText(
                              flex1: 2,
                              flex2: 9,
                              title: 'Имя:',
                              info: state.profileModel.username ?? '',
                            ),
                            Container(),
                            SizedBox(height: 20.h),
                            CustomProfileText(
                              flex1: 10,
                              flex2: 9,
                              title: 'Номер телефона:',
                              info: state.profileModel.phoneNumber ?? '',
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(height: 54.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container();
            },
          ),
          SizedBox(height: 20.h),
          BlocListener<AuthBloc, AuthState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is AuthLoadingState) {
                SmartDialog.showLoading(msg: 'Загрузка...');
              }

              if (state is SuccessLogoutState) {
                SmartDialog.dismiss();

                customNavigatorPushAndRemove(context, SplashScreen());
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
              color: ColorHelper.green1,
              textStyle: TextStyleHelper.forClientButton,
              isGreen: true,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigator(currentPage: 3),
    );
  }
}
