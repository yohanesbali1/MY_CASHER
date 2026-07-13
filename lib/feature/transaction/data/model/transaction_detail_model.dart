import 'package:my_casher/feature/product/data/models/product_models.dart';

class TransactionDetailModel {
  final int? id;
  final int transactionId;
  final int productId;
  final int quantity;
  final double price;
  final double subtotal;
  final ProductModels? product;

  const TransactionDetailModel({
    this.id,
    required this.transactionId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.subtotal,
    this.product,
  });

  factory TransactionDetailModel.fromMap(Map<String, dynamic> map) {
    return TransactionDetailModel(
      id: map['id'] as int?,
      transactionId: map['transaction_id'] as int,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      price: (map['price'] as num).toDouble(),
      subtotal: (map['subtotal'] as num).toDouble(),
      product: map['name'] != null ? ProductModels.fromMap(map) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'subtotal': subtotal,
    };
  }

  TransactionDetailModel copyWith({
    int? id,
    int? transactionId,
    int? productId,
    int? quantity,
    double? price,
    double? subtotal,
    ProductModels? product,
  }) {
    return TransactionDetailModel(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      subtotal: subtotal ?? this.subtotal,
      product: product ?? this.product,
    );
  }
}
