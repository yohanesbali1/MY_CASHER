class CategoryProductModel {
  final int id;
  final String name;
  final bool isEdit;

  CategoryProductModel({
    required this.id,
    required this.name,
    required this.isEdit,
  });

  CategoryProductModel copyWith({int? id, String? name, bool? isEdit}) {
    return CategoryProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isEdit: isEdit ?? this.isEdit,
    );
  }
}
