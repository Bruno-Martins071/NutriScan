import 'package:nutriscan/features/profile/domain/entities/allergy.dart';
import 'package:nutriscan/features/profile/domain/entities/restriction_suggestion.dart';
import 'package:nutriscan/features/profile/domain/entities/user_profile.dart';
import 'package:nutriscan/features/profile/domain/repositories/profile_repository.dart';

const List<Allergy> fakeDefaultAllergies = [
  Allergy(id: 1, code: 'gluten', name: 'Glúten'),
  Allergy(id: 2, code: 'lactose', name: 'Lactose'),
  Allergy(id: 3, code: 'milk_protein', name: 'Leite (proteína)'),
  Allergy(id: 4, code: 'peanut', name: 'Amendoim'),
  Allergy(id: 5, code: 'soy', name: 'Soja'),
];

const List<RestrictionSuggestion> fakeRestrictionSuggestions = [
  RestrictionSuggestion(name: 'Corante amarelo', aliases: ['Tartrazina']),
  RestrictionSuggestion(name: 'Corante vermelho', aliases: ['Vermelho 40']),
  RestrictionSuggestion(name: 'Mostarda'),
];

class FakeProfileRepository implements ProfileRepository {
  FakeProfileRepository({this.profile, this.failOnSave = false});

  UserProfile? profile;
  bool failOnSave;
  int saveCalls = 0;

  @override
  Future<List<Allergy>> getDefaultAllergies() async => fakeDefaultAllergies;

  @override
  Future<List<RestrictionSuggestion>> getRestrictionSuggestions() async =>
      fakeRestrictionSuggestions;

  @override
  Future<UserProfile?> getProfile() async => profile;

  @override
  Future<UserProfile> saveProfile(UserProfile profile) async {
    saveCalls++;
    if (failOnSave) throw StateError('falha ao salvar');

    var nextCustomId = 100;
    final saved = profile.copyWith(
      id: profile.id ?? 1,
      allergies: [
        for (final allergy in profile.allergies)
          allergy.id != null
              ? allergy
              : Allergy(id: nextCustomId++, name: allergy.name, isCustom: true),
      ],
    );
    this.profile = saved;
    return saved;
  }
}
