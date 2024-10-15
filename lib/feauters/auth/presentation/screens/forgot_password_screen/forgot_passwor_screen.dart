import 'dart:developer';

import 'package:cashback/feauters/auth/presentation/screens/forgot_password_screen/sms_code_screen.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cashback/feauters/auth/presentation/widgets/arrow_back_card.dart';
import 'package:cashback/feauters/auth/presentation/widgets/text_field_card.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import '../../../../../internal/dependencies/get_it.dart';
import '../../../../../internal/helpers/components/custom_flushbar.dart';
import '../../../../../internal/helpers/utils.dart';
import '../../logic/bloc/auth_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final MaskedTextController phoneController =
      MaskedTextController(mask: '(000)-000-000');
  ValueNotifier<bool> enabledButton = ValueNotifier<bool>(false);

  late AuthBloc bloc;

  @override
  void initState() {
    bloc = getIt<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/icons/minilogo.svg',
              )
            ],
          ),
          SizedBox(height: 115.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ArrowBackCard(),
                SizedBox(height: 11.5.h),
                Container(
                  padding: EdgeInsets.only(
                    top: 40.h,
                    bottom: 30.h,
                  ),
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: ColorHelper.green08,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        Center(
                          child: Text('Введите свой номер телефона',
                              textAlign: TextAlign.center,
                              style: TextStyleHelper.forAuthInfoL),
                        ),
                        SizedBox(height: 5.h),
                        TextFieldCard(
                          onChange: (value) {
                            if (phoneController.text.length == 13) {
                              enabledButton.value = true;
                            } else {
                              enabledButton.value = false;
                            }
                          },
                          controller: phoneController,
                          title: '(000)-000-000',
                          type: TextInputType.emailAddress,
                          center: false,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              right: 5.w,
                              top: 20.h,
                              left: 45.w,
                            ),
                            child: Text(
                              '+996',
                              style: TextStyleHelper.forTextField,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        BlocListener<AuthBloc, AuthState>(
                          bloc: bloc,
                          listener: (context, state) {
                            if (state is AuthLoadingState) {
                              SmartDialog.showLoading(
                                msg: 'Загрузка...',
                              );
                            }

                            if (state is SuccessPhoneNumberCheckedState) {
                              SmartDialog.dismiss();
                              log('phone === ${phoneController.text}');

                              customNavigatorPush(
                                  context,
                                  EnterCodeScreen(
                                    phone: phoneController.text,
                                  ));
                            }

                            if (state is AuthErrorState) {
                              SmartDialog.dismiss();

                              Exceptions.showFlushbar(
                                state.error.message ?? '',
                                context: context,
                              );
                            }
                          },
                          child: ValueListenableBuilder<bool>(
                            valueListenable: enabledButton,
                            builder: (BuildContext context, bool value,
                                    Widget? child) =>
                                CustomButtonCard(
                              onPressed: () {
                                SmartDialog.showLoading(
                                  msg: 'Загрузка...',
                                );
                                if (!enabledButton.value) {
                                  SmartDialog.dismiss();

                                  Exceptions.showFlushbar(
                                      'Введите номер телефона',
                                      context: context);
                                }
                                if (enabledButton.value) {
                                  bloc.add(CheckPhoneNumberEvent(
                                    phone: phoneController.text,
                                  ));
                                }
                              },
                              backColor: enabledButton.value
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              title: 'Далее',
                              width: 100.w,
                              height: 15.h,
                              bRadius: 10.r,
                              color: ColorHelper.green1,
                              textStyle: TextStyleHelper.forClientButton,
                              isGreen: true,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
