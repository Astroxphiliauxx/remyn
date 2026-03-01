import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                Text("Not active",
                    style:
                        TextStyle(color: colorScheme.onSurface, fontSize: 14)),
                SizedBox(height: 4),
                Text("Remyn Pro",
                    style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
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
