import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';

class ProfileIdentityTile extends StatelessWidget {
  const ProfileIdentityTile({
    super.key,
    required this.name,
    required this.initial,
    required this.avatarColor,
    required this.onTap,
  });

  final String name;
  final String initial;
  final Color avatarColor;
  final VoidCallback onTap;

  static const double _minWidthForAction = 260;

  @override
  Widget build(BuildContext context) {
    final hasName = name.isNotEmpty;

    return Material(
      color: AppColors.lightField,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.lightBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final showAction = constraints.maxWidth >= _minWidthForAction;
              return Row(
                children: [
                  UserAvatar(initial: initial, color: avatarColor),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nome (opcional)',
                          style: TextStyle(
                            fontSize: 14,
                            height: 18 / 14,
                            color: AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          hasName ? name : 'Toque para informar',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.lightBody.copyWith(
                            fontSize: 18,
                            height: 24 / 18,
                            color: hasName
                                ? AppColors.lightText
                                : AppColors.lightTextMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showAction) ...[
                    const SizedBox(width: 8),
                    Text(
                      hasName ? 'Editar' : 'Adicionar',
                      style: AppTextStyles.actionTitle.copyWith(
                        fontSize: 16,
                        color: AppColors.brandStrong,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
