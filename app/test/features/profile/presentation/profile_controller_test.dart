import 'package:flutter_test/flutter_test.dart';
import 'package:nutriscan/features/profile/domain/entities/allergy.dart';
import 'package:nutriscan/features/profile/domain/entities/user_profile.dart';
import 'package:nutriscan/features/profile/presentation/controllers/profile_controller.dart';
import 'package:nutriscan/features/profile/presentation/state/profile_state.dart';

import '../fakes/fake_profile_repository.dart';

void main() {
  test('inicia no modo de primeiro uso sem perfil salvo', () async {
    final controller = ProfileController(FakeProfileRepository());

    await controller.load();

    expect(controller.state.status, ProfileStatus.ready);
    expect(controller.state.isFirstUse, isTrue);
    expect(controller.state.canSave, isFalse);
    expect(
      controller.state.summary,
      'Marque pelo menos uma restrição para continuar',
    );
  });

  test(
    'carrega as alergias marcadas e as restrições personalizadas salvas',
    () async {
      final controller = ProfileController(
        FakeProfileRepository(
          profile: const UserProfile(
            id: 1,
            name: 'Ana',
            allergies: [
              Allergy(id: 1, code: 'gluten', name: 'Glúten'),
              Allergy(id: 2, code: 'lactose', name: 'Lactose'),
              Allergy(id: 100, name: 'Corante amarelo', isCustom: true),
            ],
          ),
        ),
      );

      await controller.load();

      expect(controller.state.isFirstUse, isFalse);
      expect(controller.state.selectedAllergyIds, {1, 2});
      expect(controller.state.customRestrictions, ['Corante amarelo']);
      expect(
        controller.state.summary,
        '2 restrições + 1 personalizada · salvas no aparelho',
      );
    },
  );

  test('marca e desmarca alergias', () async {
    final controller = ProfileController(FakeProfileRepository());
    await controller.load();

    controller.toggleAllergy(4);
    expect(controller.state.selectedAllergyIds, {4});
    expect(controller.state.canSave, isTrue);

    controller.toggleAllergy(4);
    expect(controller.state.selectedAllergyIds, isEmpty);
  });

  test('valida as restrições personalizadas', () async {
    final controller = ProfileController(FakeProfileRepository());
    await controller.load();

    expect(
      controller.addCustomRestriction('   '),
      ProfileController.emptyRestrictionMessage,
    );
    expect(controller.addCustomRestriction(' Tartrazina '), isNull);
    expect(
      controller.addCustomRestriction('tartrazina'),
      ProfileController.duplicatedRestrictionMessage,
    );
    expect(controller.state.customRestrictions, ['Tartrazina']);

    expect(controller.addCustomRestriction('soja'), isNull);
    expect(controller.state.selectedAllergyIds, {5});
    expect(controller.state.customRestrictions, ['Tartrazina']);

    controller.removeCustomRestriction('Tartrazina');
    expect(controller.state.customRestrictions, isEmpty);
  });

  test('salva o perfil com as alergias marcadas e personalizadas', () async {
    final repository = FakeProfileRepository();
    final controller = ProfileController(repository);
    await controller.load();

    controller
      ..updateIdentity(name: ' Ana ', avatarColorIndex: 3)
      ..toggleAllergy(1)
      ..setWarnAboutTraces(false);
    controller.addCustomRestriction('Corante amarelo');

    expect(await controller.save(), isTrue);

    final saved = repository.profile!;
    expect(saved.name, 'Ana');
    expect(saved.avatarColorIndex, 3);
    expect(saved.warnAboutTraces, isFalse);
    expect(saved.allergies.map((allergy) => allergy.name), [
      'Glúten',
      'Corante amarelo',
    ]);
    expect(controller.state.isFirstUse, isFalse);
  });

  test('mantém as alterações quando a gravação falha', () async {
    final controller = ProfileController(
      FakeProfileRepository(failOnSave: true),
    );
    await controller.load();
    controller.toggleAllergy(2);

    expect(await controller.save(), isFalse);
    expect(controller.state.isSaving, isFalse);
    expect(controller.state.selectedAllergyIds, {2});
  });

  test('reconhece alergias básicas ignorando acentos', () async {
    final controller = ProfileController(FakeProfileRepository());
    await controller.load();

    expect(controller.addCustomRestriction('GLUTEN'), isNull);

    expect(controller.state.selectedAllergyIds, {1});
    expect(controller.state.customRestrictions, isEmpty);
  });

  test('sugere restrições pelo nome ou por nome alternativo', () async {
    final controller = ProfileController(FakeProfileRepository());
    await controller.load();

    expect(controller.suggestionsFor('t'), isEmpty);
    expect(controller.suggestionsFor('tartraz').map((item) => item.name), [
      'Corante amarelo',
    ]);
    expect(controller.suggestionsFor('corante').map((item) => item.name), [
      'Corante amarelo',
      'Corante vermelho',
    ]);

    controller.addCustomRestriction('Corante amarelo');
    expect(controller.suggestionsFor('corante').map((item) => item.name), [
      'Corante vermelho',
    ]);
  });
}
