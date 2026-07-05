import 'package:flutter/material.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';
import 'package:my_casher/feature/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/custome_item_widget.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/item_category.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/list_category_skeleton.dart';
import 'package:my_casher/shared/widget/empty/empty_widget.dart';

class ListCategoryWidget extends StatelessWidget {
  const ListCategoryWidget({
    super.key,
    required this.isLoading,
    required this.categories,
    required this.status,
    required this.selectedId,
    required this.onRefresh,
    required this.onDelete,
    required this.onEdit,
  });

  final bool isLoading;
  final List<CategoryProductModel> categories;
  final FormMode? status;
  final int? selectedId;

  final Future<void> Function() onRefresh;
  final void Function(CategoryProductModel category) onDelete;
  final void Function(CategoryProductModel category) onEdit;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ListCategorySkeleton();
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: categories.isEmpty && status == FormMode.list
              ? const EmptyStateWidget(
                  icon: Icons.category_outlined,
                  title: 'Belum Ada Kategori',
                  description:
                      'Tambahkan kategori baru untuk\nmengelompokkan produk.',
                )
              : Column(
                  children: List.generate(categories.length, (index) {
                    final category = categories[index];

                    if (selectedId == category.id &&
                        status == FormMode.update) {
                      return const CustomeItemWidget();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ItemCategoryWidget(
                        name: category.name,
                        count: category.productCount,
                        isEdit: category.isEdit,
                        onDelete: () => onDelete(category),
                        onEdit: () => onEdit(category),
                      ),
                    );
                  }),
                ),
        ),
      ),
    );
  }
}
