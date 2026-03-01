import 'package:flutter/material.dart';
import '../../../../model/database_helper.dart';
import '../../../create_reminder/create_reminder_page.dart';
import '../reminder_card.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reminders")),
      body: reminders.isEmpty
          ? Center(child: Text("No Reminders Yet"))
          : ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                var reminder = reminders[index];
                return Column(
                  children: [
                    ReminderCard(
                      reminder: reminder,
                      onDelete: () => dbHelper.deleteReminder(reminder['id']),
                      onTap: () {},
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewReminderPage()),
          );
          if (result == true) _loadReminders();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _loadReminders() async {
    List<Map<String, dynamic>> data = await dbHelper.getReminders();
    setState(() {
      reminders = data;
    });
  }
}
