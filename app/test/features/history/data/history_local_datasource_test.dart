import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/features/history/data/datasources/local/history_database.dart';
import 'package:nutriscan/features/history/data/datasources/local/history_local_datasource.dart';
import 'package:nutriscan/features/history/domain/entities/history_entry.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database database;
  late HistoryLocalDataSource dataSource;

  setUpAll(sqfliteFfiInit);

  setUp(() async {
    database = await HistoryDatabase.open(
      factory: databaseFactoryFfi,
      path: inMemoryDatabasePath,
    );
    dataSource = HistoryLocalDataSource(openDatabase: () async => database);
  });

  tearDown(() => database.close());

  HistoryEntry entryAt(String name, DateTime when, HistoryVerdict verdict) =>
      HistoryEntry(
        productName: name,
        brand: 'Marca',
        verdict: verdict,
        scannedAt: when,
      );

  test('começa vazio', () async {
    expect(await dataSource.getEntries(), isEmpty);
  });

  test('grava e lista da leitura mais recente para a mais antiga', () async {
    await dataSource.addEntry(
      entryAt('Antigo', DateTime(2026, 11, 20, 8), HistoryVerdict.safe),
    );
    final recent = await dataSource.addEntry(
      entryAt(
        'Recente',
        DateTime(2026, 11, 26, 9, 41),
        HistoryVerdict.containsAllergen,
      ),
    );

    final entries = await dataSource.getEntries();

    expect(recent.id, isNotNull);
    expect(entries.map((e) => e.productName), ['Recente', 'Antigo']);
    expect(entries.first.verdict, HistoryVerdict.containsAllergen);
    expect(entries.first.scannedAt, DateTime(2026, 11, 26, 9, 41));
  });

  test('apaga e restaura com o mesmo id', () async {
    final saved = await dataSource.addEntry(
      entryAt('Granola', DateTime(2026, 11, 25, 18, 5), HistoryVerdict.attention),
    );

    await dataSource.deleteEntry(saved.id!);
    expect(await dataSource.getEntries(), isEmpty);

    await dataSource.restoreEntry(saved);
    final entries = await dataSource.getEntries();
    expect(entries.single.id, saved.id);
    expect(entries.single.verdict, HistoryVerdict.attention);
  });
}
