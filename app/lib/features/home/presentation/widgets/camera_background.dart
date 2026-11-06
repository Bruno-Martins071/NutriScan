import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CameraBackground extends StatelessWidget {
  const CameraBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.cameraGradient,
          stops: [0, 0.5, 1],
        ),
      ),
      child: ClipRect(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
          child: const Stack(
            children: [
              _Blob(
                left: -60,
                top: 120,
                width: 340,
                height: 260,
                color: Color.fromRGBO(62, 107, 88, 0.45),
              ),
              _Blob(
                left: 220,
                top: 300,
                width: 320,
                height: 220,
                color: Color.fromRGBO(122, 106, 68, 0.35),
              ),
              _Blob(
                left: 40,
                top: 520,
                width: 380,
                height: 220,
                color: Color.fromRGBO(44, 74, 85, 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.color,
  });

  final double left;
  final double top;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
