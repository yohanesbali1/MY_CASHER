import 'package:flutter/material.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';

class QrisSummaryWidget extends StatelessWidget {
  const QrisSummaryWidget({super.key, required this.cart, required this.total});

  final List<CartItemModel> cart;
  final double total;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cart.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: Theme.of(context).dividerColor),
            itemBuilder: (context, index) {
              final item = cart[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Text(
                      item.product.icon ?? "📦",
                      style: const TextStyle(fontSize: 24),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "${item.product.name} ×${item.quantity}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    Text(
                      CurrencyHelper.rupiah(item.subtotal),
                      style: text.bodyMedium?.copyWith(
                        color: color.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Divider(height: 1, color: Theme.of(context).dividerColor),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Text(
                  "Total",
                  style: text.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),

                const Spacer(),

                Text(
                  CurrencyHelper.rupiah(total),
                  style: text.titleSmall?.copyWith(
                    color: color.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
