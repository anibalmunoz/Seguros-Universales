import 'package:sqflite/sqflite.dart';

class TableManager {
  TableManager._privateContructor();
  static final TableManager shared = TableManager._privateContructor();

  Future<void> cliente(Database db) async {
    const String table = "CREATE TABLE clienteprueba("
        "dnicl INTEGER PRIMARY KEY AUTOINCREMENT,"
        "nombrecl TEXT,"
        "apellido1 TEXT,"
        "apellido2 TEXT,"
        "clasevia TEXT,"
        "nombrevia TEXT,"
        "numerovia TEXT,"
        "codpostal TEXT,"
        "ciudad TEXT,"
        "telefono INTEGER,"
        "observaciones TEXT,"
        "correo TEXT,"
        "contrasena TEXT"
        ")";

    const String seguros = "CREATE TABLE seguros("
        "numeropoliza INTEGER PRIMARY KEY AUTOINCREMENT,"
        "ramo TEXT,"
        "fechainicio TEXT,"
        "fechavencimiento TEXT,"
        "condicionesparticulares TEXT,"
        "observaciones TEXT"
        ")";

    const String siniestros = "CREATE TABLE siniestros("
        "idsiniestro INTEGER PRIMARY KEY AUTOINCREMENT,"
        "fechasiniestro TEXT,"
        "causas TEXT,"
        "aceptado TEXT,"
        "indemnizacion TEXT)";

    await db.execute(table);

    await db.execute(seguros);

    await db.execute(siniestros);
  }
}
