import 'package:flutter/widgets.dart';

import '../../features/history/presentation/pages/history_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

abstract final class AppRoutes {
  static const String home = '/';
  static const String history = '/historico';

  static Map<String, WidgetBuilder> get routes => {
        home: (_) => const HomePage(),
        history: (_) => const HistoryPage(),
      };
}
