import '../../features/profile/data/datasources/local/profile_local_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';

abstract final class AppDependencies {
  static final ProfileRepository profileRepository = ProfileRepositoryImpl(
    ProfileLocalDataSource(),
  );
}
