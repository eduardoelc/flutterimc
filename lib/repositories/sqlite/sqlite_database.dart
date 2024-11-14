import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: ''' CREATE TABLE registro_imc (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pessoaId INTEGER NOT NULL,
          peso REAL NOT NULL,
          altura REAL NOT NULL,
          imc REAL NOT NULL,
          data TEXT NOT NULL,
          classificacao TEXT NOT NULL
          ) '''
};

class SQLiteDatabase {
  static Database? db;

  Future<Database> getDatabase() async {
    if (db == null) {
      return await iniciarBancoDeDados();
    }
    return db!;
  }

  Future iniciarBancoDeDados() async {
    var db = openDatabase(
      path.join(await getDatabasesPath(), 'database.db'),
      version: scripts.length,
      onCreate: (Database db, int version) async {
        for (var i = 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
          debugPrint(scripts[i]);
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (var i = oldVersion + 1; i < scripts.length; i++) {
          await db.execute(scripts[i]!);
          debugPrint(scripts[i]);
        }
      },
    );
    return db;
  }
}
