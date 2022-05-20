
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'mfchistory';

  static const columnId = 'id';
  static const columnType  = 'type';
  static const columnMessage = 'message';
  static const columnSize = 'size';
  static const columnDate = 'date';
  static const scanType = 'scanType';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnType TEXT,
            $columnMessage TEXT, 
            $columnSize TEXT,
            $columnDate TEXT,
            $scanType TEXT
          )
          ''');
  }

  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }


  Future<List<Map<String, dynamic>>> queryGetTypeList(String type) async {
    Database? db = await instance.database;
    return await db!.rawQuery('SELECT * FROM $table where "${DatabaseHelper.scanType}" = "$type"');
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int?> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db?.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int?> delete(int id) async {
    Database? db = await instance.database;
    return await db?.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
