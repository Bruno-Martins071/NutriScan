import '../../domain/entities/history_entry.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/local/history_local_datasource.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._localDataSource);

  final HistoryLocalDataSource _localDataSource;

  @override
  Future<List<HistoryEntry>> getEntries() => _localDataSource.getEntries();

  @override
  Future<HistoryEntry> addEntry(HistoryEntry entry) =>
      _localDataSource.addEntry(entry);

  @override
  Future<void> deleteEntry(int id) => _localDataSource.deleteEntry(id);

  @override
  Future<void> restoreEntry(HistoryEntry entry) =>
      _localDataSource.restoreEntry(entry);
}
