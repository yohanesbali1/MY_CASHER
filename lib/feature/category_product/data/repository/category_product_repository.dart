import 'package:my_casher/feature/category_product/data/dummy/category_dummy.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';

class CategoryProductRepository {
  Future<List<CategoryProductModel>> getCategories() async {
    return CategoryDummy.category_data;
  }

  Future<CategoryProductModel> show(int id) async {
    final category = CategoryDummy.category_data.firstWhere(
      (element) => element.id == id,
    );
    return category;
  }

  Future<void> create(Map<String, dynamic> category) async {
    final int id = CategoryDummy.category_data.length + 1;
    CategoryDummy.category_data.add(
      CategoryProductModel(id: id, name: category['name'], isEdit: true),
    );
  }

  Future<void> update(int id, Map<String, dynamic> data) async {
    final index = CategoryDummy.category_data.indexWhere((e) => e.id == id);

    if (index == -1) return;

    final old = CategoryDummy.category_data[index];

    CategoryDummy.category_data[index] = old.copyWith(name: data['name']);
  }

  Future<void> delete(int id) async {
    CategoryDummy.category_data.removeWhere((e) => e.id == id);
  }
}
