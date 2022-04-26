import 'package:arquitectura_universales/repository/db_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class MasterRepository {
  Future<dynamic> save(
      {required List<dynamic> data, required String tableName}) async {
    Database dbManager = await DbManager().db;

    Batch batch = dbManager.batch();
    for (final item in data) {
      batch.insert(tableName, item.toDataBase());
    }

    return batch.commit();
  }

  Future<void> delete({required String tableName}) async {
    Database dbManager = await DbManager().db;
    dbManager.delete(tableName);
  }

  Future<List<Map<String, dynamic>>> selectAll(
      {required String tableName}) async {
    Database dbManager = await DbManager().db;
    return await dbManager.query(tableName);
  }

  Future<List<Map<String, dynamic>>> selectWhere(
      {required String tableName,
      required String whereClause,
      required List<String> whereArgs}) async {
    Database dbManager = await DbManager().db;
    return await dbManager.query(tableName,
        where: whereClause, whereArgs: whereArgs);
  }

  //MODIFICAR TABLA DE BASE DE DATOS

  Future<void> modificarTablaCliente() async {
    Database dbManager = await DbManager().db;
    String alter = "ALTER TABLE clienteprueba ADD COLUMN prueba TEXT";
    await dbManager.execute(alter);
  }
}
