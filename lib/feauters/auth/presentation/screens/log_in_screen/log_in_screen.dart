import 'package:cashback/feauters/auth/presentation/screens/forgot_password_screen/forgot_passwor_screen.dart';
import 'package:cashback/feauters/catalog/presentation/screens/catalog_choose_screen/catalog_choose_screen.dart';
import 'package:cashback/feauters/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:cashback/feauters/seller_catalog/presentation/screens/seller_catalog_screen/seller_catalog_screen.dart';
import 'package:cashback/internal/helpers/components/custom_flushbar.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

import 'package:cashback/feauters/auth/presentation/widgets/arrow_back_card.dart';
import 'package:cashback/feauters/auth/presentation/widgets/text_field_card.dart';
import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/constants.dart';
import '../../../../../internal/helpers/utils.dart';
import '../../logic/bloc/auth_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController passwordController = TextEditingController();
  late AuthBloc bloc;
  late ProfileBloc pbloc;
  final MaskedTextController phoneController =
      MaskedTextController(mask: '(000)-000-000');
  ValueNotifier<bool> enabledButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    Constants.isTFEmty = false;
    pbloc = getIt<ProfileBloc>();
    bloc = getIt<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 0.8.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/icons/minilogo.svg',
                  )
                ],
              ),
              SizedBox(height: 50.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ArrowBackCard(),
                    SizedBox(height: 11.5.h),
                    Container(
                      padding: EdgeInsets.only(
                        top: 49.h,
                        bottom: 31.h,
                      ),
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: Constants.isUser
                            ? ColorHelper.green08
                            : ColorHelper.red08,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            Text('Добро пожаловать в cashback-сервис FELIZ',
                                textAlign: TextAlign.center,
                                style: TextStyleHelper.forAuthInfoL),
                            SizedBox(height: 29.h),
                            Text(
                              'Введите свои данные',
                              textAlign: TextAlign.center,
                              style: TextStyleHelper.forAuthInfoS,
                            ),
                            SizedBox(height: 20.h),
                            TextField(
                              onChanged: (value) {
                                if (phoneController.text.length == 13 &&
                                    passwordController.text.isNotEmpty) {
                                  enabledButton.value = true;
                                } else if (passwordController.text.isEmpty &&
                                    phoneController.text.isEmpty) {
                                  enabledButton.value = false;
                                } else {
                                  enabledButton.value = false;
                                }
                              },
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              cursorColor: ColorHelper.grey07,
                              style: TextStyle(color: ColorHelper.grey07),
                              decoration: InputDecoration(
                                hintText: '(000)-000-000',
                                hintStyle: TextStyleHelper.forTextField,
                                contentPadding: EdgeInsets.only(
                                  top: 17.h,
                                  left: 30.w,
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    right: 5.w,
                                    top: 17.h,
                                    left: 40.w,
                                  ),
                                  child: Text(
                                    '+996',
                                    style: TextStyleHelper.forTextField,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: ColorHelper.grey07,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: ColorHelper.grey07,
                                  ),
                                ),
                              ),
                            ),
                            TextFieldCard(
                              onChange: (value) {
                                if (phoneController.text.length == 13 &&
                                    passwordController.text.isNotEmpty) {
                                  enabledButton.value = true;
                                } else if (passwordController.text.isEmpty &&
                                    phoneController.text.isEmpty) {
                                  enabledButton.value = false;
                                } else {
                                  enabledButton.value = false;
                                }
                              },
                              controller: passwordController,
                              title: 'Пароль',
                              type: TextInputType.visiblePassword,
                              isPassword: true,
                            ),
                            SizedBox(height: 5.h),
                            InkWell(
                              onTap: () {
                                customNavigatorPush(
                                  context,
                                  ForgotPasswordScreen(),
                                );
                              },
                              child: Text(
                                'Забыли пароль?',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 10.sp,
                                  color: ColorHelper.grey07,
                                ),
                              ),
                            ),
                            SizedBox(height: 23.h),
                            MultiBlocListener(
                              listeners: [
                                BlocListener<AuthBloc, AuthState>(
                                    bloc: bloc,
                                    listener: (context, state) {
                                      if (state is SuccessSellerLoginState) {
                                        customNavigatorPushAndRemove(
                                            context,
                                            SellerCatalogScreen(
                                              branch: state.sellerModel.branch!
                                                  .toInt(),
                                            ));
                                      }
                                    }),
                                BlocListener<AuthBloc, AuthState>(
                                  bloc: bloc,
                                  listener: (context, state) {
                                    if (state is AuthLoadingState) {
                                      SmartDialog.showLoading(
                                          msg: 'Загрузка...');
                                    }

                                    if (state is SuccessLogInState) {
                                      SmartDialog.dismiss();

                                      if (state.loginModel.isStaff == true) {
                                        bloc.add(GetSellerEvent(
                                          id: state.loginModel.id!.toInt(),
                                        ));
                                      } else {
                                        customNavigatorPushAndRemove(
                                            context, CatalogChooseScreen());
                                      }
                                    }

                                    if (state is AuthErrorState) {
                                      SmartDialog.dismiss();

                                      Exceptions.showFlushbar(
                                        state.error.message.toString(),
                                        context: context,
                                      );
                                    }
                                  },
                                ),
                              ],
                              child: ValueListenableBuilder<bool>(
                                valueListenable: enabledButton,
                                builder: (BuildContext context, bool value,
                                        Widget? child) =>
                                    CustomButtonCard(
                                  onPressed: () {
                                    if (phoneController.text.isNotEmpty &&
                                        passwordController.text.isNotEmpty) {
                                      bloc.add(LogInEvent(
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                      ));
                                    } else {
                                      Exceptions.showFlushbar(
                                        'Заполните все поля',
                                        context: context,
                                      );
                                    }
                                  },
                                  backColor: enabledButton.value
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                  title: 'ВОЙТИ',
                                  width: 98.w,
                                  height: 25.h,
                                  bRadius: 10.r,
                                  color: Constants.isUser
                                      ? ColorHelper.green1
                                      : ColorHelper.red1,
                                  textStyle: TextStyleHelper.forClientButton,
                                  isGreen: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
