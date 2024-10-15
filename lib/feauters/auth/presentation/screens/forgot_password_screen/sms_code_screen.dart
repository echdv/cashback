import 'dart:developer';

import 'package:cashback/feauters/auth/presentation/screens/log_in_screen/log_in_screen.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/dependencies/get_it.dart';

import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/components/custom_flushbar.dart';
import '../../../../../internal/helpers/constants.dart';
import '../../logic/bloc/auth_bloc.dart';
import '../../widgets/arrow_back_card.dart';
import '../../widgets/timer/custom_timer.dart';

class EnterCodeScreen extends StatefulWidget {
  final String phone;
  const EnterCodeScreen({super.key, required this.phone});

  @override
  State<EnterCodeScreen> createState() => _EnterSmsCodeScreenState();
}

class _EnterSmsCodeScreenState extends State<EnterCodeScreen> {
  final TextEditingController codeController = TextEditingController();
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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/icons/minilogo.svg',
                )
              ],
            ),
            SizedBox(height: 115.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 38.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ArrowBackCard(),
                  SizedBox(height: 11.5.h),
                  Container(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                      top: 40.h,
                      bottom: 30.h,
                    ),
                    width: 1.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: ColorHelper.green08,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: Text(
                            'Введите код отправленный на ваш номер',
                            textAlign: TextAlign.center,
                            style: TextStyleHelper.forBold,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextField(
                          onChanged: (value) {
                            if (codeController.text.length == 6) {
                              enabledButton.value = true;
                            } else {
                              enabledButton.value = false;
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                          ],
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          cursorColor: ColorHelper.grey07,
                          style: TextStyle(color: ColorHelper.grey07),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 15.h),
                            hintText: '000000',
                            hintStyle: TextStyleHelper.forTextField,
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
                        SizedBox(height: 5.h),
                        CustomTimer(phone: widget.phone),
                        SizedBox(height: 30.h),
                        BlocListener<AuthBloc, AuthState>(
                          bloc: bloc,
                          listener: (context, state) {
                            if (state is AuthLoadingState) {
                              SmartDialog.showLoading(msg: 'Загрузка...');
                            }

                            if (state is GetMsgLoadedState) {
                              SmartDialog.dismiss();

                              customNavigatorPush(context, LogInScreen());
                            }
                            if (state is AuthErrorState) {
                              SmartDialog.dismiss();

                              Exceptions.showFlushbar(
                                state.error.message ?? '',
                                context: context,
                              );
                            }
                          },
                          child: ValueListenableBuilder(
                            valueListenable: enabledButton,
                            builder: (BuildContext context, bool value,
                                    Widget? child) =>
                                ElevatedButton(
                              onPressed: () {
                                if (enabledButton.value) {
                                  String phone = widget.phone
                                      .replaceAll(RegExp(r'[^\w\s]+'), '');
                                  ;
                                  log('phone === $phone');
                                  bloc.add(CheckSendMsgEvent(
                                    phone: '+996$phone',
                                    smsCode: codeController.text,
                                  ));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(100.w),
                                backgroundColor: enabledButton.value
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'Далее',
                                style: TextStyle(
                                  color: ColorHelper.green1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
