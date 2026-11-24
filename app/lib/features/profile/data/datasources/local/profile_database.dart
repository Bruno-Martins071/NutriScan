import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'default_allergies.dart';

abstract final class ProfileDatabase {
  static const String fileName = 'nutriscan_profile.db';
  static const int version = 1;

  static Future<Database> open({DatabaseFactory? factory, String? path}) async {
    final selectedFactory = factory ?? databaseFactory;
    final databasePath =
        path ?? p.join(await selectedFactory.getDatabasesPath(), fileName);

    return selectedFactory.openDatabase(
      databasePath,
      options: OpenDatabaseOptions(
        version: version,
        onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
        onCreate: _createSchema,
      ),
    );
  }

  static Future<void> _createSchema(Database db, int version) async {
    final batch = db.batch()
      ..execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL DEFAULT '',
          avatar_color INTEGER NOT NULL DEFAULT 0,
          warn_about_traces INTEGER NOT NULL DEFAULT 1,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL
        )
      ''')
      ..execute('''
        CREATE TABLE allergies (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          code TEXT UNIQUE,
          name TEXT NOT NULL,
          is_custom INTEGER NOT NULL DEFAULT 0
        )
      ''')
      ..execute('''
        CREATE TABLE user_allergies (
          user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
          allergy_id INTEGER NOT NULL REFERENCES allergies (id) ON DELETE CASCADE,
          PRIMARY KEY (user_id, allergy_id)
        )
      ''');

    for (final allergy in defaultAllergies) {
      batch.insert('allergies', {
        'code': allergy.code,
        'name': allergy.name,
        'is_custom': 0,
      });
    }

    await batch.commit(noResult: true);
  }
}
