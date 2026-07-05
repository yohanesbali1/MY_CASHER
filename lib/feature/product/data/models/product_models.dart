import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';
import 'package:my_casher/core/database/tables/product_table.dart';

class ProductModels {
  final int? id;
  final String? name;
  final int price;
  final int quantity;
  final String? icon;
  final int? category_id;
  final String? categoryName;

  ProductModels({
    this.id,
    this.name,
    required this.price,
    required this.quantity,
    this.icon,
    this.category_id,
    this.categoryName,
  });

  ProductModels copyWith({
    int? id,
    String? name,
    int? price,
    int? quantity,
    String? icon,
    CategoryProductModel? category,
  }) {
    return ProductModels(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      icon: icon ?? this.icon,
      category_id: category?.id ?? this.category_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ProductTable.id: id,
      ProductTable.name: name,
      ProductTable.price: price,
      ProductTable.quantity: quantity,
      ProductTable.icon: icon,
      ProductTable.categoryId: category_id,
    };
  }

  factory ProductModels.fromMap(Map<String, dynamic> map) {
    return ProductModels(
      id: map[ProductTable.id] as int,
      name: map[ProductTable.name] as String? ?? '',
      price: (map[ProductTable.price] as num).toInt(),
      quantity: map[ProductTable.quantity] as int,
      icon: map[ProductTable.icon] as String,
      category_id: map[ProductTable.categoryId] as int,
      categoryName: map['category_name'] as String?,
    );
  }
}
