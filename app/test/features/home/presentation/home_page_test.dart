import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/features/home/presentation/pages/home_page.dart';

void main() {
  testWidgets('HomePage exibe os elementos principais do Figma', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('Offline · base local'), findsOneWidget);
    expect(find.text('Glúten · Lactose'), findsNWidgets(2));
    expect(find.text('Aponte para o código de barras ou QR Code'), findsOneWidget);
    expect(find.text('A leitura começa sozinha. Nada para tocar.'), findsOneWidget);
    expect(find.textContaining('Digitar ingredientes'), findsOneWidget);
    expect(find.text('Histórico'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
  });
}
