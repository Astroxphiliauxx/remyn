import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme/app_typography.dart';
import '../../controller/theme_provider.dart';
import 'widgets/section_container.dart';
import 'widgets/settings_list_tile.dart';
import 'widgets/pro_banner.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CupertinoNavigationBar(
        backgroundColor: colorScheme.surface,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          "Settings",
          style: AppTypography.title.copyWith(color: colorScheme.onSurface),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ProBanner(),
            SectionContainer(
              title: "Theme",
              children: [
                SettingsListTile(
                  title: "System",
                  trailing: _getSelectedThemeIcon(context, ThemeMode.system),
                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setTheme(ThemeMode.system);
                  },
                ),
                _buildDivider(colorScheme),
                SettingsListTile(
                  title: "Light",
                  trailing: _getSelectedThemeIcon(context, ThemeMode.light),
                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setTheme(ThemeMode.light);
                  },
                ),
                _buildDivider(colorScheme),
                SettingsListTile(
                  title: "Dark",
                  trailing: _getSelectedThemeIcon(context, ThemeMode.dark),
                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setTheme(ThemeMode.dark);
                  },
                ),
              ],
            ),
            SectionContainer(
              title: "More",
              children: [
                SettingsListTile(
                    title: "More apps", leading: CupertinoIcons.shopping_cart),
                _buildDivider(colorScheme),
                SettingsListTile(
                    title: "Telegram", leading: CupertinoIcons.paperplane),
                _buildDivider(colorScheme),
                SettingsListTile(
                    title: "Rate app", leading: CupertinoIcons.star),
                _buildDivider(colorScheme),
                SettingsListTile(title: "About", leading: CupertinoIcons.info),
                _buildDivider(colorScheme),
                SettingsListTile(
                  title: "Show introduction",
                  leading: CupertinoIcons.arrow_turn_up_left,
                  onTap: () {
                    Navigator.pushNamed(context, '/introScreen');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Container(
      height: 0.5,
      color: colorScheme.onSurface.withValues(alpha: 0.3),
    );
  }

  Widget? _getSelectedThemeIcon(BuildContext context, ThemeMode mode) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return themeProvider.themeMode == mode
        ? Icon(Icons.check, color: Theme.of(context).colorScheme.onSurface)
        : null;
  }
}
