import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/features/home/presentation/pages/home_page.dart';
import 'package:nutriscan/features/profile/domain/entities/allergy.dart';
import 'package:nutriscan/features/profile/domain/entities/user_profile.dart';

import '../../profile/fakes/fake_profile_repository.dart';

void main() {
  testWidgets('HomePage exibe os elementos principais do Figma', (tester) async {
    final repository = FakeProfileRepository(
      profile: const UserProfile(
        id: 1,
        name: 'Ana',
        allergies: [
          Allergy(id: 1, code: 'gluten', name: 'Glúten'),
          Allergy(id: 2, code: 'lactose', name: 'Lactose'),
        ],
      ),
    );
    await tester.pumpWidget(MaterialApp(home: HomePage(repository: repository)));
    await tester.pump();

    expect(find.text('Offline · base local'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('Glúten · Lactose'), findsNWidgets(2));
    expect(find.text('Aponte para o código de barras ou QR Code'), findsOneWidget);
    expect(find.text('A leitura começa sozinha. Nada para tocar.'), findsOneWidget);
    expect(find.textContaining('Digitar ingredientes'), findsOneWidget);
    expect(find.text('Histórico'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
  });

  testWidgets('pede para montar o perfil quando nenhum foi salvo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: HomePage(repository: FakeProfileRepository())),
    );
    await tester.pump();

    expect(find.text('Monte seu perfil'), findsNWidgets(2));
    expect(find.byIcon(Icons.person_rounded), findsOneWidget);
  });
}
