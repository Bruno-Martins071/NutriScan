import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../widgets/camera_preview_background.dart';
import '../widgets/home_bottom_bar.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/manual_entry_button.dart';
import '../widgets/scan_frame.dart';
import '../widgets/scan_hint.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dados mockados
  static const String _profileInitial = 'A';
  static const String _restrictionsLabel = 'Glúten · Lactose';

  CameraLensDirection _lensDirection = CameraLensDirection.back;

  void _switchCamera() {
    setState(() {
      _lensDirection = _lensDirection == CameraLensDirection.back
          ? CameraLensDirection.front
          : CameraLensDirection.back;
    });
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
                ),
                const Spacer(flex: 3),
                const ScanFrame(),
                const SizedBox(height: 36),
                const ScanHint(),
                const Spacer(flex: 2),
                const ManualEntryButton(),
                const Spacer(flex: 1),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: HomeBottomBar(restrictionsLabel: _restrictionsLabel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
