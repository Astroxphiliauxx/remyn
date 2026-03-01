import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Text("Profile Page",
          style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 30),
        ),
      ),
    );

  }
}