import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/core/theme/app_colors.dart';
import 'package:nutriscan/core/widgets/buttons/primary_button.dart';
import 'package:nutriscan/core/widgets/feedback/info_banner.dart';
import 'package:nutriscan/core/widgets/page_header.dart';
import 'package:nutriscan/core/widgets/section_card.dart';
import 'package:nutriscan/core/widgets/user_avatar.dart';
import 'package:nutriscan/features/profile/domain/entities/restriction_suggestion.dart';
import 'package:nutriscan/features/profile/presentation/widgets/custom_restriction_chip.dart';
import 'package:nutriscan/features/profile/presentation/widgets/custom_restriction_input.dart';
import 'package:nutriscan/features/profile/presentation/widgets/profile_identity_sheet.dart';
import 'package:nutriscan/features/profile/presentation/widgets/profile_identity_tile.dart';
import 'package:nutriscan/features/profile/presentation/widgets/selectable_allergy_chip.dart';
import 'package:nutriscan/features/profile/presentation/widgets/trace_warning_card.dart';

Future<void> pumpInPage(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );
}

void main() {
  testWidgets('componentes de layout exibem título, texto e conteúdo', (
    tester,
  ) async {
    await pumpInPage(
      tester,
      const Column(
        children: [
          PageHeader(title: 'Perfil'),
          InfoBanner(
            icon: Icons.lock_rounded,
            message: 'Fica só neste aparelho.',
          ),
          SectionCard(child: Text('Conteúdo do card')),
        ],
      ),
    );

    expect(find.text('Perfil'), findsOneWidget);
    expect(find.text('Fica só neste aparelho.'), findsOneWidget);
    expect(find.text('Conteúdo do card'), findsOneWidget);
  });

  testWidgets(
    'botão principal fica desativado sem ação e mostra carregamento',
    (tester) async {
      await pumpInPage(tester, const PrimaryButton(label: 'Salvar perfil'));
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );

      await pumpInPage(
        tester,
        PrimaryButton(
          label: 'Salvar perfil',
          isLoading: true,
          onPressed: () {},
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Salvar perfil'), findsNothing);
    },
  );

  testWidgets('avatar mostra a inicial ou o ícone de pessoa', (tester) async {
    await pumpInPage(
      tester,
      const Row(
        children: [
          UserAvatar(initial: 'A', color: AppColors.brandStrong),
          UserAvatar(initial: '', color: AppColors.brandStrong),
        ],
      ),
    );

    expect(find.text('A'), findsOneWidget);
    expect(find.byIcon(Icons.person_rounded), findsOneWidget);
  });

  testWidgets('chip de alergia mostra a marcação e avisa o toque', (
    tester,
  ) async {
    var taps = 0;
    await pumpInPage(
      tester,
      SelectableAllergyChip(
        label: 'Glúten',
        isSelected: true,
        onTap: () => taps++,
      ),
    );

    expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    await tester.tap(find.text('Glúten'));
    expect(taps, 1);
  });

  testWidgets('chip personalizado é removido pelo botão de remover', (
    tester,
  ) async {
    var removed = false;
    await pumpInPage(
      tester,
      CustomRestrictionChip(
        label: 'Corante amarelo',
        onRemove: () => removed = true,
      ),
    );

    await tester.tap(find.byTooltip('Remover Corante amarelo'));
    expect(removed, isTrue);
  });

  testWidgets('campo de restrição mostra o erro devolvido e as sugestões', (
    tester,
  ) async {
    final added = <String>[];
    await pumpInPage(
      tester,
      CustomRestrictionInput(
        onAdd: (name) {
          if (name.trim().isEmpty) {
            return 'Digite o nome da restrição antes de adicionar.';
          }
          added.add(name);
          return null;
        },
        suggestionsFor: (query) => query.length < 2
            ? const []
            : const [
                RestrictionSuggestion(
                  name: 'Corante amarelo',
                  aliases: ['Tartrazina'],
                ),
              ],
      ),
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Adicionar'));
    await tester.pump();
    expect(
      find.text('Digite o nome da restrição antes de adicionar.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), 'Tartraz');
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Adicionar Corante amarelo'));
    await tester.pump();

    expect(added, ['Corante amarelo']);
  });

  testWidgets('bloco do nome alterna entre Adicionar e Editar', (tester) async {
    await pumpInPage(
      tester,
      ProfileIdentityTile(
        name: '',
        initial: '',
        avatarColor: AppColors.brandStrong,
        onTap: () {},
      ),
    );
    expect(find.text('Toque para informar'), findsOneWidget);
    expect(find.text('Adicionar'), findsOneWidget);

    await pumpInPage(
      tester,
      ProfileIdentityTile(
        name: 'Ana',
        initial: 'A',
        avatarColor: AppColors.brandStrong,
        onTap: () {},
      ),
    );
    expect(find.text('Ana'), findsOneWidget);
    expect(find.text('Editar'), findsOneWidget);
  });

  testWidgets('card de traços avisa a troca da chave', (tester) async {
    bool? value;
    await pumpInPage(
      tester,
      TraceWarningCard(value: true, onChanged: (changed) => value = changed),
    );

    await tester.tap(find.byType(Switch));
    expect(value, isFalse);
  });

  testWidgets('painel do nome devolve o nome e a cor escolhidos', (
    tester,
  ) async {
    ProfileIdentity? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await showProfileIdentitySheet(
                  context,
                  name: '',
                  avatarColorIndex: 0,
                );
              },
              child: const Text('Abrir'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Nome'), 'Júlia');
    await tester.pump();
    await tester.tap(find.text('J').at(2));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Salvar'));
    await tester.pumpAndSettle();

    expect(result?.name, 'Júlia');
    expect(result?.avatarColorIndex, 2);
  });
}
