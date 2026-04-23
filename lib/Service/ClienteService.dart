import 'package:app_flutter/Entity/Cliente.dart';
import 'package:app_flutter/bd/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

class ClienteService {
  Future<void> createCliente(Cliente cliente) async {
    final db = await Dbhelper.database;
    await db.insert(
      'cliente',
      cliente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCliente(Cliente cliente) async {
    final db = await Dbhelper.database;
    await db.update(
      'cliente',
      cliente.toMap(),
      where: 'cedula=?',
      whereArgs: [cliente.cedula],
    );
  }

  Future<void> deleteCliente(String cedula) async {
    final db = await Dbhelper.database;
    await db.delete('cliente', where: 'cedula = ? ', whereArgs: [cedula]);
  }

  Future<List<Cliente>> getAll() async {
    final db = await Dbhelper.database;
    final data = await db.query('cliente');
    return data.map((e) => Cliente.fromMap(e)).toList();
  }
}
