import 'package:flutter/material.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';

class PaymentSummaryWidget extends StatelessWidget {
  const PaymentSummaryWidget({
    super.key,
    required this.totalItem,
    required this.total,
  });

  final int totalItem;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${totalItem.toString()} item"),

        const Spacer(),

        Text(
          CurrencyHelper.rupiah(total),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
