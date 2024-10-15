import 'package:cashback/feauters/catalog/presentation/screens/catalog_choose_screen/catalog_choose_screen.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/constants.dart';
import '../../../../../internal/helpers/components/custom_flushbar.dart';
import '../../logic/bloc/auth_bloc.dart';
import '../../widgets/arrow_back_card.dart';
import '../../widgets/text_field_card.dart';

class RegistationScreen extends StatefulWidget {
  final String phone;

  const RegistationScreen({super.key, required this.phone});

  @override
  State<RegistationScreen> createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  late AuthBloc bloc;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  ValueNotifier<bool> enabledButton = ValueNotifier<bool>(false);

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
              SizedBox(height: 15.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ArrowBackCard(),
                      SizedBox(height: 11.5.h),
                      Container(
                        padding: EdgeInsets.only(
                          top: 50.h,
                          bottom: 32.h,
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
                              Text(
                                'Добро пожаловать в cashback-сервис FELIZ',
                                textAlign: TextAlign.center,
                                style: TextStyleHelper.forAuthInfoL,
                              ),
                              SizedBox(height: 29.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Text(
                                  'Пройдите пожалуйста регистрацию',
                                  textAlign: TextAlign.center,
                                  style: TextStyleHelper.forAuthInfoS,
                                ),
                              ),
                              SizedBox(height: 13.h),
                              TextFieldCard(
                                onChange: (value) {
                                  if (nameController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty &&
                                      confirmPasswordController
                                          .text.isNotEmpty) {
                                    enabledButton.value = true;
                                  } else if (passwordController.text.isEmpty &&
                                      confirmPasswordController.text.isEmpty &&
                                      nameController.text.isEmpty) {
                                    enabledButton.value = false;
                                  } else {
                                    enabledButton.value = false;
                                  }
                                },
                                controller: nameController,
                                title: 'Ваше имя',
                                type: TextInputType.text,
                              ),
                              TextFieldCard(
                                onChange: (value) {
                                  if (nameController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty &&
                                      confirmPasswordController
                                          .text.isNotEmpty) {
                                    enabledButton.value = true;
                                  } else if (passwordController.text.isEmpty &&
                                      confirmPasswordController.text.isEmpty &&
                                      nameController.text.isEmpty) {
                                    enabledButton.value = false;
                                  } else {
                                    enabledButton.value = false;
                                  }
                                },
                                controller: passwordController,
                                isPassword: true,
                                title: 'Пароль',
                                type: TextInputType.visiblePassword,
                              ),
                              TextFieldCard(
                                onChange: (value) {
                                  if (nameController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty &&
                                      confirmPasswordController
                                          .text.isNotEmpty) {
                                    enabledButton.value = true;
                                  } else if (passwordController.text.isEmpty &&
                                      confirmPasswordController.text.isEmpty &&
                                      nameController.text.isEmpty) {
                                    enabledButton.value = false;
                                  } else {
                                    enabledButton.value = false;
                                  }
                                },
                                controller: confirmPasswordController,
                                isPassword: true,
                                title: 'Повторите пароль',
                                type: TextInputType.visiblePassword,
                              ),
                              SizedBox(height: 23.h),
                              BlocListener<AuthBloc, AuthState>(
                                bloc: bloc,
                                listener: (context, state) {
                                  if (state is AuthLoadingState) {
                                    SmartDialog.showLoading(msg: 'Загрузка...');
                                  }

                                  if (state is SuccessRegistatrionLoadedState) {
                                    SmartDialog.dismiss();

                                    customNavigatorPush(
                                        context, CatalogChooseScreen());
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
                                      if (passwordController.text !=
                                          confirmPasswordController.text) {
                                        Exceptions.showFlushbar(
                                            'Пароли не совпадают',
                                            context: context);
                                      }
                                      if (enabledButton.value) {
                                        bloc.add(RegistationEvent(
                                          phone: widget.phone,
                                          name: nameController.text,
                                          password: passwordController.text,
                                        ));
                                      } else if (!enabledButton.value) {
                                        Exceptions.showFlushbar(
                                            'Заполните все поля',
                                            context: context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: enabledButton.value
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    child: Text(
                                      'ЗАРЕГИСТРИРОВАТЬСЯ',
                                      style: TextStyleHelper.forClientButton,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
