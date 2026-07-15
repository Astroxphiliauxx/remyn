import 'package:flutter_test/flutter_test.dart';
import 'package:remyn/controller/reminders_provider.dart';

void main() {
  group('RemindersProvider', () {
    test('loadReminders populates reminders and notifies listeners', () async {
      var notifyCount = 0;
      final provider = RemindersProvider(
        getReminders: () async => [
          {'id': 1, 'title': 'Wake up'},
        ],
      )..addListener(() => notifyCount++);

      await provider.loadReminders();

      expect(provider.reminders, [
        {'id': 1, 'title': 'Wake up'},
      ]);
      expect(provider.isLoading, isFalse);
      expect(provider.errorMessage, isNull);
      expect(notifyCount, greaterThanOrEqualTo(2));
    });

    test('createReminder reloads list after insert', () async {
      final stored = <Map<String, dynamic>>[
        {'id': 1, 'title': 'Old'},
      ];

      final provider = RemindersProvider(
        getReminders: () async => List<Map<String, dynamic>>.from(stored),
        insertReminder: (reminder) async {
          stored.add({...reminder, 'id': 2});
          return 2;
        },
      );

      final saved = await provider.createReminder({'title': 'New'});

      expect(saved, isTrue);
      expect(provider.reminders.length, 2);
      expect(provider.reminders.last['title'], 'New');
      expect(provider.errorMessage, isNull);
    });

    test('deleteReminder reloads list after delete', () async {
      final stored = <Map<String, dynamic>>[
        {'id': 1, 'title': 'Keep'},
        {'id': 2, 'title': 'Remove'},
      ];

      final provider = RemindersProvider(
        getReminders: () async => List<Map<String, dynamic>>.from(stored),
        deleteReminder: (id) async {
          stored.removeWhere((reminder) => reminder['id'] == id);
          return 1;
        },
      );
      await provider.loadReminders();

      final deleted = await provider.deleteReminder(2);

      expect(deleted, isTrue);
      expect(provider.reminders.length, 1);
      expect(provider.reminders.first['title'], 'Keep');
      expect(provider.errorMessage, isNull);
    });

    test('failed delete keeps list unchanged and sets error', () async {
      final stored = <Map<String, dynamic>>[
        {'id': 1, 'title': 'Keep'},
      ];

      final provider = RemindersProvider(
        getReminders: () async => List<Map<String, dynamic>>.from(stored),
        deleteReminder: (_) async => throw Exception('db down'),
      );
      await provider.loadReminders();

      final deleted = await provider.deleteReminder(1);

      expect(deleted, isFalse);
      expect(provider.reminders.length, 1);
      expect(provider.errorMessage, 'Could not delete reminder');
    });
  });
}
