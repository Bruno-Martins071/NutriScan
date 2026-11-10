import 'allergy.dart';

class UserProfile {
  const UserProfile({
    this.id,
    this.name = '',
    this.avatarColorIndex = 0,
    this.warnAboutTraces = true,
    this.allergies = const [],
  });

  final int? id;
  final String name;
  final int avatarColorIndex;
  final bool warnAboutTraces;
  final List<Allergy> allergies;

  String get initial {
    final trimmed = name.trim();
    return trimmed.isEmpty ? '' : trimmed[0].toUpperCase();
  }

  String restrictionsLabel({int maxNames = 2}) {
    final names = allergies.map((allergy) => allergy.name).toList();
    final visible = names.take(maxNames).join(' · ');
    final hidden = names.length - maxNames;
    return hidden > 0 ? '$visible +$hidden' : visible;
  }

  UserProfile copyWith({
    int? id,
    String? name,
    int? avatarColorIndex,
    bool? warnAboutTraces,
    List<Allergy>? allergies,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarColorIndex: avatarColorIndex ?? this.avatarColorIndex,
      warnAboutTraces: warnAboutTraces ?? this.warnAboutTraces,
      allergies: allergies ?? this.allergies,
    );
  }
}
