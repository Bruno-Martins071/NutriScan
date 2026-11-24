import '../../domain/entities/allergy.dart';
import '../../domain/entities/restriction_suggestion.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local/profile_local_datasource.dart';
import '../datasources/local/restriction_suggestions.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._localDataSource);

  final ProfileLocalDataSource _localDataSource;

  @override
  Future<List<Allergy>> getDefaultAllergies() =>
      _localDataSource.getDefaultAllergies();

  @override
  Future<List<RestrictionSuggestion>> getRestrictionSuggestions() async =>
      restrictionSuggestions;

  @override
  Future<UserProfile?> getProfile() => _localDataSource.getProfile();

  @override
  Future<UserProfile> saveProfile(UserProfile profile) =>
      _localDataSource.saveProfile(profile);
}
