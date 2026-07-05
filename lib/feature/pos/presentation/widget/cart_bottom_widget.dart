import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';

class CartBottomWidget extends StatelessWidget {
  const CartBottomWidget({super.key, required this.cart});

  final List<CartItemModel> cart;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final total = 0;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withValues(alpha: .06)),
        ],
      ),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 130),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              itemCount: cart.length,
              separatorBuilder: (_, __) => const Divider(height: 12),
              itemBuilder: (_, index) {
                final item = cart[index];

                return Row(
                  children: [
                    Text(
                      item.product.icon ?? '📦',
                      style: const TextStyle(fontSize: 24),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "${item.product.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Text("x${item.quantity}"),

                    const SizedBox(width: 12),

                    Text(
                      CurrencyHelper.rupiah(item.product.price * item.quantity),
                    ),
                  ],
                );
              },
            ),
          ),

          const Divider(height: 1),

          InkWell(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${cart.fold<int>(0, (s, e) => s + e.quantity)} Item",
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    "Lihat Keranjang",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const Spacer(),

                  Text(CurrencyHelper.rupiah(total)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
