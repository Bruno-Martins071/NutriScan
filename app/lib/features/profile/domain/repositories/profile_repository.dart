import '../entities/allergy.dart';
import '../entities/restriction_suggestion.dart';
import '../entities/user_profile.dart';

abstract interface class ProfileRepository {
  Future<List<Allergy>> getDefaultAllergies();

  Future<List<RestrictionSuggestion>> getRestrictionSuggestions();

  Future<UserProfile?> getProfile();

  Future<UserProfile> saveProfile(UserProfile profile);
}
