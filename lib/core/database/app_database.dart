import 'package:my_casher/core/database/migration.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'tables/cart_table.dart';
import 'tables/category_table.dart';
import 'tables/product_table.dart';
import 'tables/transaction_detail_table.dart';
import 'tables/transaction_table.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final path = join(await getDatabasesPath(), 'my_casher.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(CategoryTable.createTable);
    await db.execute(ProductTable.createTable);
    await db.execute(CartTable.createTable);
    await db.execute(TransactionTable.createTable);
    await db.execute(TransactionDetailTable.createTable);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // migration nanti di sini
    // Migration.migrate();
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
