import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final Map<String, dynamic> reminder;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      tileColor: Color(reminder['color']),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      leading: Icon(
        IconData(reminder['icon_code'], fontFamily: 'MaterialIcons'),
        color: colorScheme.onPrimary,
      ),
      title: Text(
        reminder['title'],
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (reminder['interval'] == 1)
            Text(
              'Every ${reminder['interval_minutes']} minutes',
              style: TextStyle(color: colorScheme.onPrimary.withOpacity(0.8)),
            ),
          if (reminder['dateTime'] == 1)
            Text(
              'Specific Time',
              style: TextStyle(color: colorScheme.onPrimary.withOpacity(0.8)),
            ),
          if (reminder['weekday'] == 1)
            Text(
              'Weekly',
              style: TextStyle(color: colorScheme.onPrimary.withOpacity(0.8)),
            ),
          if (reminder['repeating'] == 1)
            Text(
              'Repeating',
              style: TextStyle(color: colorScheme.onPrimary.withOpacity(0.8)),
            ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: colorScheme.onPrimary),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
