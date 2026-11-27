import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/features/profile/domain/entities/allergy.dart';
import 'package:nutriscan/features/profile/domain/entities/user_profile.dart';
import 'package:nutriscan/features/profile/presentation/pages/profile_page.dart';

import '../fakes/fake_profile_repository.dart';

Future<void> pumpProfilePage(
  WidgetTester tester,
  FakeProfileRepository repository,
) async {
  await tester.pumpWidget(
    MaterialApp(home: ProfilePage(repository: repository)),
  );
  await tester.pumpAndSettle();
}

Finder saveButton() => find.widgetWithText(FilledButton, 'Salvar perfil');

Finder addButton() => find.widgetWithText(FilledButton, 'Adicionar');

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pump();
}

void main() {
  testWidgets('exibe o layout de primeiro uso e bloqueia o salvamento', (
    tester,
  ) async {
    await pumpProfilePage(tester, FakeProfileRepository());

    expect(find.text('Monte seu perfil'), findsOneWidget);
    expect(
      find.text('Fica só neste aparelho. Nada vai para servidores.'),
      findsOneWidget,
    );
    expect(find.text('Toque para informar'), findsOneWidget);
    expect(find.text('Adicionar'), findsNWidgets(2));
    for (final allergy in fakeDefaultAllergies) {
      expect(find.text(allergy.name), findsOneWidget);
    }
    expect(find.text('Avisar sobre traços'), findsOneWidget);
    expect(
      find.text('Marque pelo menos uma restrição para continuar'),
      findsOneWidget,
    );
    expect(tester.widget<FilledButton>(saveButton()).onPressed, isNull);
  });

  testWidgets('marcar uma alergia habilita o salvamento', (tester) async {
    await pumpProfilePage(tester, FakeProfileRepository());

    await tester.tap(find.text('Glúten'));
    await tester.pump();

    expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    expect(find.text('1 restrição · salvas no aparelho'), findsOneWidget);
    expect(tester.widget<FilledButton>(saveButton()).onPressed, isNotNull);
  });

  testWidgets('exibe erro ao adicionar restrição personalizada vazia', (
    tester,
  ) async {
    await pumpProfilePage(tester, FakeProfileRepository());

    await tapVisible(tester, addButton());

    expect(
      find.text('Digite o nome da restrição antes de adicionar.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), 'Corante amarelo');
    await tapVisible(tester, addButton());

    expect(
      find.text('Digite o nome da restrição antes de adicionar.'),
      findsNothing,
    );
    expect(find.text('Corante amarelo'), findsOneWidget);
    expect(find.text('1 personalizada · salvas no aparelho'), findsOneWidget);

    await tapVisible(tester, find.byTooltip('Remover Corante amarelo'));
    expect(find.text('Corante amarelo'), findsNothing);
  });

  testWidgets('adiciona uma restrição sugerida enquanto digita', (
    tester,
  ) async {
    await pumpProfilePage(tester, FakeProfileRepository());

    await tester.enterText(find.byType(TextField), 'Tartraz');
    await tester.pump();

    final suggestion = find.bySemanticsLabel('Adicionar Corante amarelo');
    expect(suggestion, findsOneWidget);

    await tapVisible(tester, suggestion);

    expect(find.text('Corante amarelo'), findsOneWidget);
    expect(find.bySemanticsLabel('Adicionar Corante amarelo'), findsNothing);
    expect(find.text('1 personalizada · salvas no aparelho'), findsOneWidget);
  });

  testWidgets('carrega um perfil existente e edita o nome', (tester) async {
    final repository = FakeProfileRepository(
      profile: const UserProfile(
        id: 1,
        name: 'Ana',
        allergies: [
          Allergy(id: 1, code: 'gluten', name: 'Glúten'),
          Allergy(id: 2, code: 'lactose', name: 'Lactose'),
          Allergy(id: 100, name: 'Corante amarelo', isCustom: true),
        ],
      ),
    );
    await pumpProfilePage(tester, repository);

    expect(find.text('Perfil'), findsOneWidget);
    expect(find.text('Ana'), findsOneWidget);
    expect(find.text('Editar'), findsOneWidget);
    expect(find.byIcon(Icons.check_rounded), findsNWidgets(2));
    expect(
      find.text('2 restrições + 1 personalizada · salvas no aparelho'),
      findsOneWidget,
    );

    await tester.tap(find.text('Editar'));
    await tester.pumpAndSettle();
    expect(find.text('Quem usa este perfil?'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Nome'),
      'Júlia (filha)',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Júlia (filha)'), findsOneWidget);
  });

  testWidgets('salva o perfil no repositório', (tester) async {
    final repository = FakeProfileRepository();
    await pumpProfilePage(tester, repository);

    await tapVisible(tester, find.text('Soja'));
    await tapVisible(tester, find.byType(Switch));
    await tester.tap(saveButton());
    await tester.pumpAndSettle();

    expect(repository.saveCalls, 1);
    expect(repository.profile!.allergies.single.name, 'Soja');
    expect(repository.profile!.warnAboutTraces, isFalse);
    expect(find.text('Perfil salvo no aparelho.'), findsOneWidget);
  });

  testWidgets('o layout cabe numa tela de celular pequena', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await pumpProfilePage(tester, FakeProfileRepository());

    expect(tester.takeException(), isNull);
  });
}
