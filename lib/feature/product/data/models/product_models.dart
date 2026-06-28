import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';

class ProductModels {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String image;
  final int category_id;

  ProductModels({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.category_id,
  });

  ProductModels copyWith({
    int? id,
    String? name,
    double? price,
    int? quantity,
    String? image,
    CategoryProductModel? category,
  }) {
    return ProductModels(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      category_id: category?.id ?? this.category_id,
    );
  }
}
