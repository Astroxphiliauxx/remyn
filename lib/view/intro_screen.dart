import 'package:flutter/material.dart';
import 'components/auto_scrolling_icons.dart';
import 'components/auto_scrolling_icons_2.dart';

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
          SizedBox(height: 260),
          SizedBox(
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 100,
                  left: 30,
                  right: 0,
                  child: AutoScrollingIcons(sizeOfIcons: 45,),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 100,
                  child: AutoScrollingIcons2(sizeOfIcons: 45),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),

          Text(
            "Welcome to remyn",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 10),
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

          Spacer(),

          GestureDetector(
            onHorizontalDragEnd: (details) {
              Navigator.pushNamed(context, '/homeScreen');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(bottom: 40),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                  SizedBox(width: 10),
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
