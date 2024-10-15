// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:cashback/feauters/seller_basket/presentation/screens/choose_basket_screen/choose_basket_screen.dart';
import 'package:cashback/internal/helpers/components/custom_flushbar.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../internal/dependencies/get_it.dart';
import '../../../../../internal/helpers/colors_helper.dart';

import '../../../../../internal/helpers/seller_navbar.dart';
import '../../../../../internal/helpers/text_style_helper.dart';
import '../../../../../internal/helpers/utils.dart';
import '../../../../profile/presentation/logic/bloc/profile_bloc.dart';
import '../../logic/bloc/basket_bloc.dart';

class TakePoinScreen extends StatefulWidget {
  final double totalPrice;
  final String userId;
  const TakePoinScreen({
    Key? key,
    required this.userId,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<TakePoinScreen> createState() => _TakePoinScreenState();
}

class _TakePoinScreenState extends State<TakePoinScreen> {
  final TextEditingController cashBackController = TextEditingController();
  late ProfileBloc pBloc;
  late BasketBloc bloc;
  ValueNotifier<bool> enabledButton = ValueNotifier<bool>(false);
  ValueNotifier<bool> enabledButton2 = ValueNotifier<bool>(false);

  @override
  void initState() {
    print('id == ${widget.userId}');
    print('price == ${widget.totalPrice}');
    pBloc = getIt<ProfileBloc>();
    bloc = getIt<BasketBloc>();
    pBloc.add(GetProfileEventForSeller(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.w,
        backgroundColor: ColorHelper.red08,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        toolbarHeight: 139.h,
        title: Text(
          'КОРЗИНА',
          style: TextStyleHelper.forAppBar,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 0.8.sh),
          child: Column(
            children: [
              SizedBox(height: 82.h),
              Container(
                padding: EdgeInsets.only(
                  top: 30.h,
                  bottom: 40.h,
                ),
                width: 1.sw,
                decoration: BoxDecoration(
                  color: ColorHelper.red08,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Text('Итого: ${widget.totalPrice} сом',
                        style: TextStyleHelper.basket4),
                    SizedBox(height: 10.h),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      bloc: pBloc,
                      builder: (context, state) {
                        if (state is ProfileLoadedState) {
                          return Text(
                            'Баланс: ${state.profileModel.cashbackBalance} баллов',
                            style: TextStyleHelper.basket5,
                          );
                        }
                        return Text(
                          'Баланс: ??? баллов',
                          style: TextStyleHelper.basket5,
                        );
                      },
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'Укажите сколько баллов списать:',
                      style: TextStyleHelper.basket6,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Баллы: ',
                          style: TextStyleHelper.basket7,
                        ),
                        SizedBox(
                          height: 30.h,
                          width: 50.w,
                          child: TextField(
                            onChanged: (value) {
                              if (cashBackController.value.text.isEmpty) {
                                enabledButton.value = false;
                              } else {
                                enabledButton.value = true;
                              }
                              setState(() {});
                            },
                            controller: cashBackController,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: ColorHelper.white08,
                              fontSize: 15.sp,
                            ),
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 15.h),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorHelper.white08,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorHelper.white08,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    BlocConsumer<ProfileBloc, ProfileState>(
                      bloc: pBloc,
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is ProfileLoadedState) {
                          return ValueListenableBuilder(
                            valueListenable: enabledButton2,
                            builder: (BuildContext context, bool value,
                                    Widget? child) =>
                                CustomButtonCard(
                              onPressed: () {
                                enabledButton2.value = true;
                                if (enabledButton2.value == true) {
                                  enabledButton.value = true;
                                  cashBackController.text = state
                                      .profileModel.cashbackBalance
                                      .toString();
                                }
                              },
                              backColor: Colors.white,
                              title: 'Списать все баллы',
                              width: 176.w,
                              height: 40.h,
                              bRadius: 20.r,
                              color: ColorHelper.red08,
                              textStyle: TextStyleHelper.sellerButtonCard,
                              isGreen: true,
                            ),
                          );
                        }

                        return ValueListenableBuilder(
                          valueListenable: enabledButton2,
                          builder: (BuildContext context, bool value,
                                  Widget? child) =>
                              CustomButtonCard(
                            onPressed: () {
                              enabledButton2.value = true;
                              if (enabledButton2.value == true) {
                                cashBackController.text = '';
                                setState(() {});
                              }
                            },
                            backColor: Colors.white,
                            title: 'Списать все баллы',
                            width: 176.w,
                            height: 40.h,
                            bRadius: 20.r,
                            color: ColorHelper.red08,
                            textStyle: TextStyleHelper.sellerButtonCard,
                            isGreen: true,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 29.h),
              BlocListener<BasketBloc, BasketState>(
                bloc: bloc,
                listener: (BuildContext context_, state) {
                  if (state is OrderCreateErrorState) {
                    SmartDialog.dismiss();
                    log(' error === ${state.error}');
                  }
                  if (state is SuccessOrderCreateState) {
                    SmartDialog.dismiss();
                    FocusScope.of(context).unfocus();

                    customNavigatorPush(context, ChooseBasketScreen());
                    Exceptions.showFlushbar(
                      'Успешно!',
                      context: context,
                      isSuccess: true,
                    );
                  }

                  if (state is OrderCreateErrorState) {
                    Exceptions.showFlushbar(
                      'Ошибка!',
                      context: context,
                    );
                  }
                },
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  bloc: pBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ProfileLoadingState) {
                      SmartDialog.showLoading(msg: 'Загрузка...');
                    }

                    if (state is ProfileLoadedState) {
                      SmartDialog.dismiss();

                      return ValueListenableBuilder<bool>(
                        valueListenable: enabledButton,
                        builder:
                            (BuildContext context, bool value, Widget? child) =>
                                ElevatedButton(
                          onPressed: () {
                            if (enabledButton.value == true) {
                              if (double.parse(cashBackController.text) <=
                                  double.parse(state
                                      .profileModel.cashbackBalance
                                      .toString())) {
                                bloc.add(OrderCreateEvent(
                                  id: widget.userId,
                                  cashback: cashBackController.text,
                                ));
                                SmartDialog.showLoading(msg: 'Загрузка...');
                              } else {
                                Exceptions.showFlushbar(
                                    'Введите корректное число баллов',
                                    context: context);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(150.w, 40.h),
                            elevation: 0,
                            shadowColor: Colors.white,
                            foregroundColor: enabledButton.value
                                ? Colors.white
                                : Colors.grey.withOpacity(0.2),
                            backgroundColor: enabledButton.value
                                ? Colors.white
                                : Colors.grey.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            side: BorderSide(
                              width: 1.r,
                              color: enabledButton.value
                                  ? ColorHelper.brown08
                                  : ColorHelper.brown02,
                            ),
                          ),
                          child: Text(
                            'Оплатить',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: enabledButton.value
                                  ? ColorHelper.brown08
                                  : ColorHelper.brown02,
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SellerNavBar(currentPage: 1),
    );
  }
}
