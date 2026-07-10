import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';

class CartBottomWidget extends StatelessWidget {
  const CartBottomWidget({
    super.key,
    required this.total,
    required this.totalItems,
    required this.onTap,
  });

  final int totalItems;
  final double total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    if (totalItems <= 0) {
      return Container();
    }

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withValues(alpha: .06),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.primary.withValues(alpha: .8),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${totalItems} Item",
                  style: text.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(),

              Text(
                "Lihat Keranjang",
                style: text.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              const Spacer(),

              Text(
                CurrencyHelper.rupiah(total),
                style: text.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
