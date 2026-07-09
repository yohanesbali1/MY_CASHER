import 'package:my_casher/core/database/app_database.dart';
import 'package:my_casher/core/database/tables/category_table.dart';
import 'package:my_casher/core/database/tables/product_table.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';

class ProductLocalDatasource {
  Future<List<ProductModels>> getData({int? categoryId, String? search}) async {
    final db = await AppDatabase.instance.database;

    final where = <String>[];
    final args = <dynamic>[];

    if (categoryId != null) {
      where.add('p.${ProductTable.categoryId} = ?');
      args.add(categoryId);
    }

    if (search != null && search.trim().isNotEmpty) {
      print(search);
      where.add('p.${ProductTable.name} LIKE ?');
      args.add('%$search%');
    }

    final result = await db.rawQuery('''
    SELECT
      p.*,
      c.${CategoryTable.name} AS category_name
    FROM ${ProductTable.table} p
    LEFT JOIN ${CategoryTable.table} c
      ON p.${ProductTable.categoryId} = c.${CategoryTable.id}
    ${where.isNotEmpty ? 'WHERE ${where.join(' AND ')}' : ''}
    ORDER BY p.${ProductTable.id} DESC
    ''', args);

    return result.map((e) => ProductModels.fromMap(e)).toList();
  }

  Future<void> create(ProductModels product) async {
    final db = await AppDatabase.instance.database;
    final map = product.toMap();
    await db.insert(ProductTable.table, map);
    return;
  }

  Future<ProductModels> show(int id) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      ProductTable.table,
      where: '${ProductTable.id} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      throw Exception('Product tidak ditemukan');
    }

    return ProductModels.fromMap(result.first);
  }

  Future<void> update(ProductModels product) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      ProductTable.table,
      {
        ProductTable.price: product.price,
        ProductTable.quantity: product.quantity,
      },
      where: '${ProductTable.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance.database;

    await db.delete(
      ProductTable.table,
      where: '${ProductTable.id} = ?',
      whereArgs: [id],
    );
  }
}
