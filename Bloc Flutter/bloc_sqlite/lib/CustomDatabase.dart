import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class CustomDatabase{

  CustomDatabase._();

  static const  databaseName = 'new.db';
  static final CustomDatabase instance = CustomDatabase._();
  static Database _database;

  Future<Database> get database async{

    if (_database == null){

      return await initializeDB();
    }else{

      return _database;
    }
  }

  initializeDB() async{
    return await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: 1,
      onCreate: (db, version) async{

        return await db.execute('CREATE TABLE NEW(name TEXT)');
      }
    );
  }

  String returnName(Map<String, dynamic> map){

    return map['name'];
  }
  Future<List<String>> returnData() async{

    final Database db = await database;

    final List<Map<String, dynamic>> list = await db.query('NEW');

    return list.map(returnName).toList();
  }

  Future<void> insertData(String name) async{

    final Database db = await database;
    db.insert('NEW', {'name': name});
  }
}