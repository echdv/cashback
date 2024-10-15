import 'package:cashback/feauters/auth/presentation/screens/log_in_screen/log_in_screen.dart';
import 'package:cashback/internal/helpers/components/custom_flushbar.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cashback/feauters/auth/presentation/widgets/arrow_back_card.dart';
import 'package:cashback/feauters/auth/presentation/widgets/text_field_card.dart';
import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/utils.dart';
import '../../logic/bloc/auth_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String phone;

  const ResetPasswordScreen({super.key, required this.phone});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 0.8.sh),
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
                        top: 40.h,
                        bottom: 30.h,
                        left: 24.w,
                        right: 24.w,
                      ),
                      width: 1.sw,
                      decoration: BoxDecoration(
                        color: ColorHelper.green08,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Придумайте новый пароль',
                            textAlign: TextAlign.center,
                            style: TextStyleHelper.forBold,
                          ),
                          SizedBox(height: 20.h),
                          TextFieldCard(
                            onChange: (value) {
                              if (passwordController.text.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty) {
                                enabledButton.value = true;
                              } else if (passwordController.text.isEmpty &&
                                  confirmPasswordController.text.isEmpty) {
                                enabledButton.value = false;
                              } else {
                                enabledButton.value = false;
                              }
                            },
                            title: 'введите новый пароль',
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                            controller: passwordController,
                          ),
                          TextFieldCard(
                            onChange: (value) {
                              if (passwordController.text.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty) {
                                enabledButton.value = true;
                              } else if (passwordController.text.isEmpty &&
                                  confirmPasswordController.text.isEmpty) {
                                enabledButton.value = false;
                              } else {
                                enabledButton.value = false;
                              }
                            },
                            title: 'Повторите пароль',
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                            controller: confirmPasswordController,
                          ),
                          SizedBox(height: 20.h),
                          BlocListener<AuthBloc, AuthState>(
                            bloc: bloc,
                            listener: (context, state) {
                              if (state is AuthLoadingState) {
                                SmartDialog.showLoading(
                                  msg: 'Загрузка...',
                                );
                              }

                              if (state is SuccessResetPasswordState) {
                                SmartDialog.dismiss();

                                customNavigatorPushAndRemove(
                                  context,
                                  LogInScreen(),
                                );
                              }
                            },
                            child: ValueListenableBuilder(
                              valueListenable: enabledButton,
                              builder: (BuildContext context, bool value,
                                      Widget? child) =>
                                  CustomButtonCard(
                                onPressed: () {
                                  SmartDialog.showLoading(msg: 'Загрузка...');

                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    Exceptions.showFlushbar(
                                        "Пароли не совпадают",
                                        context: context);
                                  } else if (enabledButton.value) {
                                    bloc.add(ResetPasswordEvent(
                                        phone: widget.phone,
                                        password: passwordController.text));
                                  }
                                  SmartDialog.dismiss();
                                },
                                backColor: enabledButton.value
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                                title: 'подтвердить',
                                width: 130.w,
                                height: 25.h,
                                bRadius: 10.r,
                                color: ColorHelper.green1,
                                textStyle: TextStyleHelper.forClientButton,
                                isGreen: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
