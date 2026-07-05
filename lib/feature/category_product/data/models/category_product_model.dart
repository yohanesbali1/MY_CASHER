import 'package:my_casher/core/database/tables/category_table.dart';

class CategoryProductModel {
  final int? id;
  final String name;
  final bool isEdit;
  final int productCount;

  CategoryProductModel({
    this.id,
    required this.name,
    this.productCount = 0,
    this.isEdit = true,
  });

  CategoryProductModel copyWith({
    int? id,
    String? name,
    bool? isEdit,
    int? productCount,
  }) {
    return CategoryProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isEdit: isEdit ?? this.isEdit,
      productCount: productCount ?? this.productCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {CategoryTable.id: id, CategoryTable.name: name};
  }

  factory CategoryProductModel.fromMap(Map<String, dynamic> map) {
    return CategoryProductModel(
      id: (map[CategoryTable.id] as num).toInt(),
      name: map[CategoryTable.name] as String,
      productCount: (map['product_count'] as num?)?.toInt() ?? 0,
      isEdit: true,
    );
  }
}
