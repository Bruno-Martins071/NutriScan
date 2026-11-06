import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/network/connectivity_status.dart';
import '../../../../core/theme/app_colors.dart';
import 'glass_chip.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
    required this.profileInitial,
    required this.restrictionsLabel,
    this.onProfileTap,
  });

  final String profileInitial;
  final String restrictionsLabel;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _ConnectionChip(),
          GlassChip(
            leadingPadding: 6,
            leading: _Avatar(initial: profileInitial),
            label: restrictionsLabel,
            onTap: onProfileTap,
          ),
        ],
      ),
    );
  }
}

class _ConnectionChip extends StatefulWidget {
  const _ConnectionChip();

  @override
  State<_ConnectionChip> createState() => _ConnectionChipState();
}

class _ConnectionChipState extends State<_ConnectionChip> {
  bool _isOnline = false;
  late final StreamSubscription<bool> _subscription;

  @override
  void initState() {
    super.initState();
    ConnectivityStatus.isOnline.then(_update);
    _subscription = ConnectivityStatus.onChanged.listen(_update);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _update(bool isOnline) {
    if (mounted) setState(() => _isOnline = isOnline);
  }

  @override
  Widget build(BuildContext context) {
    return GlassChip(
      leading: const _StatusDot(),
      label: _isOnline ? 'Online' : 'Offline · base local',
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.brand,
        boxShadow: [
          BoxShadow(
            color: AppColors.brand.withValues(alpha: 0.7),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.brand,
      ),
      child: Text(
        initial,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          height: 14 / 12,
          color: AppColors.ink,
        ),
      ),
    );
  }
}
