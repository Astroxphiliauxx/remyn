import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_theme/app_typography.dart';

class ProBanner extends StatelessWidget {
  const ProBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Not active",
                  style: AppTypography.label.copyWith(color: colorScheme.onSurface),
                ),
                SizedBox(height: 4),
                Text(
                  "Remyn Pro",
                  style: AppTypography.body.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Icon(CupertinoIcons.right_chevron,
                color: colorScheme.onSurface, size: 32),
          ],
        ),
      ),
    );
  }
}
