import 'package:flutter/material.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';

import 'payment_summary_widget.dart';
// import 'payment_method_widget.dart';
// import 'cash_payment_widget.dart';
// import 'qris_payment_widget.dart';

enum PaymentMethod { cash, qris }

class PaymentPanelWidget extends StatelessWidget {
  const PaymentPanelWidget({
    super.key,
    required this.cart,
    required this.total,
    required this.totalItem,
    // required this.method,
    // required this.cashController,
    // required this.onMethodChanged,
    // required this.onPayCash,
    // required this.onShowQris,
  });

  final List<CartItemModel> cart;
  final double total;
  final int totalItem;

  // final PaymentMethod method;

  // final TextEditingController cashController;

  // final ValueChanged<PaymentMethod> onMethodChanged;

  // final VoidCallback onPayCash;

  // final VoidCallback onShowQris;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        children: [
          PaymentSummaryWidget(total: total, totalItem: totalItem),

          const SizedBox(height: 16),

          // PaymentMethodWidget(method: method, onChanged: onMethodChanged),

          // const SizedBox(height: 16),

          // if (method == PaymentMethod.cash)
          //   CashPaymentWidget(
          //     total: total,
          //     controller: cashController,
          //     onPay: onPayCash,
          //   )
          // else
          //   QrisPaymentWidget(onPressed: onShowQris),
        ],
      ),
    );
  }
}
