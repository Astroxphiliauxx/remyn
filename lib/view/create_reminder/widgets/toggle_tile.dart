import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/color_provider.dart';

class ToggleTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const ToggleTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colorProvider = Provider.of<ColorProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Switch(
              activeColor: colorProvider.selectedColor,
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
