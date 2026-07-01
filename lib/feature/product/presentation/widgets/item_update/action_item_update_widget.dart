import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';

class ActionItemUpdateWidget extends StatelessWidget {
  const ActionItemUpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  context.read<ProductBloc>().add(ProductUpdate());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Simpan',
                    style: text.bodyMedium?.copyWith(
                      color: color.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  context.read<ProductBloc>().add(
                    const ProductModeChange(FormMode.list),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: color.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Batal',
                    style: text.bodyMedium?.copyWith(
                      color: color.onSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
