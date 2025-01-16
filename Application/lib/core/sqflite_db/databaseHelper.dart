import 'package:sqflite/sqflite.dart';

Database? db;

class DatabaseHelper {
  Future<void> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = '$path/allTables.db';

    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("PRAGMA foreign_keys = ON");
        await createTables(db: db);
      },
    );
  }

  Future<void> createTables({required Database db}) async {
    await db.execute(
      '''CREATE TABLE sensorLogs (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       logString TEXT, 
       logTime TEXT
       )
       ''',
    );
  }
}
