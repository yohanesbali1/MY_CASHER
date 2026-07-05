import 'package:my_casher/feature/pos/data/datasource/cart_local_datasource.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';

class CartRepository {
  final CartLocalDatasource _datasource;

  CartRepository(this._datasource);

  Future<List<CartItemModel>> getData() {
    return _datasource.getData();
  }

  Future<void> addProduct(ProductModels product) async {
    final cart = await _datasource.findByProductId(product.id!);

    if (cart != null) {
      await _datasource.updateQuantity(cart.id, cart.quantity + 1);
    } else {
      await _datasource.create(
        CartItemModel(id: 0, product: product, quantity: 1),
      );
    }
  }

  Future<void> increase(int cartId) async {
    final items = await getData();

    final item = items.firstWhere((e) => e.id == cartId);

    await _datasource.updateQuantity(cartId, item.quantity + 1);
  }

  Future<void> decrease(int cartId) async {
    final items = await getData();

    final item = items.firstWhere((e) => e.id == cartId);

    if (item.quantity <= 1) {
      await _datasource.delete(cartId);
    } else {
      await _datasource.updateQuantity(cartId, item.quantity - 1);
    }
  }

  Future<void> delete(int cartId) {
    return _datasource.delete(cartId);
  }

  Future<void> clear() {
    return _datasource.clear();
  }
}
