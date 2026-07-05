import 'package:my_casher/core/database/app_database.dart';
import 'package:my_casher/core/database/tables/category_table.dart';
import 'package:my_casher/core/database/tables/product_table.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';

class CategoryLocalDatasource {
  Future<List<CategoryProductModel>> getData() async {
    final db = await AppDatabase.instance.database;

    final result = await db.rawQuery('''
    SELECT
      c.id,
      c.name,
      COUNT(p.id) AS product_count
    FROM ${CategoryTable.table} c
    LEFT JOIN ${ProductTable.table} p
      ON c.${CategoryTable.id} = p.${ProductTable.categoryId}
    GROUP BY c.${CategoryTable.id}
    ORDER BY c.${CategoryTable.id} DESC
  ''');

    return result.map((e) => CategoryProductModel.fromMap(e)).toList();
  }

  Future<void> create(CategoryProductModel category) async {
    final db = await AppDatabase.instance.database;

    await db.insert(CategoryTable.table, category.toMap());
  }

  Future<CategoryProductModel> show(int id) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      CategoryTable.table,
      where: '${CategoryTable.id} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      throw Exception('Kategori tidak ditemukan');
    }

    return CategoryProductModel.fromMap(result.first);
  }

  Future<void> update(CategoryProductModel category) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      CategoryTable.table,
      category.toMap(),
      where: '${CategoryTable.id} = ?',
      whereArgs: [category.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance.database;

    await db.delete(
      CategoryTable.table,
      where: '${CategoryTable.id} = ?',
      whereArgs: [id],
    );
  }

  Future<bool> existsByName(String name, {int? excludeId}) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      CategoryTable.table,
      where: excludeId == null
          ? '${CategoryTable.name} = ?'
          : '${CategoryTable.name} = ? AND ${CategoryTable.id} != ?',
      whereArgs: excludeId == null ? [name] : [name, excludeId],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<int> count() async {
    final db = await AppDatabase.instance.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM ${CategoryTable.table}',
    );

    return result.first['total'] as int;
  }
}
