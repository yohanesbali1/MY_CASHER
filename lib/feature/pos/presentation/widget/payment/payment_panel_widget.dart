import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/pos/presentation/widget/payment/cash_payment_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/payment/payment_method_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/payment/qris_payment_widget.dart';

import 'payment_summary_widget.dart';
// import 'payment_method_widget.dart';
// import 'cash_payment_widget.dart';
// import 'qris_payment_widget.dart';

class PaymentPanelWidget extends StatelessWidget {
  const PaymentPanelWidget({
    super.key,
    required this.cart,
    required this.total,
    required this.totalItem,
    required this.method,
    // required this.cashController,
    // required this.onMethodChanged,
    // required this.onPayCash,
    // required this.onShowQris,
  });

  final List<CartItemModel> cart;
  final double total;
  final int totalItem;

  final PaymentMethod method;

  // final TextEditingController cashController;

  // final ValueChanged<PaymentMethod> onMethodChanged;

  // final VoidCallback onPayCash;

  // final VoidCallback onShowQris;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Column(
            children: [
              PaymentSummaryWidget(total: total, totalItem: totalItem),

              const SizedBox(height: 16),

              PaymentMethodWidget(
                method: method,
                onChanged: (PaymentMethod payload) {
                  context.read<PosBloc>().add(ChangeMethod(method: payload));
                },
              ),

              const SizedBox(height: 16),

              if (method == PaymentMethod.cash)
                CashPaymentWidget(total: total)
              else
                QrisPaymentWidget(onPressed: () {}),
            ],
          ),
        );
      },
    );
  }
}
