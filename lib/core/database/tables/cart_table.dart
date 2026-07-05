import 'product_table.dart';

class CartTable {
  CartTable._();

  static const table = 'cart';

  static const id = 'id';
  static const productId = 'product_id';
  static const quantity = 'quantity';
  static const price = 'price';
  static const subtotal = 'subtotal';

  static const createTable =
      '''
    CREATE TABLE $table(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $productId INTEGER NOT NULL,
      $quantity INTEGER NOT NULL,
      $price REAL NOT NULL,
      $subtotal REAL NOT NULL,
      FOREIGN KEY($productId)
        REFERENCES ${ProductTable.table}(${ProductTable.id})
    )
  ''';
}
