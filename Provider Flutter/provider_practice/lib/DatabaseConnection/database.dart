import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider_practice/DataModel/TaskData.dart';
import 'package:sqflite/sqflite.dart';

class CustomDatabase extends ChangeNotifier{

  Future<Database> database;
  List<TaskData> tasks = List<TaskData>();

  void initializeDB() async{
    database = openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version){

        return db.execute('CREATE TABLE checklist(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, status INTEGER, date TEXT)');
      },
      version: 1,
    );
  }
  Future<void> insert(TaskData taskData) async {
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      version: 1,
    );
    await db.insert('checklist', taskData.toMap());
    notifyListeners();
  }

  Future<void> update(TaskData taskData) async{

    Database db = await openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      version: 1,
    );

    db.update('checklist', taskData.toMap(), where: 'id = ?', whereArgs: [taskData.id]);
    notifyListeners();
  }
  Future<void> delete(TaskData taskData) async{

    Database db = await await openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      version: 1,
    );
    db.delete('checklist', where: 'id = ?', whereArgs: [taskData.id]);
    notifyListeners();
  }
  bool _getStatus(int status){

    return status == 1? true : false;
  }

  TaskData _getTasks(Map<String, dynamic> map){
    return TaskData(
      id: map['id'],
      title: map['title'],
      status: _getStatus(map['status']),
      date: map['date']
    );
  }
  Future<List<TaskData>> retrieve(DateTime dateTime) async{

    Database db = await openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      version: 1,
    );
    List<Map<String, dynamic>> list = await db.query('checklist', where: 'date = "${DateFormat('d/M/y').format(dateTime)}"');
    return list.map((taskData) => _getTasks(taskData)).toList();
  }
}