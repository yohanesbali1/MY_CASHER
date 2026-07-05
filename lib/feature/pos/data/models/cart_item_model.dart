import 'package:my_casher/feature/product/data/models/product_models.dart';

class CartItemModel {
  final ProductModels product;
  final int quantity;
  final int id;

  const CartItemModel({
    required this.product,
    required this.id,
    this.quantity = 1,
  });

  // double get subtotal => product.price * quantity;

  CartItemModel copyWith({ProductModels? product, int? quantity, int? id}) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
