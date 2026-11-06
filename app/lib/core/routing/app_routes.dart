import 'package:flutter/widgets.dart';

import '../../features/home/presentation/pages/home_page.dart';

abstract final class AppRoutes {
  static const String home = '/';

  static Map<String, WidgetBuilder> get routes => {
        home: (_) => const HomePage(),
      };
}
