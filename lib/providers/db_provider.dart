import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  //Singleton
  static late Database _databasetemp;
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database ?? _databasetemp;
    _database = await createDB();
    return _database ?? _databasetemp;
  }

  Future<Database> createDB() async {
    //Necesitamos identificar donde se debe generar la BD
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "QRApp.db");

    //print(path);
    // Creamos y abrimos la database/tabla
    return openDatabase(
      path,
      version: 1,
      onOpen: (db) {
        //Open
      },
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
          CREATE TABLE Scan (
            id INTEGER PRIMARY KEY, 
            value TEXT
          )
          ''',
        );
        /* await db.execute(
          '''
          CREATE TABLE Scan2 (
            id INTEGER PRIMARY KEY, 
            value TEXT
          )
          ''',
        ); */
      },
    );
  }

  Future<List<ScanModel>> getAllScan() async {
    final db = await database;
    final response = await db.query("Scan");
    //print(response);
    return response.isNotEmpty
        ? response.map((json) => ScanModel.fromJson(json)).toList()
        : [];
  }

  Future<int> insertScan(ScanModel oScan) async {
    final db = await database;
    /* final response2 = await db.rawInsert('''
    INSERT INTO Scan (id, value)
    VALUES(${oScan.id}, ${oScan.value})
    '''); */
    final response = await db.insert("Scan", oScan.toJson());
    //print(response);
    return response;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    //final response = await db.delete("Scan", where: "id = ?, value = ?", whereArgs: [id, ""]);
    final response = await db.delete("Scan", where: "id = ?", whereArgs: [id]);
    return response;
  }
}
