import 'package:my_casher/feature/product/data/models/product_models.dart';

class CartItemModel {
  final int? id;
  final ProductModels product;
  final int quantity;
  final double subtotal;
  final double price;

  const CartItemModel({
    this.id,
    required this.product,
    this.quantity = 1,
    this.subtotal = 0.0,
    this.price = 0.0,
  });

  CartItemModel copyWith({
    int? id,
    ProductModels? product,
    int? quantity,
    double? subtotal,
    double? price,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'CartItemModel(id: $id, product: ${product.name}, quantity: $quantity, subtotal: $subtotal, price: $price)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': product.id,
      'quantity': quantity,
      'subtotal': subtotal,
      'price': price,
    };
  }

  factory CartItemModel.fromMap(
    Map<String, dynamic> map,
    ProductModels product,
  ) {
    return CartItemModel(
      id: map['id'] as int,
      product: product,
      quantity: map['quantity'] as int,
      subtotal: map['subtotal'] as double,
      price: map['price'] as double,
    );
  }
}
