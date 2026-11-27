import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../profile/domain/entities/user_profile.dart';
import '../../../profile/domain/repositories/profile_repository.dart';
import '../widgets/camera_preview_background.dart';
import '../widgets/home_bottom_bar.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/manual_entry_button.dart';
import '../widgets/scan_frame.dart';
import '../widgets/scan_hint.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.repository});

  final ProfileRepository repository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String _emptyProfileLabel = 'Monte seu perfil';

  CameraLensDirection _lensDirection = CameraLensDirection.back;
  UserProfile? _profile;

  String get _profileInitial => _profile?.initial ?? '';

  String get _restrictionsLabel {
    final label = _profile?.restrictionsLabel() ?? '';
    return label.isEmpty ? _emptyProfileLabel : label;
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await widget.repository.getProfile();
      if (mounted) setState(() => _profile = profile);
    } catch (_) {
      if (mounted) setState(() => _profile = null);
    }
  }

  void _switchCamera() {
    setState(() {
      _lensDirection = _lensDirection == CameraLensDirection.back
          ? CameraLensDirection.front
          : CameraLensDirection.back;
    });
  }

  Future<void> _openProfile() async {
    await Navigator.of(context).pushNamed(AppRoutes.profile);
    await _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreviewBackground(lensDirection: _lensDirection),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                HomeTopBar(
                  profileInitial: _profileInitial,
                  restrictionsLabel: _restrictionsLabel,
                  onSwitchCameraTap: _switchCamera,
                  onProfileTap: _openProfile,
                ),
                const Spacer(flex: 3),
                const ScanFrame(),
                const SizedBox(height: 36),
                const ScanHint(),
                const Spacer(flex: 2),
                const ManualEntryButton(),
                const Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: HomeBottomBar(
                    restrictionsLabel: _restrictionsLabel,
                    onProfileTap: _openProfile,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
