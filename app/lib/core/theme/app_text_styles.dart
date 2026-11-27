import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const String fontFamily = 'Inter';

  static const TextStyle instructionTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 17,
    height: 24 / 17,
    color: AppColors.text,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 22 / 15,
    color: AppColors.textSecondary,
  );

  static const TextStyle actionTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    height: 20 / 15,
    color: AppColors.text,
  );

  static const TextStyle chip = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.text,
  );

  static const TextStyle chipMuted = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle pageTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 26,
    height: 32 / 26,
    color: AppColors.lightText,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 17,
    height: 24 / 17,
    color: AppColors.lightText,
  );

  static const TextStyle sectionSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.lightTextSecondary,
  );

  static const TextStyle lightBody = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 22 / 16,
    color: AppColors.lightText,
  );

  static const TextStyle lightChip = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 15,
    height: 20 / 15,
    color: AppColors.lightText,
  );

  static const TextStyle lightCaption = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    color: AppColors.lightTextSecondary,
  );

  static const TextStyle primaryButton = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 17,
    height: 24 / 17,
    color: AppColors.lightCard,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    color: AppColors.textSecondary,
  );
}
