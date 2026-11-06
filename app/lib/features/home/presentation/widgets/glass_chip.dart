import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class GlassChip extends StatelessWidget {
  const GlassChip({
    super.key,
    required this.leading,
    required this.label,
    this.leadingPadding = 12,
    this.onTap,
  });

  final Widget leading;
  final String label;
  final double leadingPadding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.glass,
      shape: StadiumBorder(side: BorderSide(color: AppColors.glassBorder)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(leadingPadding, 12, 14, 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              leading,
              const SizedBox(width: 8),
              Text(label, style: AppTextStyles.chip),
            ],
          ),
        ),
      ),
    );
  }
}
