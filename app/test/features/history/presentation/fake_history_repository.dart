import 'package:nutriscan/features/history/domain/entities/history_entry.dart';
import 'package:nutriscan/features/history/domain/repositories/history_repository.dart';

/// "Hoje" fixo dos testes: quinta, 26/11/2026, 20h.
final DateTime testNow = DateTime(2026, 11, 26, 20);

/// Os mesmos produtos do protótipo do Figma.
List<HistoryEntry> prototypeEntries() => [
  HistoryEntry(
    id: 6,
    productName: 'Biscoito de Arroz Integral',
    brand: 'Camil',
    verdict: HistoryVerdict.safe,
    scannedAt: DateTime(2026, 11, 26, 9, 41),
  ),
  HistoryEntry(
    id: 5,
    productName: 'Chocolate ao Leite 90 g',
    brand: 'Lacta',
    verdict: HistoryVerdict.containsAllergen,
    scannedAt: DateTime(2026, 11, 26, 9, 32),
  ),
  HistoryEntry(
    id: 4,
    productName: 'Granola Tradicional',
    brand: 'Mãe Terra',
    verdict: HistoryVerdict.attention,
    scannedAt: DateTime(2026, 11, 25, 18, 5),
  ),
  HistoryEntry(
    id: 3,
    productName: 'Suco de Uva Integral',
    brand: 'Aurora',
    verdict: HistoryVerdict.safe,
    scannedAt: DateTime(2026, 11, 25, 17, 58),
  ),
  HistoryEntry(
    id: 2,
    productName: 'Pão de Forma Sem Glúten',
    brand: 'Wickbold',
    verdict: HistoryVerdict.safe,
    scannedAt: DateTime(2026, 11, 21, 11, 20),
  ),
  HistoryEntry(
    id: 1,
    productName: 'Iogurte Natural',
    brand: 'Nestlé',
    verdict: HistoryVerdict.containsAllergen,
    scannedAt: DateTime(2026, 11, 21, 11, 12),
  ),
];

class FakeHistoryRepository implements HistoryRepository {
  FakeHistoryRepository({
    List<HistoryEntry>? entries,
    this.failOnLoad = false,
    this.failOnDelete = false,
  }) : stored = entries ?? prototypeEntries();

  List<HistoryEntry> stored;
  bool failOnLoad;
  bool failOnDelete;

  @override
  Future<List<HistoryEntry>> getEntries() async {
    if (failOnLoad) throw Exception('falha ao abrir o banco');
    return List.of(stored);
  }

  @override
  Future<HistoryEntry> addEntry(HistoryEntry entry) async {
    final saved = entry.copyWith(id: stored.length + 100);
    stored = [saved, ...stored];
    return saved;
  }

  @override
  Future<void> deleteEntry(int id) async {
    if (failOnDelete) throw Exception('falha ao apagar');
    stored = stored.where((entry) => entry.id != id).toList();
  }

  @override
  Future<void> restoreEntry(HistoryEntry entry) async {
    stored = [...stored.where((item) => item.id != entry.id), entry];
  }
}
