import 'package:my_casher/feature/product/data/datasource/product_local_datasource.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';

class ProductRepository {
  final ProductLocalDatasource datasource;

  ProductRepository(this.datasource);

  Future<List<ProductModels>> getData() {
    return datasource.getData();
  }

  Future<void> create(ProductModels product) {
    return datasource.create(product);
  }

  Future<ProductModels> show(int id) {
    return datasource.show(id);
  }

  Future<void> update(ProductModels product) {
    return datasource.update(product);
  }

  Future<void> delete(int id) {
    return datasource.delete(id);
  }
}
