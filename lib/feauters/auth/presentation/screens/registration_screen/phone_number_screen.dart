import 'dart:developer';

import 'package:cashback/feauters/auth/presentation/screens/registration_screen/enter_sms_code_screen.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cashback/feauters/auth/presentation/widgets/arrow_back_card.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/components/custom_flushbar.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import '../../../../../internal/dependencies/get_it.dart';

import '../../../../../internal/helpers/constants.dart';
import '../../logic/bloc/auth_bloc.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  late AuthBloc bloc;
  final MaskedTextController phoneController =
      MaskedTextController(mask: '(000)-000-000');
  ValueNotifier<bool> enabledButton = ValueNotifier<bool>(false);

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
                            'Введите номер телефона',
                            textAlign: TextAlign.center,
                            style: TextStyleHelper.forBold,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextField(
                          onChanged: (value) {
                            if (phoneController.text.length == 13) {
                              enabledButton.value = true;
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
                              top: 15.h,
                              left: 30.w,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                right: 10.w,
                                top: 15.h,
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
                        SizedBox(height: 30.h),
                        BlocListener<AuthBloc, AuthState>(
                          bloc: bloc,
                          listener: (context, state) {
                            if (state is AuthLoadingState) {
                              SmartDialog.showLoading(msg: 'Загрузка...');
                            }

                            if (state is SuccessPhoneNumberCheckedState) {
                              SmartDialog.dismiss();

                              customNavigatorPush(
                                  context,
                                  EnterSmsCodeScreen(
                                      phone: "+996${phoneController.text}"));
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
                                  log('phone == ${phoneController.text}');
                                  bloc.add(CheckPhoneNumberEvent(
                                    phone: phoneController.text,
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
