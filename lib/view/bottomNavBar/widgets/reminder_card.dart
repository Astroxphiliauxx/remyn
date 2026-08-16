import 'package:flutter/material.dart';

import '../../../app_theme/app_typography.dart';
import '../../../utils/schedule_date_format.dart';
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
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(12)),
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
                        if (reminder['dateTime'] == 1 && scheduledAt != null)
                          ScheduleDateFormat.richSubtitle(
                            dateTime: scheduledAt,
                            style: AppTypography.label.copyWith(
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                            timeLabel:
                                ScheduleDateFormat.formatTime12h(scheduledAt),
                          )
                        else
                          Text(
                            _subtitle(scheduledAt),
                            style: AppTypography.label.copyWith(
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.6),
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
                padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
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
    if (reminder['weekday'] == 1) return 'Weekly';
    if (reminder['repeating'] == 1) return 'Repeating';
    return 'Reminder';
  }
}
