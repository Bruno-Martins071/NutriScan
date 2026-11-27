import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/features/history/presentation/pages/history_page.dart';

import 'fake_history_repository.dart';

void main() {
  Future<void> openHistory(
    WidgetTester tester,
    FakeHistoryRepository repository,
  ) async {
    await tester.binding.setSurfaceSize(const Size(412, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        home: HistoryPage(repository: repository, clock: () => testNow),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('lista agrupada por dia com selos do semáforo', (tester) async {
    await openHistory(tester, FakeHistoryRepository());

    expect(find.text('Histórico'), findsOneWidget);
    expect(
      find.text('Guardado só neste aparelho. Deslize para apagar.'),
      findsOneWidget,
    );
    expect(find.text('Hoje'), findsOneWidget);
    expect(find.text('Ontem'), findsOneWidget);
    expect(find.text('Sáb, 21 nov'), findsOneWidget);
    expect(find.text('Biscoito de Arroz Integral'), findsOneWidget);
    expect(find.text('Camil · 09:41'), findsOneWidget);
    expect(find.text('Seguro'), findsNWidgets(3));
    expect(find.text('Contém alergênico'), findsNWidgets(2));
    expect(find.text('Atenção'), findsOneWidget);
  });

  testWidgets('deslizar apaga, mostra aviso e "Desfazer" devolve o item', (
    tester,
  ) async {
    final repository = FakeHistoryRepository();
    await openHistory(tester, repository);

    await tester.drag(
      find.text('Chocolate ao Leite 90 g'),
      const Offset(-500, 0),
    );
    await tester.pumpAndSettle();

    expect(find.text('Chocolate ao Leite 90 g'), findsNothing);
    expect(find.text('Chocolate ao Leite 90 g apagado'), findsOneWidget);
    expect(repository.stored, hasLength(5));

    await tester.tap(find.text('Desfazer'));
    await tester.pumpAndSettle();

    expect(find.text('Chocolate ao Leite 90 g'), findsOneWidget);
    expect(repository.stored, hasLength(6));

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('apagar o único item do dia remove o título do dia', (
    tester,
  ) async {
    final repository = FakeHistoryRepository(
      entries: prototypeEntries().take(3).toList(),
    );
    await openHistory(tester, repository);
    expect(find.text('Ontem'), findsOneWidget);

    await tester.drag(find.text('Granola Tradicional'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text('Ontem'), findsNothing);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('sem leituras mostra estado vazio', (tester) async {
    await openHistory(tester, FakeHistoryRepository(entries: []));

    expect(find.text('Nenhuma leitura ainda'), findsOneWidget);
  });

  testWidgets('erro ao carregar permite tentar de novo', (tester) async {
    final repository = FakeHistoryRepository(failOnLoad: true);
    await openHistory(tester, repository);

    expect(find.text('Não foi possível carregar o histórico.'), findsOneWidget);

    repository.failOnLoad = false;
    await tester.tap(find.text('Tentar de novo'));
    await tester.pumpAndSettle();

    expect(find.text('Hoje'), findsOneWidget);
  });
}
