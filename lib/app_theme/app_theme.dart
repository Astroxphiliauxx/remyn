import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      primary: Colors.blue,
      secondary: Colors.grey[300]!,
      onPrimary: Colors.white,
      onSurface: Colors.black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.deepPurple,
    colorScheme: ColorScheme.dark(
      surface: Colors.black,
      primary: Colors.deepPurple,
      secondary: Colors.grey[900]!,
      onPrimary: Colors.white,
      onSurface: Colors.white,
    ),
  );
}
