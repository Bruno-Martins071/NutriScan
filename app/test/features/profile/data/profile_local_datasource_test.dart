import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/features/profile/data/datasources/local/profile_database.dart';
import 'package:nutriscan/features/profile/data/datasources/local/profile_local_datasource.dart';
import 'package:nutriscan/features/profile/domain/entities/allergy.dart';
import 'package:nutriscan/features/profile/domain/entities/user_profile.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database database;
  late ProfileLocalDataSource dataSource;

  setUpAll(sqfliteFfiInit);

  setUp(() async {
    database = await ProfileDatabase.open(
      factory: databaseFactoryFfi,
      path: inMemoryDatabasePath,
    );
    dataSource = ProfileLocalDataSource(openDatabase: () async => database);
  });

  tearDown(() => database.close());

  test('cadastra as 11 alergias básicas ao criar o banco', () async {
    final allergies = await dataSource.getDefaultAllergies();

    expect(allergies.map((allergy) => allergy.name), [
      'Glúten',
      'Lactose',
      'Leite (proteína)',
      'Amendoim',
      'Soja',
      'Ovo',
      'Castanhas',
      'Frutos do mar',
      'Peixe',
      'Gergelim',
      'Sulfitos',
    ]);
    expect(allergies.every((allergy) => !allergy.isCustom), isTrue);
  });

  test('retorna nulo quando nenhum perfil foi salvo', () async {
    expect(await dataSource.getProfile(), isNull);
  });

  test(
    'salva o perfil vinculado às alergias básicas e personalizadas',
    () async {
      final defaults = await dataSource.getDefaultAllergies();

      final saved = await dataSource.saveProfile(
        UserProfile(
          name: 'Ana',
          avatarColorIndex: 2,
          warnAboutTraces: false,
          allergies: [
            defaults[0],
            defaults[1],
            const Allergy(name: 'Corante amarelo', isCustom: true),
          ],
        ),
      );

      expect(saved.id, isNotNull);
      expect(saved.name, 'Ana');
      expect(saved.avatarColorIndex, 2);
      expect(saved.warnAboutTraces, isFalse);
      expect(saved.allergies.map((allergy) => allergy.name), [
        'Glúten',
        'Lactose',
        'Corante amarelo',
      ]);
      expect(saved.allergies.last.isCustom, isTrue);

      final links = await database.query('user_allergies');
      expect(links, hasLength(3));
    },
  );

  test(
    'atualiza os vínculos e remove restrições personalizadas sem uso',
    () async {
      final defaults = await dataSource.getDefaultAllergies();
      final first = await dataSource.saveProfile(
        UserProfile(
          name: 'Ana',
          allergies: [
            defaults[0],
            const Allergy(name: 'Corante amarelo', isCustom: true),
          ],
        ),
      );

      final updated = await dataSource.saveProfile(
        first.copyWith(name: 'Júlia', allergies: [defaults[4]]),
      );

      expect(updated.id, first.id);
      expect(updated.name, 'Júlia');
      expect(updated.allergies.map((allergy) => allergy.name), ['Soja']);
      expect(await database.query('users'), hasLength(1));
      expect(
        await database.query('allergies', where: 'is_custom = 1'),
        isEmpty,
      );
    },
  );
}
