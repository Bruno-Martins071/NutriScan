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

  static const Color lightBackground = Color(0xFFF4F7F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFDDE3E0);
  static const Color lightField = Color(0xFFF0F3F1);
  static const Color lightText = Color(0xFF0B1416);
  static const Color lightTextSecondary = Color(0xFF5F6B68);
  static const Color lightTextMuted = Color(0xFF8A9592);
  static const Color brandStrong = Color(0xFF1DA162);
  static const Color brandDeep = Color(0xFF1B6E45);
  static const Color brandSoft = Color(0xFFE1F5EA);
  static const Color dangerStrong = Color(0xFFC8303A);
  static const Color dangerSoft = Color(0xFFFBE7E8);
  static const Color warningStrong = Color(0xFFD08A0B);
  static const Color warningSoft = Color(0xFFFFF3D9);
  static const Color warningDeep = Color(0xFFA86A00);
  static const Color disabled = Color(0xFFC9D1CD);
  static const Color disabledText = Color(0xFF6B7773);

  static const List<Color> avatarColors = [
    Color(0xFF1DA162),
    Color(0xFF2F6FDB),
    Color(0xFFC8303A),
    Color(0xFFD98A12),
    Color(0xFF7B4BC9),
  ];

  static const List<Color> cameraGradient = [
    Color(0xFF1C2E30),
    Color(0xFF0F1C1E),
    Color(0xFF0B1416),
  ];
}
