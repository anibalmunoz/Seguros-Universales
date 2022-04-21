import 'package:arquitectura_universales/model/seguro-model.dart';
import 'package:arquitectura_universales/repository/db_manager.dart';
import 'package:arquitectura_universales/repository/master_repository.dart';
import 'package:sqflite/sqflite.dart';

class SeguroRepository extends MasterRepository {
  SeguroRepository._privateConstructor();
  static final shared = SeguroRepository._privateConstructor();

  Future<void> updateSeguro(
      {required String tableName, required Seguro seguro}) async {
    Database dbManager = await DbManager().db;
    await dbManager.update(
      tableName,
      seguro.toMap(),
      where: "numeropoliza = ?",
      whereArgs: [seguro.numeroPoliza],
    );
  }

  Future<void> insertSeguro(
      {required String tableName, required Seguro seguro}) async {
    Database dbManager = await DbManager().db;
    await dbManager.insert(
      tableName,
      seguro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> eliminarSeguro(
      {required String tableName, required int id}) async {
    Database dbManager = await DbManager().db;
    await dbManager.delete(
      tableName, where: "numeropoliza = ?",
      // Pasa el id param a través de whereArg para prevenir SQL injection
      whereArgs: [id],
    );
  }
}
