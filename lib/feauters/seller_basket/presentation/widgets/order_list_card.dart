import 'package:cashback/feauters/seller_basket/data/models/basket_ui_model.dart';
import 'package:cashback/internal/helpers/constants.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../internal/helpers/colors_helper.dart';

class OrderListCard extends StatefulWidget {
  final bool? isWithApp;
  final double totalCashBack;
  final double totalPrice;

  const OrderListCard({
    super.key,
    this.isWithApp = true,
    required this.totalCashBack,
    required this.totalPrice,
  });

  @override
  State<OrderListCard> createState() => _OrderListCardState();
}

class _OrderListCardState extends State<OrderListCard> {
  double totalPrice = 0;
  double totalCashBack = 0;

  List<BasketModel> asd = [];
  @override
  void initState() {
    Constants.totalBasket.forEach((element) {
      asd.addAll(List<BasketModel>.generate(
        element.amount,
        (index) => BasketModel(
          productID: element.productID,
          amount: element.amount,
          productName: element.productName,
          cashback: element.cashback,
          price: element.price,
        ),
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 27.h,
        left: 25.w,
        bottom: 30.h,
        right: 25.w,
      ),
      height: 300.h,
      width: 1.sw,
      decoration: BoxDecoration(
        color: ColorHelper.red08,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 20,
                child: Text(
                  'Наименование',
                  style: TextStyleHelper.basket1,
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(
                  'Стоимость',
                  style: TextStyleHelper.basket1,
                ),
              ),
              Text(
                'Кэшбек',
                style: TextStyleHelper.basket1,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: asd.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: Text(
                          asd[index].productName,
                          style: TextStyleHelper.basket2,
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          '${asd[index].price} сом',
                          style: TextStyleHelper.basket2,
                        ),
                      ),
                      const Spacer(flex: 5),
                      if (widget.isWithApp == true)
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            '${asd[index].cashback} баллов',
                            style: TextStyleHelper.basket2,
                          ),
                        ),
                      if (widget.isWithApp == false)
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            '0 баллов',
                            style: TextStyleHelper.basket2,
                          ),
                        ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Text(
                  'ИТОГО',
                  style: TextStyleHelper.basket3,
                ),
              ),
              const Spacer(flex: 20),
              SizedBox(
                child: Text(
                  '${widget.totalPrice} сом',
                  style: TextStyleHelper.basket3,
                ),
              ),
              const Spacer(flex: 12),
              if (widget.isWithApp == true)
                SizedBox(
                  child: Text(
                    'Баллы: ${widget.totalCashBack.toStringAsFixed(1)}',
                    style: TextStyleHelper.basket3,
                  ),
                ),
              if (widget.isWithApp == false)
                SizedBox(
                  child: Text(
                    'Баллы: 0',
                    style: TextStyleHelper.basket3,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
