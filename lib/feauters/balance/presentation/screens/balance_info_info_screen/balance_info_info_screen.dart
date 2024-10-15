import 'dart:io';

import 'package:cashback/feauters/balance/presentation/widgets/row_balance_card.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/dependencies/get_it.dart';
import '../../../../../internal/helpers/components/navbar.dart';
import '../../../../../internal/helpers/text_style_helper.dart';
import '../../../../profile/presentation/logic/bloc/profile_bloc.dart';
import '../../../data/models/sale_info_model.dart';

class BalanceInfoInfoScreen extends StatefulWidget {
  final SaleInfoResult infoResult;

  const BalanceInfoInfoScreen({
    super.key,
    required this.infoResult,
  });

  @override
  State<BalanceInfoInfoScreen> createState() => _BalanceInfoInfoScreenState();
}

class _BalanceInfoInfoScreenState extends State<BalanceInfoInfoScreen> {
  late ProfileBloc pBloc;

  @override
  void initState() {
    pBloc = getIt<ProfileBloc>();
    pBloc.add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.w,
        backgroundColor: ColorHelper.green08,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        toolbarHeight: 139.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "БАЛАНС",
              style: TextStyleHelper.forAppBar,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              children: [
                BlocConsumer<ProfileBloc, ProfileState>(
                  bloc: pBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ProfileErrorState) {
                      return Text(
                        'Ошибка',
                        style: TextStyleHelper.forErrorPointL,
                      );
                    }

                    if (state is ProfileLoadingState) {
                      if (Platform.isIOS) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            radius: 15.r,
                            color: ColorHelper.yellow1,
                          ),
                        );
                      } else {
                        return Center(
                          child: SizedBox(
                            height: 25.r,
                            width: 25.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              color: ColorHelper.yellow1,
                            ),
                          ),
                        );
                      }
                    }

                    if (state is ProfileLoadedState) {
                      return Text(
                        '${state.profileModel.cashbackBalance}',
                        style: TextStyleHelper.forPointL,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(
                  width: 5.w,
                ),
                SvgPicture.asset('assets/icons/coin.svg'),
                SizedBox(width: 21.w),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30.r),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 100.h),
            decoration: BoxDecoration(
              color: ColorHelper.green08,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.infoResult.products!.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 5.h);
                  },
                  itemBuilder: (context, inx) {
                    return RowBalanceCard(
                      amount:
                          'x${widget.infoResult.products?[inx].amount!.toStringAsFixed(0)}',
                      title: widget.infoResult.products?[inx].product ?? '',
                      balance:
                          ' ${widget.infoResult.products?[inx].totalCashback!.toStringAsFixed(1)}',
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      flex: 22,
                      child: Text(
                        'СПИСАНО БАЛЛОВ',
                        style: TextStyleHelper.forFood,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        '- ${double.parse(widget.infoResult.fromBalanceAmount.toString()).toStringAsFixed(1)}',
                        style: TextStyleHelper.plPointWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      flex: 28,
                      child: Text(
                        'ИТОГО',
                        style: TextStyleHelper.forFood,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        '+ ${(double.parse(widget.infoResult.finalCashback.toString()) - double.parse(widget.infoResult.fromBalanceAmount.toString())).toStringAsFixed(1)}',
                        style: TextStyleHelper.plPointWhite,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigator(currentPage: 1),
    );
  }
}
