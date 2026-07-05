import 'package:flutter/material.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_base_widget.dart';
import 'package:my_casher/feature/product/presentation/widgets/product_list_empty_widget.dart';
import 'package:my_casher/feature/product/presentation/widgets/product_list_skeleton.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    required this.isLoading,
    required this.products,
    required this.onRefresh,
  });

  final bool isLoading;
  final List<ProductModels> products;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ProductListSkeleton();
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: products.isEmpty
              ? ProductListEmptyWidget()
              : Column(
                  children: products
                      .map(
                        (product) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ItemBaseWidget(product_item: product),
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }
}
