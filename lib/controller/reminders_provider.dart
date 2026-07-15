import 'package:flutter/foundation.dart';

import '../model/database_helper.dart';

typedef RemindersLoader = Future<List<Map<String, dynamic>>> Function();
typedef ReminderInserter = Future<int> Function(Map<String, dynamic> reminder);
typedef ReminderDeleter = Future<int> Function(int id);

class RemindersProvider extends ChangeNotifier {
  RemindersProvider({
    RemindersLoader? getReminders,
    ReminderInserter? insertReminder,
    ReminderDeleter? deleteReminder,
  })  : _getReminders = getReminders ?? DatabaseHelper().getReminders,
        _insertReminder = insertReminder ?? DatabaseHelper().insertReminder,
        _deleteReminder = deleteReminder ?? DatabaseHelper().deleteReminder;

  final RemindersLoader _getReminders;
  final ReminderInserter _insertReminder;
  final ReminderDeleter _deleteReminder;

  List<Map<String, dynamic>> _reminders = [];

  List<Map<String, dynamic>> get reminders => List.unmodifiable(_reminders);

  bool isLoading = false;
  String? errorMessage;

  Future<void> loadReminders() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _reminders = await _getReminders();
    } catch (_) {
      _reminders = [];
      errorMessage = 'Could not load reminders';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createReminder(Map<String, dynamic> reminder) async {
    try {
      await _insertReminder(reminder);
      await _reloadAfterMutation();
      return true;
    } catch (_) {
      errorMessage = 'Could not save reminder';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteReminder(int id) async {
    try {
      await _deleteReminder(id);
      await _reloadAfterMutation();
      return true;
    } catch (_) {
      errorMessage = 'Could not delete reminder';
      notifyListeners();
      return false;
    }
  }

  Future<void> _reloadAfterMutation() async {
    _reminders = await _getReminders();
    errorMessage = null;
    notifyListeners();
  }
}
