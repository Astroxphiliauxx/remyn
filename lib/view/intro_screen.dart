import 'package:flutter/material.dart';
import 'components/synced_scrolling_icons.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 260),
          // 5. Use the new, single widget here
          SizedBox(
            height: 250,
            child: SyncedScrollingIcons(iconSize: 45),
          ),
          const SizedBox(height: 40),

          Text(
            "Welcome to Remyn",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Reminders made simple, easily set and track",
            style: TextStyle(
              fontSize: 18,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          Text(
            "reminders without a hassle.",
            style: TextStyle(
              fontSize: 18,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),

          const Spacer(),

          GestureDetector(
            onHorizontalDragEnd: (details) {
              Navigator.pushNamed(context, '/homeScreen');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.only(bottom: 40),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: colorScheme.onSurface.withOpacity(0.7), width: 2),
                color: colorScheme.onSurface,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Swipe to Start",
                    style: TextStyle(fontSize: 18, color: colorScheme.surface),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: colorScheme.surface),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}