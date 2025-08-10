import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app_theme/app_theme.dart';
import 'controller/color_provider.dart';
import 'controller/icon_provider.dart';
import 'controller/theme_provider.dart';
import 'view/create_reminder.dart';
import 'view/bottomNavBar/bottom_nav_bar.dart';
import 'view/intro_screen.dart';
import 'view/settings_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  } else {
    databaseFactory = databaseFactory;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        ChangeNotifierProvider(create: (_) => IconProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          routes: {
            '/introScreen': (context) => IntroScreen(),
            '/homeScreen': (context) => BottomNavBar(),
            '/settings': (context) => SettingsPage(),
            '/createReminder': (context) => NewReminderPage(),
          },
          initialRoute: '/introScreen',
        );
      },
    );
  }
}
