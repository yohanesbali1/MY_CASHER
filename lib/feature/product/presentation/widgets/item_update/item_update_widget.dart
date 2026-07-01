import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_update/action_item_update_widget.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_update/form_item_update_widget.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_update/header_item_update_widget.dart';

class ItemUpdateWidget extends StatelessWidget {
  ItemUpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            HeaderItemUpdateWidget(),
            FormItemUpdateWidget(),
            ActionItemUpdateWidget(),
          ],
        );
      },
    );
  }
}
