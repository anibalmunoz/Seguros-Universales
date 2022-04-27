import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/repository/db_manager.dart';
import 'package:arquitectura_universales/repository/master_repository.dart';
import 'package:sqflite/sqflite.dart';

class ClienteRepository extends MasterRepository {
  ClienteRepository._privateConstructor();
  static final shared = ClienteRepository._privateConstructor();

  Future<void> updateCliente(
      {required String tableName, required Cliente cliente}) async {
    Database dbManager = await DbManager().db;
    await dbManager.update(
      tableName,
      cliente.toMap(),
      where: "dnicl = ?",
      whereArgs: [cliente.dnicl],
    );
  }

  Future<void> insertCliente(
      {required String tableName, required Cliente cliente}) async {
    Database dbManager = await DbManager().db;
    await dbManager.insert(
      tableName,
      cliente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> eliminarCliente(
      {required String tableName, required int id}) async {
    Database dbManager = await DbManager().db;
    await dbManager.delete(
      tableName, where: "dnicl = ?",
      // Pasa el id param a través de whereArg para prevenir SQL injection
      whereArgs: [id],
    );
  }

  Future<List<Cliente>> buscarClienteLoguin(
      {required String tableName,
      required String correo,
      required String contrasena}) async {
    Database dbManager = await DbManager().db;

    final List<Map<String, dynamic>> lista = await dbManager.query(tableName,
        where: " correo = ? and contrasena = ?",
        whereArgs: [correo, contrasena]);

    print("LA LISTA DESDE EL REPOSITORIO ES: ${lista}");

    return List.generate(lista.length, (i) {
      return Cliente(
        correo: lista[i]['correo'],
        contrasena: lista[i]['contrasena'],
      );
    });
  }
}
