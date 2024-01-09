import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_test/models/Task.dart';



class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Attendance.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async =>
            db.execute(
                " CREATE TABLE Task( id INTEGER PRIMARY KEY AUTOINCREMENT , taskName text , date text, time text , description text ) ;"),
        version: _version);
  }
  static Future<List<Map<String, Object?>>> getTask() async {
    Database db = await _getDB();
    return await db.query('Task');


  }


  static Future<int> insertUser( Task task) async {
    final db = await _getDB();
    return await db.insert("Task", task.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(int id,Task task) async {
    final db = await _getDB();
    return await db.update("Task", task.toJson(), where: 'id = ?', whereArgs: [id], conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<List<Map<String, Object?>>> getSingleUser(int id) async {
    final db = await _getDB();
    return db.query('User', where: "employeeCode= ?", whereArgs: [id],limit: 1,orderBy: "id DESC",);


  }



}