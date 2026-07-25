import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app_theme/app_typography.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CupertinoNavigationBar(
        backgroundColor: colorScheme.surface.withValues(alpha: 0.9),
        middle: Text(
          'Remyn',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/settings'),
          child: Icon(
            CupertinoIcons.settings,
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/createReminder'),
              child: Icon(
                CupertinoIcons.add_circled,
                color: colorScheme.onSurface,
                size: 26,
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                // TODO: Bulk complete / selection flow.
              },
              child: Icon(
                CupertinoIcons.check_mark_circled,
                color: colorScheme.onSurface,
                size: 26,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Home',
            style: AppTypography.display.copyWith(color: colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
