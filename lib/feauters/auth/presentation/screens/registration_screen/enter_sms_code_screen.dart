import 'dart:io';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otp_autofill/otp_autofill.dart';

import 'package:cashback/feauters/auth/presentation/screens/registration_screen/registration_screen.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:cashback/feauters/auth/presentation/widgets/timer/custom_timer.dart';
import 'package:cashback/internal/helpers/components/custom_flushbar.dart';
import '../../../../../internal/dependencies/get_it.dart';
import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/constants.dart';
import '../../logic/bloc/auth_bloc.dart';
import '../../widgets/arrow_back_card.dart';

class EnterSmsCodeScreen extends StatefulWidget {
  final String phone;

  const EnterSmsCodeScreen({
    super.key,
    required this.phone,
  });

  @override
  State<EnterSmsCodeScreen> createState() => _EnterSmsCodeScreenState();
}

class _EnterSmsCodeScreenState extends State<EnterSmsCodeScreen> {
  late AuthBloc bloc;
  OTPTextEditController codeController = OTPTextEditController(codeLength: 6);
  ValueNotifier<bool> enabledButton = ValueNotifier<bool>(false);
  late OTPInteractor _otpInteractor;

  @override
  void initState() {
    bloc = getIt<AuthBloc>();

    _otpInteractor = OTPInteractor();

    if (Platform.isAndroid) {
      codeController = OTPTextEditController(
        codeLength: 6,
        otpInteractor: _otpInteractor,
      )..startListenUserConsent(
          (code) {
            final exp = RegExp(r'(\d{6})');

            enabledButton.value = true;
            return exp.stringMatch(code ?? '') ?? '';
          },
        );
    }
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
                            'Введите код отправленный на Ваш номер',
                            textAlign: TextAlign.center,
                            style: TextStyleHelper.forAuthInfoL,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextField(
                          controller: codeController,
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
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          cursorColor: ColorHelper.grey07,
                          style: TextStyleHelper.forTextField,
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
                        SizedBox(height: 15.h),
                        CustomTimer(phone: widget.phone),
                        SizedBox(height: 15.h),
                        BlocListener<AuthBloc, AuthState>(
                          bloc: bloc,
                          listener: (context, state) {
                            if (state is AuthLoadingState) {
                              SmartDialog.showLoading(msg: 'Загрузка...');
                            }

                            if (state is GetMsgLoadedState) {
                              SmartDialog.dismiss();
                              customNavigatorPush(context,
                                  RegistationScreen(phone: widget.phone));
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
                                ElevatedButton(
                              onPressed: () {
                                if (enabledButton.value) {
                                  bloc.add(CheckSendMsgEvent(
                                    phone: widget.phone,
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
                                style: TextStyleHelper.forClientButton,
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
