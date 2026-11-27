import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SelectableAllergyChip extends StatefulWidget {
  const SelectableAllergyChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<SelectableAllergyChip> createState() => _SelectableAllergyChipState();
}

class _SelectableAllergyChipState extends State<SelectableAllergyChip> {
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _isActive => _isPressed || _isFocused;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;
    final isHighlighted = _isActive && !isSelected;

    final background = isSelected
        ? AppColors.brandStrong
        : isHighlighted
        ? AppColors.brandSoft
        : AppColors.lightCard;
    final border = isSelected || isHighlighted
        ? AppColors.brandStrong
        : AppColors.lightBorder;
    final foreground = isSelected
        ? AppColors.lightCard
        : isHighlighted
        ? AppColors.brandDeep
        : AppColors.lightText;

    return Semantics(
      button: true,
      selected: isSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          shadows: [
            if (_isActive)
              BoxShadow(
                color: AppColors.brandStrong.withValues(alpha: 0.28),
                spreadRadius: 4,
              ),
          ],
        ),
        child: Material(
          color: background,
          shape: StadiumBorder(side: BorderSide(color: border, width: 1.5)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            onHighlightChanged: (value) => setState(() => _isPressed = value),
            onFocusChange: (value) => setState(() => _isFocused = value),
            splashColor: AppColors.brandSoft,
            highlightColor: Colors.transparent,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      Icon(Icons.check_rounded, size: 18, color: foreground),
                      const SizedBox(width: 6),
                    ],
                    Flexible(
                      child: Text(
                        widget.label,
                        style: AppTextStyles.lightChip.copyWith(
                          color: foreground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
