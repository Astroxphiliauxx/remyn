import 'package:flutter/material.dart';

import '../../../../app_theme/app_typography.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Text(
          "Profile Page",
          style: AppTypography.display.copyWith(color: colorScheme.onSurface),
        ),
      ),
    );

  }
}