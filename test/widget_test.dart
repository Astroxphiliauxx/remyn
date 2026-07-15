import 'package:flutter_test/flutter_test.dart';
import 'package:remyn/view/bottomNavBar/widgets/reminder_countdown.dart';

void main() {
  final now = DateTime(2026, 7, 14, 12, 0, 0);

  group('formatCountdown', () {
    test('formats sub-hour durations as mm:ss', () {
      expect(formatCountdown(const Duration(minutes: 4, seconds: 32)), '04:32');
      expect(formatCountdown(const Duration(seconds: 9)), '00:09');
    });

    test('formats hour-plus durations as h:mm:ss', () {
      expect(
        formatCountdown(const Duration(hours: 1, minutes: 2, seconds: 3)),
        '1:02:03',
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
}
