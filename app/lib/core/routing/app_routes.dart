import 'package:flutter/widgets.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../di/app_dependencies.dart';

abstract final class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
        home: (_) => HomePage(repository: AppDependencies.profileRepository),
        profile: (_) =>
            ProfilePage(repository: AppDependencies.profileRepository),
      };
}
