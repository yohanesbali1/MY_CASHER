import 'package:my_casher/feature/product/data/dummy/product_dummy.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';

class ProductRepository {
  Future<List<ProductModels>> getData() async {
    return ProductDummy.product_data;
  }

  Future<void> create(Map<String, dynamic> data) async {
    final int id = ProductDummy.product_data.length + 1;
    ProductDummy.product_data.add(
      ProductModels(
        id: id,
        name: data['name'],
        price: data['price'],
        quantity: data['quantity'],
        icon: data['icon'],
        category_id: data['category_id'],
      ),
    );
    return;
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
