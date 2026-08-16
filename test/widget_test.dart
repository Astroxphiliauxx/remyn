import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remyn/app_theme/app_theme.dart';
import 'package:remyn/utils/schedule_date_format.dart';
import 'package:remyn/view/bottomNavBar/widgets/reminder_card.dart';
import 'package:remyn/view/bottomNavBar/widgets/reminder_countdown.dart';
import 'package:remyn/view/bottomNavBar/widgets/reminder_progress_bar.dart';

void main() {
  final now = DateTime(2026, 7, 14, 12, 0, 0);

  group('formatCountdown', () {
    test('formats sub-hour durations as mm:ss', () {
      expect(formatCountdown(const Duration(minutes: 4, seconds: 32)), '04:32');
      expect(formatCountdown(const Duration(seconds: 9)), '00:09');
    });

    test('formats hour-plus durations as hh:mm:ss', () {
      expect(
        formatCountdown(const Duration(hours: 1, minutes: 2, seconds: 3)),
        '01:02:03',
      );
    });

    test('formats multi-day durations with day prefix', () {
      expect(
        formatCountdown(const Duration(days: 2)),
        '2D 00:00:00',
      );
      expect(
        formatCountdown(
            const Duration(days: 1, hours: 7, minutes: 59, seconds: 45)),
        '1D 07:59:45',
      );
    });

    test('zero duration shows 00:00', () {
      expect(formatCountdown(Duration.zero), '00:00');
    });
  });

  group('countdownSemanticsLabel', () {
    test('returns due now at zero', () {
      expect(countdownSemanticsLabel(Duration.zero), 'Due now');
    });

    test('returns minute and hour labels', () {
      expect(
        countdownSemanticsLabel(const Duration(hours: 2, minutes: 5)),
        'Due in 2 hours 5 minutes',
      );
      expect(
        countdownSemanticsLabel(const Duration(minutes: 3, seconds: 40)),
        'Due in 3 minutes',
      );
    });
  });

  group('countdownRemaining', () {
    test('returns future remaining duration', () {
      final target = now.add(const Duration(minutes: 5, seconds: 10));
      expect(
        countdownRemaining(target, now),
        const Duration(minutes: 5, seconds: 10),
      );
    });

    test('clamps past targets to zero', () {
      final target = now.subtract(const Duration(seconds: 1));
      expect(countdownRemaining(target, now), Duration.zero);
    });
  });

  group('isCountdownDue', () {
    test('is false before target and true at or after target', () {
      final target = now.add(const Duration(seconds: 30));

      expect(isCountdownDue(target, now), isFalse);
      expect(
        isCountdownDue(target, now.add(const Duration(seconds: 29))),
        isFalse,
      );
      expect(
        isCountdownDue(target, now.add(const Duration(seconds: 30))),
        isTrue,
      );
      expect(
        isCountdownDue(target, now.add(const Duration(minutes: 1))),
        isTrue,
      );
    });
  });

  group('ScheduleDateFormat', () {
    test('uses ordinal suffixes', () {
      expect(ScheduleDateFormat.ordinalSuffix(1), 'st');
      expect(ScheduleDateFormat.ordinalSuffix(2), 'nd');
      expect(ScheduleDateFormat.ordinalSuffix(3), 'rd');
      expect(ScheduleDateFormat.ordinalSuffix(11), 'th');
      expect(ScheduleDateFormat.ordinalSuffix(17), 'th');
      expect(ScheduleDateFormat.ordinalSuffix(22), 'nd');
    });

    test('formats month and day', () {
      expect(
        ScheduleDateFormat.monthDay(DateTime(2026, 12, 17)),
        'Dec 17',
      );
    });
  });

  group('reminderProgress', () {
    test('returns null without timing data', () {
      expect(
        reminderProgress(
          createdAt: null,
          scheduledAt: now.add(const Duration(hours: 1)),
          now: now,
        ),
        isNull,
      );
    });

    test('returns progress between creation and scheduled time', () {
      final created = now;
      final scheduled = now.add(const Duration(hours: 2));

      expect(
        reminderProgress(
          createdAt: created,
          scheduledAt: scheduled,
          now: now,
        ),
        1.0,
      );
      expect(
        reminderProgress(
          createdAt: created,
          scheduledAt: scheduled,
          now: now.add(const Duration(hours: 1)),
        ),
        closeTo(0.5, 0.01),
      );
      expect(
        reminderProgress(
          createdAt: created,
          scheduledAt: scheduled,
          now: scheduled,
        ),
        0.0,
      );
    });
  });

  group('ReminderProgressBar', () {
    testWidgets('synchronizes width with absolute time left', (tester) async {
      final createdAt = DateTime(2026, 7, 14, 12);
      final scheduledAt = createdAt.add(const Duration(seconds: 10));
      var currentTime = createdAt;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: ReminderProgressBar(
                createdAt: createdAt,
                scheduledAt: scheduledAt,
                accentColor: Colors.blue,
                now: () => currentTime,
              ),
            ),
          ),
        ),
      );

      BoxConstraints fillConstraints() {
        return tester
            .widget<AnimatedContainer>(
              find.byKey(const Key('reminder-progress-fill')),
            )
            .constraints!;
      }

      expect(fillConstraints().maxWidth, 200);

      currentTime = createdAt.add(const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 1));
      expect(fillConstraints().maxWidth, 100);

      currentTime = scheduledAt;
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key('reminder-progress-fill')), findsNothing);
    });

    testWidgets('hides when scheduled_at is past without created_at',
        (tester) async {
      final scheduledAt = DateTime(2026, 7, 14, 12);
      final currentTime = scheduledAt;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReminderProgressBar(
              createdAt: null,
              scheduledAt: scheduledAt,
              accentColor: Colors.blue,
              now: () => currentTime,
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('reminder-progress-fill')), findsNothing);
    });
  });

  group('ReminderCard', () {
    final reminder = {
      'title': 'Morning Meditation',
      'interval': 0,
      'dateTime': 1,
      'weekday': 0,
      'repeating': 0,
      'color': 0xFF81C784,
      'icon_code': 0xe3a3,
      'scheduled_at_ms':
          DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch,
      'created_at_ms': DateTime.now().millisecondsSinceEpoch,
    };

    Future<void> pumpCard(
      WidgetTester tester, {
      required ThemeData theme,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ReminderCard(reminder: reminder),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('renders editorial title in light theme', (tester) async {
      await pumpCard(tester, theme: AppTheme.lightTheme);

      expect(find.text('Morning Meditation'), findsOneWidget);
      expect(find.byType(ReminderProgressBar), findsOneWidget);
    });

    testWidgets('renders editorial title in dark theme', (tester) async {
      await pumpCard(tester, theme: AppTheme.darkTheme);

      expect(find.text('Morning Meditation'), findsOneWidget);
      expect(find.byType(ReminderCountdownBadge), findsOneWidget);
    });
  });
}
