import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    final backAction =
        onBack ?? (canPop ? () => Navigator.of(context).maybePop() : null);

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
      child: Row(
        children: [
          if (backAction != null)
            IconButton(
              onPressed: backAction,
              tooltip: 'Voltar',
              iconSize: 28,
              color: AppColors.lightText,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            )
          else
            const SizedBox(width: 12),
          const SizedBox(width: 4),
          Expanded(
            child: Semantics(
              header: true,
              child: Text(title, style: AppTextStyles.pageTitle),
            ),
          ),
        ],
      ),
    );
  }
}
