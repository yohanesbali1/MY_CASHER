import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/product/data/value/product_value.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/shared/widget/form/form_widget.dart';

class FormItemAddWidget extends StatefulWidget {
  const FormItemAddWidget({super.key});

  @override
  State<FormItemAddWidget> createState() => _FormItemAddWidgetState();
}

class _FormItemAddWidgetState extends State<FormItemAddWidget> {
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;
  late final TextEditingController _iconController;

  @override
  void initState() {
    super.initState();

    _priceController = TextEditingController();
    _quantityController = TextEditingController();
    _nameController = TextEditingController();
    _categoryController = TextEditingController();
    _iconController = TextEditingController();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _quantityController.dispose();
    _nameController.dispose();
    _categoryController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        _nameController.text = state.name ?? '';
        _priceController.text = state.price.toString();
        _quantityController.text = state.quantity.toString();
        _nameController.text = state.name ?? '';
        _categoryController.text = state.category?.name ?? '';
        _iconController.text = state.icon ?? '';
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "IKON PRODUK",
                  style: text.labelSmall?.copyWith(
                    color: color.onSurfaceVariant,
                    letterSpacing: 1,
                  ),
                ),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ProductValues.emojiOptions.map((emoji) {
                    final selected = state.icon == emoji;

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        context.read<ProductBloc>().add(
                          ProductFieldChanged(
                            field: ProductField.icon,
                            value: emoji,
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: selected
                              ? color.primary.withValues(alpha: .15)
                              : color.secondary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected
                                ? color.primary
                                : Theme.of(context).dividerColor,
                            width: selected ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            emoji,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (state.iconError != null)
                  Text(
                    state.iconError!,
                    style: text.bodySmall?.copyWith(color: color.error),
                  ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "NAMA PRODUK",
                  style: text.labelSmall?.copyWith(
                    color: color.onSurfaceVariant,
                    letterSpacing: 1,
                  ),
                ),

                AppTextField(
                  controller: _nameController,
                  hintText: "Contoh: Aqua 1500ml",
                  errorText: state.nameError,
                  onChanged: (value) => context.read<ProductBloc>().add(
                    ProductFieldChanged(field: ProductField.name, value: value),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "HARGA (RP)",
                  style: text.labelSmall?.copyWith(
                    color: color.onSurfaceVariant,
                    letterSpacing: 1,
                  ),
                ),
                AppTextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  errorText: state.priceError,
                  onChanged: (value) => context.read<ProductBloc>().add(
                    ProductFieldChanged(
                      field: ProductField.price,
                      value: value,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "STOK AWAL",
                  style: text.labelSmall?.copyWith(
                    color: color.onSurfaceVariant,
                    letterSpacing: 1,
                  ),
                ),
                AppTextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  errorText: state.quantityError,
                  onChanged: (value) => context.read<ProductBloc>().add(
                    ProductFieldChanged(
                      field: ProductField.quantity,
                      value: value,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "KATEGORI",
                  style: text.labelSmall?.copyWith(
                    color: color.onSurfaceVariant,
                    letterSpacing: 1,
                  ),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: state.category_data.map((categoryItem) {
                    final selected = categoryItem.id == state.categoryId;

                    return InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        context.read<ProductBloc>().add(
                          ProductFieldChanged(
                            field: ProductField.categoryId,
                            value: categoryItem,
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? color.primary : color.secondary,
                          borderRadius: BorderRadius.circular(30),
                          border: selected
                              ? null
                              : Border.all(
                                  color: Theme.of(context).dividerColor,
                                ),
                        ),
                        child: Text(
                          categoryItem.name,
                          style: text.bodySmall?.copyWith(
                            color: selected
                                ? color.onPrimary
                                : color.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
