import 'package:flutter/material.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';

class CategoryFilterWidget extends StatelessWidget {
  const CategoryFilterWidget({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<CategoryProductModel> categories;
  final int? selected;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];

          final active = selected == category?.id;
          return InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => onSelected(active ? null : category.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              decoration: BoxDecoration(
                color: active ? color.primary : color.secondary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "${category.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: active ? color.onPrimary : color.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
