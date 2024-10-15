

import 'package:cashback/feauters/seller_kassa/presentation/logic/bloc/seller_kassa_bloc.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../internal/dependencies/get_it.dart';

class CustomTextFieldKassa extends StatefulWidget {
  const CustomTextFieldKassa({
    super.key,
  });

  @override
  State<CustomTextFieldKassa> createState() => _CustomTextFieldKassaState();
}

class _CustomTextFieldKassaState extends State<CustomTextFieldKassa> {
  late SellerKassaBloc bloc;
  final MaskedTextController dateController =
      MaskedTextController(mask: '00/00/00');
  @override
  void initState() {
    bloc = getIt<SellerKassaBloc>();
    Constants.date = DateTime.now().toString();
    print(Constants.date = '');
    super.initState();
  }

  takeDate() {
    var today = DateTime.now();
    return Container(
      height: 294.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 13.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Constants.dateList = [];
                    bloc.add(GetSellerKassaDateEvent(
                      date: '',
                      isFirstCall: true,
                    ));
                    setState(() {
                      Constants.date = '';
                    });
                  },
                  child: Text(
                    'Сбросить',
                    style: TextStyle(
                      color: ColorHelper.brown08,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    bloc.add(GetSellerKassaDateEvent(
                      date: Constants.date,
                      isFirstCall: true,
                    ));
                    Constants.dateList = [];
                  },
                  child: Text(
                    'Готово',
                    style: TextStyle(
                      color: ColorHelper.brown08,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const CustomDivider(),
          SizedBox(
            height: 214.h,
            child: CupertinoDatePicker(
                dateOrder: DatePickerDateOrder.dmy,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(today.year, today.month, today.day),
                minimumYear: 2023,
                maximumDate: DateTime(today.year, today.month, today.day),
                maximumYear: today.year,
                onDateTimeChanged: (val) {
                  setState(() {
                    Constants.date = val.toString();
                  });
                }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          readOnly: true,
          controller: dateController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20.h),
              filled: true,
              fillColor: ColorHelper.brown02,
              suffixIconColor: ColorHelper.brown08,
              hintText: Constants.date.isEmpty
                  ? '    DD/MM/YY'
                  : '    ${dateFormater(Constants.date).toString()}',
              hintStyle: TextStyle(
                fontFamily: 'Lato',
                color: ColorHelper.brown08,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              suffixIcon: InkWell(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) => takeDate(),
                  );
                },
                child: const Icon(Icons.calendar_month),
              )),
        ),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorHelper.brown08,
      height: 0,
      thickness: 1.h,
    );
  }
}
