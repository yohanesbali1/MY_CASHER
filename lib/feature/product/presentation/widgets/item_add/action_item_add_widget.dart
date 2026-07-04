import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';

class ActionItemAddWidget extends StatelessWidget {
  const ActionItemAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormMode.list) {
          context.pop();
        }
      },
      builder: (context, state) {
        return FilledButton.icon(
          onPressed: () {
            context.read<ProductBloc>().add(ProductCreate());
          },
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          icon: const Icon(Icons.add_box_outlined),
          label: Text(
            "Tambah Produk",
            style: text.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color.onPrimary,
            ),
          ),
        );
      },
    );
  }
}
