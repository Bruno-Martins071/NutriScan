import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CustomRestrictionChip extends StatelessWidget {
  const CustomRestrictionChip({
    super.key,
    required this.label,
    required this.onRemove,
  });

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.fromLTRB(20, 4, 6, 4),
      decoration: ShapeDecoration(
        color: AppColors.brandSoft,
        shape: const StadiumBorder(
          side: BorderSide(color: AppColors.brandStrong, width: 1.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.lightChip.copyWith(
                color: AppColors.brandDeep,
              ),
            ),
          ),
          IconButton(
            onPressed: onRemove,
            tooltip: 'Remover $label',
            visualDensity: VisualDensity.compact,
            icon: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.brandStrong,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 16,
                color: AppColors.lightCard,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
