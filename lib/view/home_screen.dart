import 'package:flutter/material.dart';

import 'bottomNavBar/home_tab.dart';
import 'bottomNavBar/reminders_tab.dart';
import 'bottomNavBar/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeTab(),
    RemindersTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.surface,
        currentIndex: _currentIndex,
        selectedFontSize: 20,
        unselectedFontSize: 15,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Reminders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
