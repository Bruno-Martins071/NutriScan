import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color ink = Color(0xFF0B1416);
  static const Color surface = Color(0xFF122022);
  static const Color text = Color(0xFFF4F7F5);
  static const Color textSecondary = Color(0xFFA7B3B0);
  static const Color brand = Color(0xFF2ECC85);
  static const Color warning = Color(0xFFF5B93D);
  static const Color danger = Color(0xFFF0525A);

  static const Color glass = Color(0xE0122022);
  static const Color glassStrong = Color(0xEB122022);
  static Color get glassBorder => text.withValues(alpha: 0.12);

  static const List<Color> cameraGradient = [
    Color(0xFF1C2E30),
    Color(0xFF0F1C1E),
    Color(0xFF0B1416),
  ];
}
