import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_add/action_item_add_widget.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_add/form_item_add_widget.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_add/item_preview_widget.dart';
import 'package:my_casher/shared/widget/app_bar/app_app_bar.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const AppAppBar(title: 'Inventory', showBackButton: true),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                FormItemAddWidget(),
                ItemPreviewWidget(),
                ActionItemAddWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
