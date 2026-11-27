import '../../domain/entities/allergy.dart';

enum ProfileStatus { loading, ready, failure }

class ProfileState {
  const ProfileState({
    this.status = ProfileStatus.loading,
    this.profileId,
    this.name = '',
    this.avatarColorIndex = 0,
    this.warnAboutTraces = true,
    this.defaultAllergies = const [],
    this.selectedAllergyIds = const {},
    this.customRestrictions = const [],
    this.isSaving = false,
  });

  final ProfileStatus status;
  final int? profileId;
  final String name;
  final int avatarColorIndex;
  final bool warnAboutTraces;
  final List<Allergy> defaultAllergies;
  final Set<int> selectedAllergyIds;
  final List<String> customRestrictions;
  final bool isSaving;

  bool get isFirstUse => profileId == null;

  bool get canSave =>
      status == ProfileStatus.ready &&
      !isSaving &&
      (selectedAllergyIds.isNotEmpty || customRestrictions.isNotEmpty);

  String get initial {
    final trimmed = name.trim();
    return trimmed.isEmpty ? '' : trimmed[0].toUpperCase();
  }

  String get summary {
    final selected = selectedAllergyIds.length;
    final custom = customRestrictions.length;
    if (selected == 0 && custom == 0) {
      return 'Marque pelo menos uma restrição para continuar';
    }

    final parts = [
      if (selected > 0) selected == 1 ? '1 restrição' : '$selected restrições',
      if (custom > 0)
        custom == 1 ? '1 personalizada' : '$custom personalizadas',
    ];
    return '${parts.join(' + ')} · salvas no aparelho';
  }

  ProfileState copyWith({
    ProfileStatus? status,
    int? profileId,
    String? name,
    int? avatarColorIndex,
    bool? warnAboutTraces,
    List<Allergy>? defaultAllergies,
    Set<int>? selectedAllergyIds,
    List<String>? customRestrictions,
    bool? isSaving,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      avatarColorIndex: avatarColorIndex ?? this.avatarColorIndex,
      warnAboutTraces: warnAboutTraces ?? this.warnAboutTraces,
      defaultAllergies: defaultAllergies ?? this.defaultAllergies,
      selectedAllergyIds: selectedAllergyIds ?? this.selectedAllergyIds,
      customRestrictions: customRestrictions ?? this.customRestrictions,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
