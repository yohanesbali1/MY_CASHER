import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';

class ItemDataWidget extends StatelessWidget {
  final ProductModels product_item;

  const ItemDataWidget({Key? key, required this.product_item})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final lowStock = product_item.quantity <= 5;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Row(
          spacing: 0,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 52,
                height: 52,
                color: Theme.of(context).colorScheme.secondary,
                child: Center(child: Text(product_item.icon ?? '')),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product_item.name}",
                    style: text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Food',
                    style: text.labelSmall?.copyWith(
                      color: color.onSurface.withValues(alpha: .60),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CurrencyHelper.rupiah(product_item.price),
                  style: text.bodySmall?.copyWith(
                    color: color.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (lowStock) ...[
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 12,
                        color: color.error,
                      ),
                      const SizedBox(width: 2),
                    ],
                    Text(
                      '${product_item.quantity} stok',
                      style: text.bodySmall?.copyWith(
                        fontSize: 11,
                        color: lowStock ? color.error : color.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
