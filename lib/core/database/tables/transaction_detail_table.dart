import 'product_table.dart';
import 'transaction_table.dart';

class TransactionDetailTable {
  TransactionDetailTable._();

  static const table = 'transaction_details';

  static const id = 'id';
  static const transactionId = 'transaction_id';
  static const productId = 'product_id';
  static const quantity = 'quantity';
  static const price = 'price';
  static const subtotal = 'subtotal';

  static const createTable =
      '''
    CREATE TABLE $table(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $transactionId INTEGER NOT NULL,
      $productId INTEGER NOT NULL,
      $quantity INTEGER NOT NULL,
      $price REAL NOT NULL,
      $subtotal REAL NOT NULL,
      FOREIGN KEY($transactionId)
        REFERENCES ${TransactionTable.table}(${TransactionTable.id}),
      FOREIGN KEY($productId)
        REFERENCES ${ProductTable.table}(${ProductTable.id})
    )
  ''';
}
