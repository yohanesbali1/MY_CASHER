import 'package:sqflite/sqflite.dart';

class Migration {
  Migration._();

  static Future<void> migrate(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Contoh:
    //
    // if (oldVersion < 2) {
    //   await db.execute(
    //     'ALTER TABLE products ADD COLUMN barcode TEXT'
    //   );
    // }
  }
}
