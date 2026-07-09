import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/pos/presentation/widget/payment/cash_payment_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/payment/payment_method_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/payment/qris_payment_widget.dart';

import 'payment_summary_widget.dart';

class PaymentPanelWidget extends StatelessWidget {
  const PaymentPanelWidget({
    super.key,
    required this.cart,
    required this.total,
    required this.totalItem,
    required this.method,
  });

  final List<CartItemModel> cart;
  final double total;
  final int totalItem;

  final PaymentMethod method;

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
                QrisPaymentWidget(
                  onPressed: () {
                    context.go(
                      '/pos/qris',
                      extra: {
                        'cart': state.cartItems,
                        'total': state.total,
                        'totalItem': state.totalItem,
                      },
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
