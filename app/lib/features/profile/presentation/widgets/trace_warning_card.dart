import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_card.dart';

class TraceWarningCard extends StatelessWidget {
  const TraceWarningCard({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
      child: MergeSemantics(
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avisar sobre traços',
                    style: AppTextStyles.sectionTitle,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '"Pode conter" vira amarelo, nunca verde.',
                    style: AppTextStyles.sectionSubtitle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: AppColors.lightCard,
              activeTrackColor: AppColors.brandStrong,
              inactiveThumbColor: AppColors.lightCard,
              inactiveTrackColor: AppColors.disabled,
              trackOutlineColor: const WidgetStatePropertyAll(
                Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
