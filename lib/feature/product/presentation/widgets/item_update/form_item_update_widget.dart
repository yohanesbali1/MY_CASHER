import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/shared/widget/form/form_widget.dart';

class FormItemUpdateWidget extends StatefulWidget {
  const FormItemUpdateWidget({super.key});

  @override
  State<FormItemUpdateWidget> createState() => _FormItemUpdateWidgetState();
}

class _FormItemUpdateWidgetState extends State<FormItemUpdateWidget> {
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();

    _priceController = TextEditingController();
    _quantityController = TextEditingController();

    final state = context.read<ProductBloc>().state;
    _priceController.text = state.price.toString();
    _quantityController.text = state.quantity.toString();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Text(
                    'STOK',
                    style: text.labelSmall?.copyWith(
                      color: color.onSurfaceVariant,
                      letterSpacing: 1,
                    ),
                  ),
                  AppTextField(
                    controller: _quantityController,
                    onChanged: (value) => context.read<ProductBloc>().add(
                      ProductFieldChanged(
                        field: ProductField.quantity,
                        value: value,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Text(
                    'HARGA (RP)',
                    style: text.labelSmall?.copyWith(
                      color: color.onSurfaceVariant,
                      letterSpacing: 1,
                    ),
                  ),
                  AppTextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => context.read<ProductBloc>().add(
                      ProductFieldChanged(
                        field: ProductField.price,
                        value: value,
                      ),
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
