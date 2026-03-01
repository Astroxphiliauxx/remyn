import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/color_provider.dart';

class IntervalOptions extends StatelessWidget {
  final List<int> intervalOptions;
  final int? selectedInterval;
  final ValueChanged<int?> onSelected;

  const IntervalOptions({
    super.key,
    required this.intervalOptions,
    required this.selectedInterval,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colorProvider = Provider.of<ColorProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(height: 8),
            Text(
              "Select Interval",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: intervalOptions.map((minutes) {
                return ChoiceChip(
                  label: Text('$minutes mins'),
                  selected: selectedInterval == minutes,
                  onSelected: (selected) {
                    onSelected(selected ? minutes : null);
                  },
                  selectedColor: colorProvider.selectedColor,
                  labelStyle: TextStyle(
                    color: selectedInterval == minutes
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
