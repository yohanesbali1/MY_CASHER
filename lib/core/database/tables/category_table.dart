class CategoryTable {
  CategoryTable._();

  static const table = 'categories';

  static const id = 'id';
  static const name = 'name';

  static const createTable =
      '''
    CREATE TABLE $table(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT NOT NULL
    )
  ''';
}
