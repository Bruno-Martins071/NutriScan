import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

/// Banco local do histórico, separado do banco do perfil para não precisar
/// migrar o `nutriscan_profile.db`.
abstract final class HistoryDatabase {
  static const String fileName = 'nutriscan_history.db';
  static const int version = 1;

  static Future<Database> open({DatabaseFactory? factory, String? path}) async {
    final selectedFactory = factory ?? databaseFactory;
    final databasePath =
        path ?? p.join(await selectedFactory.getDatabasesPath(), fileName);

    return selectedFactory.openDatabase(
      databasePath,
      options: OpenDatabaseOptions(version: version, onCreate: _createSchema),
    );
  }

  static Future<void> _createSchema(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_name TEXT NOT NULL,
        brand TEXT NOT NULL DEFAULT '',
        verdict TEXT NOT NULL,
        barcode TEXT,
        scanned_at TEXT NOT NULL
      )
    ''');
    await db.execute(
      'CREATE INDEX idx_history_scanned_at ON history (scanned_at DESC)',
    );
  }
}
