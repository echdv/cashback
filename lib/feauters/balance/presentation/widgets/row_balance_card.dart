import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';

class RowBalanceCard extends StatelessWidget {
  final String title;
  final String balance;
  final String amount;

  const RowBalanceCard({
    super.key,
    required this.title,
    required this.balance,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: TextStyleHelper.forFood,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            amount.toString(),
            style: TextStyleHelper.forFood,
          ),
        ),
        Expanded(
          child: Text(
            '+$balance',
            style: TextStyleHelper.plPointWhite,
          ),
        ),
      ],
    );
  }
}
