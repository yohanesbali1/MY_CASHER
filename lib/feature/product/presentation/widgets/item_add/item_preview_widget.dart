import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';

class ItemPreviewWidget extends StatelessWidget {
  const ItemPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Row(
            children: [
              Text(
                "${state.icon ?? "A"}",
                style: const TextStyle(fontSize: 34),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${state.name ?? "Produk Baru"}",
                      style: text.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${state.category?.name ?? "Kategori"}",
                      style: text.bodySmall?.copyWith(
                        color: color.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyHelper.rupiah(state.price),
                    style: text.bodyMedium?.copyWith(
                      color: color.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${state.quantity} stok",
                    style: text.bodySmall?.copyWith(
                      color: color.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
