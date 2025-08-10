import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
          style: TextStyle(color: colorScheme.onSurface, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.secondary, // Use theme secondary color
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Not active", style: TextStyle(color: colorScheme.onSurface, fontSize: 14)),
                        SizedBox(height: 4),
                        Text("Remyn Pro", style: TextStyle(color: colorScheme.onSurface, fontSize: 18, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Icon(CupertinoIcons.right_chevron, color: colorScheme.onSurface, size: 32),
                  ],
                ),
              ),
            ),

            _buildSectionContainer("Theme", context, [
              _buildListTile(
                "System",
                context,
                trailing: _getSelectedThemeIcon(context, ThemeMode.system),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false).setTheme(ThemeMode.system);
                },
              ),
              _buildDivider(colorScheme),
              _buildListTile(
                "Light",
                context,
                trailing: _getSelectedThemeIcon(context, ThemeMode.light),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false).setTheme(ThemeMode.light);
                },
              ),
              _buildDivider(colorScheme),
              _buildListTile(
                "Dark",
                context,
                trailing: _getSelectedThemeIcon(context, ThemeMode.dark),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false).setTheme(ThemeMode.dark);
                },
              ),
            ]),

            _buildSectionContainer("More", context, [
              _buildListTile("More apps", context, leading: CupertinoIcons.shopping_cart),
              _buildDivider(colorScheme),
              _buildListTile("Telegram", context, leading: CupertinoIcons.paperplane),
              _buildDivider(colorScheme),
              _buildListTile("Rate app", context, leading: CupertinoIcons.star),
              _buildDivider(colorScheme),
              _buildListTile("About", context, leading: CupertinoIcons.info),
              _buildDivider(colorScheme),
              _buildListTile(
                "Show introduction",
                context,
                leading: CupertinoIcons.arrow_turn_up_left,
                onTap: () {
                  Navigator.pushNamed(context, '/introScreen');
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContainer(String title, BuildContext context, List<Widget> children) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: colorScheme.onSurface, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, BuildContext context, {IconData? leading, Widget? trailing, VoidCallback? onTap}) {
    final colorScheme = Theme.of(context).colorScheme;
    return CupertinoListTile(
      backgroundColor: Colors.transparent,
      leading: leading != null ? Icon(leading, color: colorScheme.onSurface) : null,
      title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
      trailing: trailing,
      onTap: onTap,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Container(
      height: 0.5,
      color: colorScheme.onSurface.withOpacity(0.3),
    );
  }

  Widget? _getSelectedThemeIcon(BuildContext context, ThemeMode mode) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return themeProvider.themeMode == mode ? Icon(Icons.check, color: Theme.of(context).colorScheme.onSurface) : null;
  }
}
