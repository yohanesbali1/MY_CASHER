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
    required String payment_method,
    required List<CartItemModel> cartItems,
  }) async {
    final db = await AppDatabase.instance.database;

    return await db.transaction((txn) async {
      final transactionId = await txn.insert(TransactionTable.table, {
        TransactionTable.invoice: invoice,
        TransactionTable.total: total,
        TransactionTable.payment: payment,
        TransactionTable.change: change,
        TransactionTable.paymentMethod: payment_method,
        TransactionTable.createdAt: DateTime.now().toIso8601String(),
      });

      for (final item in cartItems) {
        final product = await txn.query(
          ProductTable.table,
          where: '${ProductTable.id} = ?',
          whereArgs: [item.product.id],
          limit: 1,
        );
        await txn.insert(TransactionDetailTable.table, {
          TransactionDetailTable.transactionId: transactionId,
          TransactionDetailTable.productId: item.product.id,
          TransactionDetailTable.productName: product.first[ProductTable.name],
          TransactionDetailTable.productIcon: product.first[ProductTable.icon],
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

  Future<TransactionModel?> getById(int id) async {
    final db = await AppDatabase.instance.database;

    final transaction = await db.query(
      TransactionTable.table,
      where: '${TransactionTable.id} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (transaction.isEmpty) return null;

    final details = await db.rawQuery(
      '''
    SELECT
      td.*
    FROM ${TransactionDetailTable.table} td
    WHERE td.${TransactionDetailTable.transactionId} = ?
    ORDER BY td.${TransactionDetailTable.id}
    ''',
      [id],
    );
    final data = Map<String, dynamic>.from(transaction.first);
    data['details'] = details;

    return TransactionModel.fromMap(data);
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
      final startOfDay = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
      );

      where.add('${TransactionTable.createdAt} >= ?');
      args.add(startOfDay.toIso8601String());
    }

    if (endDate != null) {
      final endOfDay = DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        23,
        59,
        59,
        999,
      );

      where.add('${TransactionTable.createdAt} <= ?');
      args.add(endOfDay.toIso8601String());
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
