import 'package:flutter/material.dart';
import '../../model/database_helper.dart';
import '../create_reminder.dart';


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
    final colorScheme = Theme.of(context).colorScheme;
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
                    ListTile(
                      title: Text(reminder['title'],
                                   style: TextStyle(
                                   fontSize: 20,
                                   color: colorScheme.onSurface,
                                  )
                              ),

                   ),
                  _buildTile("Repeating", reminder['repeating'] == 1 ? "Yes" : "No"),
                  _buildTile("Interval", reminder['interval'] == 1 ? "Yes" : "No"),
                  _buildTile("Date & time", reminder['dateTime'] == 1 ? "Yes" : "No"),
                  _buildTile("Weekday", reminder['weekday'] == 1 ? "Yes" : "No"),
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

  Widget _buildTile(String title, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "$title: $value",
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
