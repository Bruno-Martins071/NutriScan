import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';

class ScanFrame extends StatelessWidget {
  const ScanFrame({super.key, this.size = 300});

  final double size;

  static const double _cornerSize = 44;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.text.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const SizedBox.expand(),
          ),
          const _ProductMock(),
          const _Corner(alignment: Alignment.topLeft, quarterTurns: 0),
          const _Corner(alignment: Alignment.topRight, quarterTurns: 1),
          const _Corner(alignment: Alignment.bottomRight, quarterTurns: 2),
          const _Corner(alignment: Alignment.bottomLeft, quarterTurns: 3),
          const _Laser(),
        ],
      ),
    );
  }
}

class _Corner extends StatelessWidget {
  const _Corner({required this.alignment, required this.quarterTurns});

  final Alignment alignment;
  final int quarterTurns;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: RotatedBox(
        quarterTurns: quarterTurns,
        child: SvgPicture.asset(
          'assets/icons/scan_corner.svg',
          width: ScanFrame._cornerSize,
          height: ScanFrame._cornerSize,
        ),
      ),
    );
  }
}

class _Laser extends StatelessWidget {
  const _Laser();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 2,
        decoration: BoxDecoration(
          color: AppColors.brand,
          borderRadius: BorderRadius.circular(1),
          boxShadow: [
            BoxShadow(
              color: AppColors.brand.withValues(alpha: 0.9),
              blurRadius: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductMock extends StatelessWidget {
  const _ProductMock();

  static const List<double> _barWidths = [
    9.5, 8.5, 10.5, 8.5, 8.5, 11.5, 8.5, 9.5, 8.5, 10.5, 8.5, 8.5,
    9.5, 11.5, 8.5, 8.5, 10.5, 8.5, 9.5, 8.5, 8.5, 10.5, 9.5, 8.5,
  ];

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 6 * math.pi / 180,
      child: Container(
        width: 220,
        height: 149,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        decoration: BoxDecoration(
          color: const Color(0xFFEFE9DC),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.35),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 62,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final width in _barWidths) ...[
                    Expanded(
                      flex: (width * 10).round(),
                      child: const ColoredBox(color: Color(0xFF1F1F1F)),
                    ),
                    const Spacer(flex: 25),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '7 891234 567890',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 14 / 12,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
