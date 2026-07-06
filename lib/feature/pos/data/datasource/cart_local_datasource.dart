import 'package:my_casher/core/database/app_database.dart';
import 'package:my_casher/core/database/tables/cart_table.dart';
import 'package:my_casher/core/database/tables/product_table.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';

class CartLocalDatasource {
  Future<List<CartItemModel>> getData() async {
    final db = await AppDatabase.instance.database;

    final result = await db.rawQuery('''
      SELECT
        c.id AS cart_id,
        c.quantity AS cart_quantity,
        c.price AS cart_price,
        c.subtotal AS cart_subtotal,

        p.*
      FROM ${CartTable.table} c
      INNER JOIN ${ProductTable.table} p
        ON c.${CartTable.productId} = p.${ProductTable.id}
      ORDER BY c.${CartTable.id} DESC
    ''');

    return result.map((map) {
      return CartItemModel(
        id: map['cart_id'] as int,
        quantity: map['cart_quantity'] as int,
        price: (map['cart_price'] as num).toDouble(),
        subtotal: (map['cart_subtotal'] as num).toDouble(),
        product: ProductModels.fromMap(map),
      );
    }).toList();
  }

  Future<void> create(CartItemModel item) async {
    final db = await AppDatabase.instance.database;
    await db.insert(CartTable.table, {
      CartTable.productId: item.product.id,
      CartTable.quantity: item.quantity,
      CartTable.price: item.product.price,
      CartTable.subtotal: item.product.price * item.quantity,
    });
  }

  Future<void> updateQuantity(int id, int quantity, double price) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      CartTable.table,
      {
        CartTable.quantity: quantity,
        CartTable.subtotal: quantity * price,
        CartTable.price: price,
      },
      where: '${CartTable.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance.database;

    await db.delete(
      CartTable.table,
      where: '${CartTable.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> clear() async {
    final db = await AppDatabase.instance.database;

    await db.delete(CartTable.table);
  }

  Future<CartItemModel?> findByProductId(int productId) async {
    final db = await AppDatabase.instance.database;

    final result = await db.rawQuery(
      '''
      SELECT
        c.id AS cart_id,
        c.quantity AS cart_quantity,
        c.price AS cart_price,
        c.subtotal AS cart_subtotal,

        p.*
      FROM ${CartTable.table} c
      INNER JOIN ${ProductTable.table} p
        ON c.${CartTable.productId} = p.${ProductTable.id}
      WHERE c.${CartTable.productId} = ?
      LIMIT 1
    ''',
      [productId],
    );

    if (result.isEmpty) return null;

    final map = result.first;

    return CartItemModel(
      id: map['cart_id'] as int,
      quantity: map['cart_quantity'] as int,
      price: (map['cart_price'] as num).toDouble(),
      subtotal: (map['cart_subtotal'] as num).toDouble(),
      product: ProductModels.fromMap(map),
    );
  }
}
