import 'package:flutter/widgets.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/pos/presentation/widget/cart/cart_item_widget.dart';

class CartListWidget extends StatelessWidget {
  const CartListWidget({super.key, required this.items});

  final List<CartItemModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return CartItemWidget(item: items[index]);
      },
    );
  }
}
