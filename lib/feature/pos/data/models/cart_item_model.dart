import 'package:my_casher/feature/product/data/models/product_models.dart';

class CartItemModel {
  final int id;
  final ProductModels product;
  final int quantity;

  const CartItemModel({
    required this.id,
    required this.product,
    this.quantity = 1,
  });

  double get subtotal => double.parse(product.price.toString()) * quantity;

  CartItemModel copyWith({int? id, ProductModels? product, int? quantity}) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'product_id': product.id, 'quantity': quantity};
  }

  factory CartItemModel.fromMap(
    Map<String, dynamic> map,
    ProductModels product,
  ) {
    return CartItemModel(
      id: map['id'] as int,
      product: product,
      quantity: map['quantity'] as int,
    );
  }
}
