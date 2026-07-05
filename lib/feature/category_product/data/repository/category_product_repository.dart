import 'package:my_casher/feature/category_product/data/datasource/category_local_datasource.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';

class CategoryProductRepository {
  final CategoryLocalDatasource datasource;

  CategoryProductRepository(this.datasource);

  Future<List<CategoryProductModel>> getData() {
    return datasource.getData();
  }

  Future<void> create(CategoryProductModel category) {
    return datasource.create(category);
  }

  Future<CategoryProductModel> show(int id) {
    return datasource.show(id);
  }

  Future<void> update(CategoryProductModel category) {
    return datasource.update(category);
  }

  Future<void> delete(int id) {
    return datasource.delete(id);
  }

  Future<bool> existsByName(String name, {int? excludeId}) {
    return datasource.existsByName(name, excludeId: excludeId);
  }

  Future<int> count() {
    return datasource.count();
  }
}
