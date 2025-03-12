import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path;
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      path = 'reminders_web.db';
    } else {
      path = join(await getDatabasesPath(), 'reminders.db');
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE reminders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            interval INTEGER NOT NULL, 
            dateTime INTEGER NOT NULL, 
            weekday INTEGER NOT NULL,  
            repeating INTEGER NOT NULL  
          )
        ''');
      },
    );
  }

  Future<int> insertReminder(Map<String, dynamic> reminder) async {
    final db = await database;
    return await db.insert('reminders', reminder);
  }

  Future<List<Map<String, dynamic>>> getReminders() async {
    final db = await database;
    return await db.query('reminders');
  }
}
