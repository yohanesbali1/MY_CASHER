import 'package:my_casher/feature/product/data/dummy/product_dummy.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';

class ProductRepository {
  Future<List<ProductModels>> getData() async {
    return ProductDummy.product_data;
  }

  Future<ProductModels> show(int id) async {
    final data = ProductDummy.product_data.firstWhere(
      (element) => element.id == id,
    );
    return data;
  }

  Future<void> update(int id, Map<String, dynamic> data) async {
    final index = ProductDummy.product_data.indexWhere((e) => e.id == id);

    if (index == -1) return;

    final old = ProductDummy.product_data[index];

    ProductDummy.product_data[index] = old.copyWith(
      price: data['price'],
      quantity: data['quantity'],
    );
  }

  Future<void> delete(int id) async {
    ProductDummy.product_data.removeWhere((e) => e.id == id);
  }
}
