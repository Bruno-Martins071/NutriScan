import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.initial,
    required this.color,
    this.size = 56,
  });

  final String initial;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final hasInitial = initial.isNotEmpty;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: hasInitial ? color : AppColors.lightBorder,
      ),
      child: hasInitial
          ? Text(
              initial,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: size * 0.42,
                height: 1,
                color: AppColors.lightCard,
              ),
            )
          : Icon(
              Icons.person_rounded,
              size: size * 0.6,
              color: AppColors.lightTextMuted,
            ),
    );
  }
}
