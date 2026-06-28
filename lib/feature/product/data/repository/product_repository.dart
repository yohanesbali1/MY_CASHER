import 'package:my_casher/feature/product/data/dummy/product_dummy.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';

class ProductRepository {
  Future<List<ProductModels>> getCategories() async {
    return ProductDummy.product_data;
  }
}
