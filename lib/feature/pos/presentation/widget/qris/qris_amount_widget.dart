import 'package:flutter/material.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';

class QrisAmountWidget extends StatelessWidget {
  const QrisAmountWidget({
    super.key,
    required this.total,
    required this.totalItem,
  });

  final double total;
  final int totalItem;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'TOTAL PEMBAYARAN',
          style: text.labelSmall?.copyWith(
            color: color.onSurfaceVariant.withValues(alpha: .5),
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          CurrencyHelper.rupiah(total),
          style: text.headlineMedium?.copyWith(
            color: color.primary,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.primary.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '$totalItem Item',
            style: text.labelMedium?.copyWith(
              color: color.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
