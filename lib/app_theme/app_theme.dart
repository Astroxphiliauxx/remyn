import 'package:flutter/material.dart';

import 'app_typography.dart';

class AppTheme {
  static final ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      primary: Colors.blue,
      secondary: Colors.grey[300]!,
      onPrimary: Colors.white,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
  );

  static final ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.black,
      primary: Colors.deepPurple,
      secondary: Colors.grey[900]!,
      onPrimary: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.deepPurple,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required Color scaffoldBackgroundColor,
    required Color primaryColor,
  }) {
    final onSurface = colorScheme.onSurface;
    final textTheme = TextTheme(
      displayLarge: AppTypography.display.copyWith(color: onSurface),
      displayMedium: AppTypography.display.copyWith(color: onSurface),
      displaySmall: AppTypography.title.copyWith(color: onSurface),
      headlineLarge: AppTypography.title.copyWith(color: onSurface),
      headlineMedium: AppTypography.title.copyWith(color: onSurface),
      headlineSmall: AppTypography.title.copyWith(color: onSurface),
      titleLarge: AppTypography.title.copyWith(color: onSurface),
      titleMedium: AppTypography.body.copyWith(color: onSurface),
      titleSmall: AppTypography.body.copyWith(color: onSurface),
      bodyLarge: AppTypography.body.copyWith(color: onSurface),
      bodyMedium: AppTypography.body.copyWith(color: onSurface),
      bodySmall: AppTypography.label.copyWith(color: onSurface),
      labelLarge: AppTypography.label.copyWith(color: onSurface),
      labelMedium: AppTypography.label.copyWith(color: onSurface),
      labelSmall: AppTypography.label.copyWith(color: onSurface),
    );

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      primaryColor: primaryColor,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: AppTypography.body.fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: onSurface,
        titleTextStyle: AppTypography.title.copyWith(color: onSurface),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: AppTypography.body,
        unselectedLabelStyle: AppTypography.label,
      ),
    );
  }
}
