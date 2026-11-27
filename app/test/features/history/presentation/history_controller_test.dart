import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/features/history/domain/entities/history_entry.dart';
import 'package:nutriscan/features/history/presentation/controllers/history_controller.dart';
import 'package:nutriscan/features/history/presentation/state/history_state.dart';

import 'fake_history_repository.dart';

void main() {
  late FakeHistoryRepository repository;
  late HistoryController controller;

  setUp(() {
    repository = FakeHistoryRepository();
    controller = HistoryController(repository, clock: () => testNow);
  });

  tearDown(() => controller.dispose());

  group('rótulos de dia', () {
    test('Hoje, Ontem e data abreviada', () {
      expect(historyDayLabel(DateTime(2026, 11, 26, 0, 5), testNow), 'Hoje');
      expect(historyDayLabel(DateTime(2026, 11, 25, 23), testNow), 'Ontem');
      expect(
        historyDayLabel(DateTime(2026, 9, 26, 11), testNow),
        'Sáb, 26 set',
      );
      expect(
        historyDayLabel(DateTime(2025, 12, 31), testNow),
        'Qua, 31 dez 2025',
      );
    });

    test('subtítulo com marca e hora', () {
      final entry = prototypeEntries().first;
      expect(historySubtitle(entry), 'Camil · 09:41');
      expect(
        historySubtitle(
          HistoryEntry(
            productName: 'Sem marca',
            verdict: HistoryVerdict.safe,
            scannedAt: DateTime(2026, 11, 26, 7, 5),
          ),
        ),
        '07:05',
      );
    });
  });

  test('carrega e agrupa por dia como no protótipo', () async {
    await controller.load();

    expect(controller.state.status, HistoryStatus.ready);
    final groups = controller.groups;
    expect(groups.map((g) => g.label), ['Hoje', 'Ontem', 'Sáb, 21 nov']);
    expect(groups.map((g) => g.entries.length), [2, 2, 2]);
  });

  test('mostra falha quando o banco não abre', () async {
    repository.failOnLoad = true;
    await controller.load();
    expect(controller.state.status, HistoryStatus.failure);
  });

  test('apaga um registro e desfaz na mesma posição', () async {
    await controller.load();
    final chocolate = controller.state.entries[1];

    expect(await controller.remove(chocolate), isTrue);
    expect(controller.state.entries, isNot(contains(chocolate)));
    expect(repository.stored, isNot(contains(chocolate)));

    await controller.undoRemove(chocolate);
    expect(controller.state.entries[1], chocolate);
    expect(repository.stored, contains(chocolate));
  });

  test('se o banco falhar ao apagar, o item volta para a lista', () async {
    repository.failOnDelete = true;
    await controller.load();
    final first = controller.state.entries.first;

    expect(await controller.remove(first), isFalse);
    expect(controller.state.entries.first, first);
  });
}
