import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_data_widget.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_update/item_update_widget.dart';

class ItemBaseWidget extends StatelessWidget {
  final ProductModels product_item;

  const ItemBaseWidget({Key? key, required this.product_item})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<ProductBloc>().add(
              ProductShowData(id: product_item.id as int),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child:
                state.id == product_item.id && state.status == FormMode.update
                ? ItemUpdateWidget()
                : ItemDataWidget(product_item: product_item),
          ),
        );
      },
    );
  }
}
