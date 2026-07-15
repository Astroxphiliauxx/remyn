import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/reminders_provider.dart';
import '../../../create_reminder/create_reminder_page.dart';
import '../reminder_card.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final remindersProvider = context.watch<RemindersProvider>();
    final reminders = remindersProvider.reminders;

    return Scaffold(
      appBar: AppBar(title: Text("Reminders")),
      body: remindersProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : reminders.isEmpty
              ? Center(child: Text("No Reminders Yet"))
              : ListView.builder(
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = reminders[index];
                    return Column(
                      children: [
                        ReminderCard(
                          reminder: reminder,
                          onDelete: () =>
                              _deleteReminder(context, reminder['id']),
                          onTap: () {},
                        ),
                      ],
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewReminderPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteReminder(BuildContext context, int id) async {
    final remindersProvider = context.read<RemindersProvider>();
    final deleted = await remindersProvider.deleteReminder(id);
    if (!context.mounted || deleted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          remindersProvider.errorMessage ?? 'Could not delete reminder',
        ),
      ),
    );
  }
}
