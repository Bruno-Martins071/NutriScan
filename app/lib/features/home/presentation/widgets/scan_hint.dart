import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class ScanHint extends StatelessWidget {
  const ScanHint({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'Aponte para o código de barras ou QR Code',
            textAlign: TextAlign.center,
            style: AppTextStyles.instructionTitle,
          ),
          SizedBox(height: 6),
          Text(
            'A leitura começa sozinha. Nada para tocar.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
