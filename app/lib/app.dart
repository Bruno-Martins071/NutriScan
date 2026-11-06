import 'package:flutter/material.dart';

import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';

class NutriScanApp extends StatelessWidget {
  const NutriScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriScan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
