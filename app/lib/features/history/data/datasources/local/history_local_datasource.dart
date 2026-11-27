import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/history_entry.dart';
import '../../models/history_entry_model.dart';
import 'history_database.dart';

class HistoryLocalDataSource {
  HistoryLocalDataSource({Future<Database> Function()? openDatabase})
    : _openDatabase = openDatabase ?? HistoryDatabase.open;

  final Future<Database> Function() _openDatabase;
  Future<Database>? _database;

  Future<Database> get _db => _database ??= _openOrReset();

  Future<Database> _openOrReset() async {
    try {
      return await _openDatabase();
    } catch (_) {
      _database = null;
      rethrow;
    }
  }

  Future<List<HistoryEntry>> getEntries() async {
    final db = await _db;
    final rows = await db.query(
      'history',
      orderBy: 'scanned_at DESC, id DESC',
    );
    return rows.map(HistoryEntryModel.fromMap).toList();
  }

  Future<HistoryEntry> addEntry(HistoryEntry entry) async {
    final db = await _db;
    final values = HistoryEntryModel.toMap(entry)..remove('id');
    final id = await db.insert('history', values);
    return entry.copyWith(id: id);
  }

  Future<void> deleteEntry(int id) async {
    final db = await _db;
    await db.delete('history', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> restoreEntry(HistoryEntry entry) async {
    final db = await _db;
    await db.insert(
      'history',
      HistoryEntryModel.toMap(entry),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
