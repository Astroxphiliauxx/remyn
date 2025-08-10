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
      version: 2, 
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE reminders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            interval INTEGER NOT NULL, 
            interval_minutes INTEGER DEFAULT 0,
            dateTime INTEGER NOT NULL, 
            weekday INTEGER NOT NULL,  
            repeating INTEGER NOT NULL,
            color INTEGER NOT NULL,
            icon_code INTEGER NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
         
          await db.transaction((txn) async {
           
            await txn.execute(
              'ALTER TABLE reminders ADD COLUMN interval_minutes INTEGER DEFAULT 0');
            await txn.execute(
              'ALTER TABLE reminders ADD COLUMN color INTEGER NOT NULL DEFAULT 0xFF2196F3'); 
            await txn.execute(
              'ALTER TABLE reminders ADD COLUMN icon_code INTEGER NOT NULL DEFAULT 0xe3a3'); 
          });
        }
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

  Future<int> updateReminder(int id, Map<String, dynamic> reminder) async {
    final db = await database;
    return await db.update(
      'reminders',
      reminder,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteReminder(int id) async {
    final db = await database;
    return await db.delete(
      'reminders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}