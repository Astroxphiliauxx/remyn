import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/auto_scrolling_icons.dart';

class RemindersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CupertinoNavigationBar(
        backgroundColor: colorScheme.surface.withOpacity(0.9),
        middle: Text(
          "Reminders",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/settings");
          },
          child: Icon(
            CupertinoIcons.settings,
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/createReminder");
              },
              child: Icon(
                CupertinoIcons.add_circled,
                color: colorScheme.onSurface,
                size: 26,
              ),
            ),
            SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                // Tick Action
              },
              child: Icon(
                CupertinoIcons.check_mark_circled,
                color: colorScheme.onSurface,
                size: 26,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          AutoScrollingIcons(paddingOfIcons: 20, sizeOfIcons: 53),
          SizedBox(height: 60),
          Text(
            "No Reminders Yet",
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
             Navigator.pushNamed(context, '/createReminder');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: colorScheme.onSurface,
                borderRadius: BorderRadius.circular(60),

              ),
              child: Center(
                child: Text(
                  "+   Create Reminder",
                  style: TextStyle(
                    fontSize: 18,
                    color: colorScheme.surface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
