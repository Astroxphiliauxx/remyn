import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/color_provider.dart';
import '../../../controller/icon_provider.dart';
import '../../components/icon_picker.dart';

class IconTile extends StatelessWidget {
  const IconTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconProvider = Provider.of<IconProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);

    return GestureDetector(
      onTap: () => IconPicker.showIconPicker(context),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 23.0),
                child: Text(
                  "Icon",
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Icon(iconProvider.selectedIcon, color: colorProvider.selectedColor),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
