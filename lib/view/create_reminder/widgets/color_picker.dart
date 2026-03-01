import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/color_provider.dart';

class ColorPicker extends StatelessWidget {
  final List<Color> colors;

  const ColorPicker({
    super.key,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colorProvider = Provider.of<ColorProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(colors.length, (index) {
          return GestureDetector(
            onTap: () => colorProvider.changeColor(colors[index]),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: colors[index],
                shape: BoxShape.circle,
                border: colorProvider.selectedColor == colors[index]
                    ? Border.all(color: colorScheme.onSurface, width: 3)
                    : null,
              ),
            ),
          );
        }),
      ),
    );
  }
}
