import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return BlocBuilder<PosBloc, PosState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 42,
                  height: 42,
                  color: Theme.of(context).colorScheme.secondary,
                  child: Center(child: Text(item.product.icon ?? '')),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "${item.product.name}",
                      style: text.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      CurrencyHelper.rupiah(item.product.price),
                      style: text.bodySmall?.copyWith(
                        color: color.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 20,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      if (item?.id == null) {
                        return;
                      }
                      context.read<PosBloc>().add(
                        ChangeQuantityCart(cart_id: item.id!, type: 'decrease'),
                      );
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: color.onSecondary.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: color.onSecondary.withValues(alpha: .9),
                        size: 16,
                      ),
                    ),
                  ),
                  Text(
                    "${item.quantity}",
                    style: text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      if (item?.id == null) {
                        return;
                      }
                      context.read<PosBloc>().add(
                        ChangeQuantityCart(cart_id: item.id!, type: 'increase'),
                      );
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: color.onSecondary.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.add,
                        color: color.onSecondary.withValues(alpha: .9),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 24),

              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  if (item?.id == null) {
                    return;
                  }
                  context.read<PosBloc>().add(
                    RemoveProductFromCart(cart_id: item.id!),
                  );
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color.error.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: color.error,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
