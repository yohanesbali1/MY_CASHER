import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(top: 8, bottom: 12, left: 16, right: 16),
          decoration: BoxDecoration(
            color: color.surface,
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              context.push(
                '/product/create',
                extra: context.read<ProductBloc>(),
              );
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: color.primary.withValues(alpha: .8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Icon(Icons.add, color: color.onPrimary),
                  Text(
                    'Tambah Data',
                    style: text.bodyLarge!.copyWith(
                      color: color.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
