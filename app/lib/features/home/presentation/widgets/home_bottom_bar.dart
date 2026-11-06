import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    super.key,
    required this.restrictionsLabel,
    this.onHistoryTap,
    this.onProfileTap,
  });

  final String restrictionsLabel;
  final VoidCallback? onHistoryTap;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.glassStrong,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _BottomAction(
              icon: 'assets/icons/ic_history.svg',
              title: 'Histórico',
              subtitle: 'Últimas leituras',
              onTap: onHistoryTap,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _BottomAction(
              icon: 'assets/icons/ic_profile.svg',
              title: 'Perfil',
              subtitle: restrictionsLabel,
              onTap: onProfileTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  const _BottomAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.text.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon, width: 40, height: 40),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.actionTitle),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
