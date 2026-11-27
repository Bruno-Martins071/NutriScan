import 'package:flutter/foundation.dart';

import '../../../../core/utils/text_normalizer.dart';
import '../../domain/entities/allergy.dart';
import '../../domain/entities/restriction_suggestion.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../state/profile_state.dart';

class ProfileController extends ChangeNotifier {
  ProfileController(this._repository);

  static const String emptyRestrictionMessage =
      'Digite o nome da restrição antes de adicionar.';
  static const String duplicatedRestrictionMessage =
      'Essa restrição já está na lista.';
  static const int minQueryLengthForSuggestions = 2;
  static const int maxSuggestions = 3;

  final ProfileRepository _repository;

  ProfileState _state = const ProfileState();
  ProfileState get state => _state;

  List<RestrictionSuggestion> _suggestions = const [];

  Future<void> load() async {
    _emit(_state.copyWith(status: ProfileStatus.loading));
    try {
      final defaults = await _repository.getDefaultAllergies();
      final profile = await _repository.getProfile();
      _suggestions = await _repository.getRestrictionSuggestions();
      _emit(_stateFromProfile(defaults, profile));
    } catch (_) {
      _emit(_state.copyWith(status: ProfileStatus.failure));
    }
  }

  void toggleAllergy(int allergyId) {
    final selected = {..._state.selectedAllergyIds};
    if (!selected.remove(allergyId)) selected.add(allergyId);
    _emit(_state.copyWith(selectedAllergyIds: selected));
  }

  String? addCustomRestriction(String rawName) {
    final name = rawName.trim();
    if (name.isEmpty) return emptyRestrictionMessage;

    final key = TextNormalizer.normalize(name);
    final matchingDefault = _state.defaultAllergies
        .where((allergy) => TextNormalizer.normalize(allergy.name) == key)
        .firstOrNull;
    if (matchingDefault != null) {
      _emit(
        _state.copyWith(
          selectedAllergyIds: {
            ..._state.selectedAllergyIds,
            matchingDefault.id!,
          },
        ),
      );
      return null;
    }

    final isDuplicated = _isCustomRestrictionAdded(key);
    if (isDuplicated) return duplicatedRestrictionMessage;

    _emit(
      _state.copyWith(customRestrictions: [..._state.customRestrictions, name]),
    );
    return null;
  }

  List<RestrictionSuggestion> suggestionsFor(String query) {
    if (query.trim().length < minQueryLengthForSuggestions) return const [];

    return _suggestions
        .where((suggestion) => suggestion.matchedTermFor(query) != null)
        .where(
          (suggestion) => !_isCustomRestrictionAdded(
            TextNormalizer.normalize(suggestion.name),
          ),
        )
        .take(maxSuggestions)
        .toList();
  }

  bool _isCustomRestrictionAdded(String normalizedName) {
    return _state.customRestrictions.any(
      (restriction) => TextNormalizer.normalize(restriction) == normalizedName,
    );
  }

  void removeCustomRestriction(String name) {
    _emit(
      _state.copyWith(
        customRestrictions: _state.customRestrictions
            .where((item) => item != name)
            .toList(),
      ),
    );
  }

  void setWarnAboutTraces(bool value) {
    _emit(_state.copyWith(warnAboutTraces: value));
  }

  void updateIdentity({required String name, required int avatarColorIndex}) {
    _emit(
      _state.copyWith(name: name.trim(), avatarColorIndex: avatarColorIndex),
    );
  }

  Future<bool> save() async {
    if (!_state.canSave) return false;

    _emit(_state.copyWith(isSaving: true));
    try {
      final saved = await _repository.saveProfile(_profileFromState());
      _emit(_stateFromProfile(_state.defaultAllergies, saved));
      return true;
    } catch (_) {
      _emit(_state.copyWith(isSaving: false));
      return false;
    }
  }

  UserProfile _profileFromState() {
    final selected = _state.defaultAllergies.where(
      (allergy) => _state.selectedAllergyIds.contains(allergy.id),
    );
    final custom = _state.customRestrictions.map(
      (name) => Allergy(name: name, isCustom: true),
    );

    return UserProfile(
      id: _state.profileId,
      name: _state.name,
      avatarColorIndex: _state.avatarColorIndex,
      warnAboutTraces: _state.warnAboutTraces,
      allergies: [...selected, ...custom],
    );
  }

  ProfileState _stateFromProfile(List<Allergy> defaults, UserProfile? profile) {
    final allergies = profile?.allergies ?? const <Allergy>[];
    return ProfileState(
      status: ProfileStatus.ready,
      profileId: profile?.id,
      name: profile?.name ?? '',
      avatarColorIndex: profile?.avatarColorIndex ?? 0,
      warnAboutTraces: profile?.warnAboutTraces ?? true,
      defaultAllergies: defaults,
      selectedAllergyIds: {
        for (final allergy in allergies)
          if (!allergy.isCustom && allergy.id != null) allergy.id!,
      },
      customRestrictions: [
        for (final allergy in allergies)
          if (allergy.isCustom) allergy.name,
      ],
    );
  }

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _emit(ProfileState state) {
    if (_isDisposed) return;
    _state = state;
    notifyListeners();
  }
}
