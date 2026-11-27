import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/history_entry.dart';
import '../state/history_state.dart';

/// Cores, ícone e texto de cada resultado do semáforo.
extension HistoryVerdictStyle on HistoryVerdict {
  String get label => switch (this) {
    HistoryVerdict.safe => 'Seguro',
    HistoryVerdict.attention => 'Atenção',
    HistoryVerdict.containsAllergen => 'Contém alergênico',
  };

  Color get color => switch (this) {
    HistoryVerdict.safe => AppColors.brandStrong,
    HistoryVerdict.attention => AppColors.warningStrong,
    HistoryVerdict.containsAllergen => AppColors.dangerStrong,
  };

  Color get softColor => switch (this) {
    HistoryVerdict.safe => AppColors.brandSoft,
    HistoryVerdict.attention => AppColors.warningSoft,
    HistoryVerdict.containsAllergen => AppColors.dangerSoft,
  };

  Color get textColor => switch (this) {
    HistoryVerdict.safe => AppColors.brandDeep,
    HistoryVerdict.attention => AppColors.warningDeep,
    HistoryVerdict.containsAllergen => AppColors.dangerStrong,
  };

  IconData get icon => switch (this) {
    HistoryVerdict.safe => Icons.check,
    HistoryVerdict.attention => Icons.priority_high,
    HistoryVerdict.containsAllergen => Icons.close,
  };
}

/// Cartão de uma leitura: ícone do semáforo, produto, marca · hora e selo.
class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key, required this.entry, this.onTap});

  final HistoryEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final verdict = entry.verdict;

    return Material(
      color: AppColors.lightCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.lightBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: verdict.color,
                ),
                child: Icon(verdict.icon, size: 22, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        height: 20 / 15,
                        color: AppColors.lightText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      historySubtitle(entry),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.lightCaption,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              VerdictBadge(verdict: verdict),
            ],
          ),
        ),
      ),
    );
  }
}

class VerdictBadge extends StatelessWidget {
  const VerdictBadge({super.key, required this.verdict});

  final HistoryVerdict verdict;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: verdict.softColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        verdict.label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          height: 16 / 12,
          color: verdict.textColor,
        ),
      ),
    );
  }
}

/// Fundo vermelho "Apagar" que aparece ao deslizar o cartão para a esquerda.
class DeleteSwipeBackground extends StatelessWidget {
  const DeleteSwipeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
        color: AppColors.dangerStrong,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        'Apagar',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}
