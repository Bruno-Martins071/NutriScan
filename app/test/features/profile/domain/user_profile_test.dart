import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/features/profile/domain/entities/allergy.dart';
import 'package:nutriscan/features/profile/domain/entities/restriction_suggestion.dart';
import 'package:nutriscan/features/profile/domain/entities/user_profile.dart';

void main() {
  test('monta o rótulo das restrições com contador para as demais', () {
    const profile = UserProfile(
      allergies: [
        Allergy(name: 'Glúten'),
        Allergy(name: 'Lactose'),
        Allergy(name: 'Soja'),
        Allergy(name: 'Corante amarelo', isCustom: true),
      ],
    );

    expect(profile.restrictionsLabel(), 'Glúten · Lactose +2');
    expect(const UserProfile().restrictionsLabel(), '');
  });

  test('usa a primeira letra do nome como inicial', () {
    expect(const UserProfile(name: ' ana ').initial, 'A');
    expect(const UserProfile().initial, '');
  });

  test('encontra sugestões ignorando maiúsculas e acentos', () {
    const suggestion = RestrictionSuggestion(
      name: 'Glutamato monossódico',
      aliases: ['Realçador de sabor'],
    );

    expect(suggestion.matchedTermFor('MONOSSODICO'), 'Glutamato monossódico');
    expect(suggestion.matchedTermFor('realcador'), 'Realçador de sabor');
    expect(suggestion.matchedTermFor('soja'), isNull);
    expect(suggestion.matchedTermFor('  '), isNull);
  });
}
