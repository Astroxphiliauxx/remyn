import 'package:flutter/material.dart';

import '../../../app_theme/app_typography.dart';
import 'reminder_countdown.dart';

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

  DateTime? get _scheduledAt {
    final raw = reminder['scheduled_at_ms'];
    if (raw == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(raw as int);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scheduledAt = _scheduledAt;
    final showCountdown = reminder['dateTime'] == 1 && scheduledAt != null;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ListTile(
          tileColor: Color(reminder['color']),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.fromLTRB(
            16,
            showCountdown ? 36 : 16,
            16,
            16,
          ),
          leading: Icon(
            IconData(reminder['icon_code'], fontFamily: 'MaterialIcons'),
            color: colorScheme.onPrimary,
          ),
          title: Text(
            reminder['title'],
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onPrimary,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (reminder['interval'] == 1)
                Text(
                  'Every ${reminder['interval_minutes']} minutes',
                  style: AppTypography.label.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              if (reminder['dateTime'] == 1)
                Text(
                  scheduledAt != null
                      ? _formatScheduledAt(scheduledAt)
                      : 'Specific Time',
                  style: AppTypography.label.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              if (reminder['weekday'] == 1)
                Text(
                  'Weekly',
                  style: AppTypography.label.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              if (reminder['repeating'] == 1)
                Text(
                  'Repeating',
                  style: AppTypography.label.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: colorScheme.onPrimary),
            onPressed: onDelete,
          ),
          onTap: onTap,
        ),
        if (showCountdown)
          Positioned(
            top: 8,
            left: 8,
            child: ReminderCountdownBadge(
              targetAt: scheduledAt,
              textColor: colorScheme.onPrimary,
            ),
          ),
      ],
    );
  }

  String _formatScheduledAt(DateTime dateTime) {
    return '${_pad(dateTime.day)}/${_pad(dateTime.month)}/${dateTime.year} '
        '${_pad(dateTime.hour)}:${_pad(dateTime.minute)}';
  }

  String _pad(int value) => value.toString().padLeft(2, '0');
}
