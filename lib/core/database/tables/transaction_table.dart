class TransactionTable {
  TransactionTable._();

  static const table = 'transactions';

  static const id = 'id';
  static const invoice = 'invoice';
  static const total = 'total';
  static const payment = 'payment';
  static const change = 'change';
  static const createdAt = 'created_at';

  static const createTable =
      '''
    CREATE TABLE $table(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $invoice TEXT NOT NULL,
      $total REAL NOT NULL,
      $payment REAL NOT NULL,
      $change REAL NOT NULL,
      $createdAt TEXT NOT NULL
    )
  ''';
}
