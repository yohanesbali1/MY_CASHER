import 'package:my_casher/core/database/app_database.dart';
import 'package:my_casher/core/database/tables/product_table.dart';
import 'package:my_casher/core/database/tables/transaction_detail_table.dart';
import 'package:my_casher/core/database/tables/transaction_table.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/transaction/data/model/transaction_model.dart';

class TransactionLocalDatasource {
  Future<int> checkout({
    required String invoice,
    required double total,
    required double payment,
    required double change,
    required List<CartItemModel> cartItems,
  }) async {
    final db = await AppDatabase.instance.database;

    return await db.transaction((txn) async {
      final transactionId = await txn.insert(TransactionTable.table, {
        TransactionTable.invoice: invoice,
        TransactionTable.total: total,
        TransactionTable.payment: payment,
        TransactionTable.change: change,
        TransactionTable.createdAt: DateTime.now().toIso8601String(),
      });

      for (final item in cartItems) {
        await txn.insert(TransactionDetailTable.table, {
          TransactionDetailTable.transactionId: transactionId,
          TransactionDetailTable.productId: item.product.id,
          TransactionDetailTable.quantity: item.quantity,
          TransactionDetailTable.price: item.price,
          TransactionDetailTable.subtotal: item.subtotal,
        });
      }

      return transactionId;
    });
  }

  Future<List<TransactionModel>> getData({
    int page = 1,
    int limit = 40,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await AppDatabase.instance.database;

    final offset = (page - 1) * limit;

    final where = <String>[];
    final args = <dynamic>[];

    if (startDate != null) {
      where.add("DATE(created_at) >= DATE(?)");
      args.add(startDate.toIso8601String());
    }

    if (endDate != null) {
      where.add("DATE(created_at) <= DATE(?)");
      args.add(endDate.toIso8601String());
    }

    final result = await db.query(
      TransactionTable.table,
      where: where.isEmpty ? null : where.join(" AND "),
      whereArgs: args,
      orderBy: "${TransactionTable.createdAt} DESC",
      limit: limit,
      offset: offset,
    );

    return result.map(TransactionModel.fromMap).toList();
  }

  Future<Map<String, dynamic>?> getById(int id) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      TransactionTable.table,
      where: '${TransactionTable.id} = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isEmpty ? null : result.first;
  }

  Future<List<Map<String, dynamic>>> getDetails(int transactionId) async {
    final db = await AppDatabase.instance.database;

    return db.rawQuery(
      '''
      SELECT
        td.*,
        p.*
      FROM ${TransactionDetailTable.table} td
      INNER JOIN ${ProductTable.table} p
        ON td.${TransactionDetailTable.productId} = p.${ProductTable.id}
      WHERE td.${TransactionDetailTable.transactionId} = ?
      ORDER BY td.${TransactionDetailTable.id}
    ''',
      [transactionId],
    );
  }

  Future<void> delete(int transactionId) async {
    final db = await AppDatabase.instance.database;

    await db.transaction((txn) async {
      await txn.delete(
        TransactionDetailTable.table,
        where: '${TransactionDetailTable.transactionId} = ?',
        whereArgs: [transactionId],
      );

      await txn.delete(
        TransactionTable.table,
        where: '${TransactionTable.id} = ?',
        whereArgs: [transactionId],
      );
    });
  }

  Future<void> clear() async {
    final db = await AppDatabase.instance.database;

    await db.transaction((txn) async {
      await txn.delete(TransactionDetailTable.table);
      await txn.delete(TransactionTable.table);
    });
  }

  Future<String> generateInvoiceNumber() async {
    final db = await AppDatabase.instance.database;

    final today = DateTime.now();
    final date =
        "${today.year}"
        "${today.month.toString().padLeft(2, '0')}"
        "${today.day.toString().padLeft(2, '0')}";

    final result = await db.rawQuery('''
    SELECT COUNT(*) as total
    FROM ${TransactionTable.table}
    WHERE DATE(${TransactionTable.createdAt}) = DATE('now','localtime')
    ''');

    final count = (result.first['total'] as int) + 1;

    return "INV-$date-${count.toString().padLeft(4, '0')}";
  }

  Future<TransactionSummaryModel> getSummary({
    String search = '',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await AppDatabase.instance.database;

    final where = <String>[];
    final args = <dynamic>[];

    if (search.isNotEmpty) {
      where.add('${TransactionTable.invoice} LIKE ?');
      args.add('%$search%');
    }

    if (startDate != null) {
      where.add('${TransactionTable.createdAt} >= ?');
      args.add(startDate.toIso8601String());
    }

    if (endDate != null) {
      where.add('${TransactionTable.createdAt} <= ?');
      args.add(endDate.toIso8601String());
    }

    final whereSql = where.isEmpty ? '' : 'WHERE ${where.join(' AND ')}';

    final result = await db.rawQuery('''
    SELECT
      COUNT(*) AS total_transaction,
      COALESCE(SUM(${TransactionTable.total}),0) AS total_revenue,
      COALESCE(SUM(td.${TransactionDetailTable.quantity}),0) AS total_item
    FROM ${TransactionTable.table} t
    LEFT JOIN ${TransactionDetailTable.table} td
      ON td.${TransactionDetailTable.transactionId} = t.${TransactionTable.id}
    $whereSql
  ''', args);

    final row = result.first;

    return TransactionSummaryModel(
      totalRevenue: (row['total_revenue'] as num).toDouble(),
      totalTransaction: (row['total_transaction'] as num).toInt(),
      totalItem: (row['total_item'] as num).toInt(),
    );
  }
}
