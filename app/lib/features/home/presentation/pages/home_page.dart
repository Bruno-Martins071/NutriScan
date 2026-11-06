import 'package:flutter/material.dart';

import '../widgets/camera_preview_background.dart';
import '../widgets/home_bottom_bar.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/manual_entry_button.dart';
import '../widgets/scan_frame.dart';
import '../widgets/scan_hint.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Dados mockados
  static const String _profileInitial = 'A';
  static const String _restrictionsLabel = 'Glúten · Lactose';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const CameraPreviewBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                const HomeTopBar(
                  profileInitial: _profileInitial,
                  restrictionsLabel: _restrictionsLabel,
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
