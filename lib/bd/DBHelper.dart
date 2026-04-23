import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'clientes.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE cliente(
          cedula TEXT PRIMARY KEY,
          nombre TEXT NOT NULL,
          apellido TEXT NOT NULL,
          email TEXT NOT NULL,
          fotoPath TEXT
        )''');
      },
    );
    return _db!;
  }
}
