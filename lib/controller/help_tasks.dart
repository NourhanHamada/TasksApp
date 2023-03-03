import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../model/task_model.dart';

class HelpTasks {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  initialDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'tasktodo.db');

    var myDB = await openDatabase(path, version: 26, onCreate: _onCreate);
    return myDB;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todo(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, description TEXT NOT NULL, title TEXT NOT NULL, date TEXT NOT NULL, done TEXT NOT NULL)');
  }

  Future<int> insertDB(Map<String, dynamic> data) async {
    Database? dbClint = await db;
    var result = dbClint!.insert("todo", data);
    return result;
  }

  deleteDatabaseById(int id) async {
    Database? dbClint = await db;
    var result = dbClint!.rawUpdate('DELETE FROM todo WHERE id ="$id"');
    return result;
  }

  updateDatabaseById(String description, int id) async {
    Database? dbClint = await db;
    var result = dbClint!.rawUpdate(
        'UPDATE todo SET description="$description" WHERE id ="$id"');
    return result;
  }

  getSingleRowBD(int id) async {
    Database? dbClint = await db;
    var result = dbClint!.query('todo', where: 'id "$id"');
    return result;
  }

  // IN PROGRESS
  Future<List<TaskModel>> getDB() async {
    List<TaskModel> list = [];
    Database? dbClint = await db;
    var result = await dbClint!.query('todo');
    for (var i in result) {
      list.add(TaskModel(
          id: i['id'],
          description: i['description'],
          title: i['title'],
          date: i['date'],
          done: i['done']));
    }
    return list;
  }
}
