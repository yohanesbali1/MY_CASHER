import 'category_table.dart';

class ProductTable {
  ProductTable._();

  static const table = 'products';

  static const id = 'id';
  static const name = 'name';
  static const price = 'price';
  static const quantity = 'quantity';
  static const icon = 'icon';
  static const categoryId = 'category_id';

  static const createTable =
      '''
    CREATE TABLE $table(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT NOT NULL,
      $price REAL NOT NULL,
      $quantity INTEGER NOT NULL,
      $icon TEXT,
      $categoryId INTEGER,
      FOREIGN KEY($categoryId)
        REFERENCES ${CategoryTable.table}(${CategoryTable.id})
    )
  ''';
}
