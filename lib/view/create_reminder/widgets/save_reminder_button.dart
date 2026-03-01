import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/color_provider.dart';

class SaveReminderButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveReminderButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colorProvider = Provider.of<ColorProvider>(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: colorScheme.surface,
      child: CupertinoButton(
        color: colorProvider.selectedColor,
        borderRadius: BorderRadius.circular(30),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.add, color: colorScheme.onPrimary),
            SizedBox(width: 8),
            Text("Create reminder",
                style: TextStyle(color: colorScheme.onPrimary, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
