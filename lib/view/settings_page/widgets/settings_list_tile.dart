import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final IconData? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsListTile({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CupertinoListTile(
      backgroundColor: Colors.transparent,
      leading:
          leading != null ? Icon(leading, color: colorScheme.onSurface) : null,
      title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
      trailing: trailing,
      onTap: onTap,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    );
  }
}
