import '../../domain/entities/allergy.dart';
import '../../domain/entities/user_profile.dart';

abstract final class UserProfileModel {
  static UserProfile fromMap(
    Map<String, Object?> map, {
    List<Allergy> allergies = const [],
  }) {
    return UserProfile(
      id: map['id'] as int,
      name: (map['name'] as String?) ?? '',
      avatarColorIndex: map['avatar_color'] as int,
      warnAboutTraces: (map['warn_about_traces'] as int) == 1,
      allergies: allergies,
    );
  }

  static Map<String, Object?> toMap(UserProfile profile) {
    return {
      'name': profile.name.trim(),
      'avatar_color': profile.avatarColorIndex,
      'warn_about_traces': profile.warnAboutTraces ? 1 : 0,
    };
  }
}
