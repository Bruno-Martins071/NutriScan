import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/allergy.dart';
import '../../../domain/entities/user_profile.dart';
import '../../models/allergy_model.dart';
import '../../models/user_profile_model.dart';
import 'profile_database.dart';

class ProfileLocalDataSource {
  ProfileLocalDataSource({Future<Database> Function()? openDatabase})
    : _openDatabase = openDatabase ?? ProfileDatabase.open;

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

  Future<List<Allergy>> getDefaultAllergies() async {
    final db = await _db;
    final rows = await db.query(
      'allergies',
      where: 'is_custom = 0',
      orderBy: 'id',
    );
    return rows.map(AllergyModel.fromMap).toList();
  }

  Future<UserProfile?> getProfile() async {
    return _readProfile(await _db);
  }

  Future<UserProfile> saveProfile(UserProfile profile) async {
    final db = await _db;
    return db.transaction((txn) async {
      final now = DateTime.now().toIso8601String();
      final values = {...UserProfileModel.toMap(profile), 'updated_at': now};

      final userId =
          profile.id ??
          await txn.insert('users', {...values, 'created_at': now});
      if (profile.id != null) {
        await txn.update('users', values, where: 'id = ?', whereArgs: [userId]);
      }

      await txn.delete(
        'user_allergies',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      for (final allergy in profile.allergies) {
        final allergyId = await _resolveAllergyId(txn, allergy);
        await txn.insert('user_allergies', {
          'user_id': userId,
          'allergy_id': allergyId,
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      await txn.delete(
        'allergies',
        where: 'is_custom = 1 AND id NOT IN (SELECT allergy_id FROM user_allergies)',
      );

      return (await _readProfile(txn, userId: userId))!;
    });
  }

  Future<UserProfile?> _readProfile(DatabaseExecutor db, {int? userId}) async {
    final users = await db.query(
      'users',
      where: userId == null ? null : 'id = ?',
      whereArgs: userId == null ? null : [userId],
      orderBy: 'id',
      limit: 1,
    );
    if (users.isEmpty) return null;

    final user = users.first;
    final allergyRows = await db.rawQuery(
      '''
      SELECT a.* FROM allergies a
      INNER JOIN user_allergies ua ON ua.allergy_id = a.id
      WHERE ua.user_id = ?
      ORDER BY a.is_custom, a.id
      ''',
      [user['id']],
    );

    return UserProfileModel.fromMap(
      user,
      allergies: allergyRows.map(AllergyModel.fromMap).toList(),
    );
  }

  Future<int> _resolveAllergyId(DatabaseExecutor db, Allergy allergy) async {
    if (!allergy.isCustom && allergy.id != null) return allergy.id!;

    final existing = await db.query(
      'allergies',
      columns: ['id'],
      where: allergy.isCustom ? 'is_custom = 1 AND name = ?' : 'code = ?',
      whereArgs: [allergy.isCustom ? allergy.name.trim() : allergy.code],
      limit: 1,
    );
    if (existing.isNotEmpty) return existing.first['id'] as int;

    return db.insert(
      'allergies',
      AllergyModel.toMap(Allergy(name: allergy.name.trim(), isCustom: true)),
    );
  }
}
