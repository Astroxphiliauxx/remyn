import 'package:flutter/material.dart';

import '../../../app_theme/app_typography.dart';
import 'reminder_countdown.dart';
import 'reminder_progress_bar.dart';

class ReminderCard extends StatelessWidget {
  final Map<String, dynamic> reminder;

  const ReminderCard({
    super.key,
    required this.reminder,
  });

  Color get _accentColor => Color(reminder['color'] as int);

  DateTime? get _scheduledAt {
    final raw = reminder['scheduled_at_ms'];
    if (raw == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(raw as int);
  }

  DateTime? get _createdAt {
    final raw = reminder['created_at_ms'];
    if (raw == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(raw as int);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scheduledAt = _scheduledAt;
    final showCountdown = reminder['dateTime'] == 1 && scheduledAt != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // TODO: Open reminder details for edit/delete flow.
        },
        //only top left and right rounded
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
        ),
            border: Border.all(color: _accentColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminder['title'] as String,
                          style: AppTypography.editorialTitle.copyWith(
                            fontSize: 24,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _subtitle(scheduledAt),
                          style: AppTypography.label.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    if (showCountdown)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: ReminderCountdownBadge(
                          targetAt: scheduledAt,
                          accentColor: _accentColor,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                child: ReminderProgressBar(
                  createdAt: _createdAt,
                  scheduledAt: scheduledAt,
                  accentColor: _accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle(DateTime? scheduledAt) {
    if (reminder['interval'] == 1) {
      return 'Every ${reminder['interval_minutes']} minutes';
    }
    if (reminder['dateTime'] == 1 && scheduledAt != null) {
      return _formatScheduledAt(scheduledAt);
    }
    if (reminder['weekday'] == 1) return 'Weekly';
    if (reminder['repeating'] == 1) return 'Repeating';
    return 'Reminder';
  }

  String _formatScheduledAt(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final scheduledDay = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (scheduledDay == today) {
      return 'Today, ${_formatTime(dateTime)}';
    }

    return 'Due ${_pad(dateTime.day)}-${_pad(dateTime.month)}'
        '${dateTime.year.toString().substring(2)}, ${_formatTime(dateTime)}';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${_pad(dateTime.minute)} $period';
  }

  String _pad(int value) => value.toString().padLeft(2, '0');
}
