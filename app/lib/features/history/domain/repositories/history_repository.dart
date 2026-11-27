import '../entities/history_entry.dart';

abstract interface class HistoryRepository {
  /// Leituras da mais recente para a mais antiga.
  Future<List<HistoryEntry>> getEntries();

  /// Usado pelo scanner/resultado para registrar uma leitura.
  Future<HistoryEntry> addEntry(HistoryEntry entry);

  Future<void> deleteEntry(int id);

  /// Desfaz uma exclusão, devolvendo o registro com o mesmo id.
  Future<void> restoreEntry(HistoryEntry entry);
}
