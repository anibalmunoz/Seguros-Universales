import 'package:arquitectura_universales/model/siniestro_model.dart';
import 'package:arquitectura_universales/repository/db_manager.dart';
import 'package:arquitectura_universales/repository/master_repository.dart';
import 'package:sqflite/sqflite.dart';

class SiniestroRepository extends MasterRepository {
  SiniestroRepository._privateConstructor();
  static final shared = SiniestroRepository._privateConstructor();

  Future<void> updateSiniestro(
      {required String tableName, required Siniestro siniestro}) async {
    Database dbManager = await DbManager().db;
    await dbManager.update(
      tableName,
      siniestro.toMap(),
      where: "idsiniestro = ?",
      whereArgs: [siniestro.idSiniestro],
    );
  }

  Future<void> insertSiniestro(
      {required String tableName, required Siniestro siniestro}) async {
    Database dbManager = await DbManager().db;
    await dbManager.insert(
      tableName,
      siniestro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteSiniestro(
      {required String tableName, required int id}) async {
    Database dbManager = await DbManager().db;
    await dbManager.delete(
      tableName, where: "idsiniestro = ?",
      // Pasa el id param a través de whereArg para prevenir SQL injection
      whereArgs: [id],
    );
  }
}
