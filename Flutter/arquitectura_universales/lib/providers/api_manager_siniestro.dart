import 'dart:convert';

import 'package:arquitectura_universales/model/siniestro_model.dart';
import 'package:arquitectura_universales/repository/siniestro_repository.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiManagerSiniestro {
  ApiManagerSiniestro._privateConstructor();
  static final ApiManagerSiniestro shared =
      ApiManagerSiniestro._privateConstructor();

  var contador = 0;

  static bool conectedToNetwork = false;

  Future<SiniestrosLista?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    String? jsonParam,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
    Siniestro? siniestro,
  }) async {
    List<Siniestro> siniestrosDb = [];
    final key = {};
    final uri = Uri.http(baseUrl, pathUrl);

    late http.Response response;
    switch (type) {
      case HttpType.GET:
        if (conectedToNetwork) {
          response = await http.get(uri);
          //agregarUbicacion("GET");
          List<Siniestro> siniestros = [];

          if (response.statusCode == 200) {
            final body = json.decode(utf8.decode(response.bodyBytes));

            for (var item in body) {
              siniestros.add(Siniestro(
                idSiniestro: item["idSiniestro"].toString(),
                fechaSiniestro: item["fechaSiniestro"],
                causas: item["causas"],
                aceptado: item["aceptado"],
                indemnizacion: item["indemnizacion"],
              ));
            }
            SiniestroRepository.shared.delete(tableName: "siniestros");

            SiniestroRepository.shared
                .save(data: siniestros, tableName: "siniestros");

            contador = contador + 1;
          }
        }

        List<dynamic> sinisterList =
            await SiniestroRepository.shared.selectAll(tableName: 'siniestros');

        for (var item in sinisterList) {
          siniestrosDb.add(Siniestro(
            idSiniestro: item['idsiniestro'].toString(),
            fechaSiniestro: item['fechasiniestro'],
            causas: item['causas'],
            aceptado: item['aceptado'],
            indemnizacion: item['indemnizacion'],
          ));
        }

        return SiniestrosLista.fromDb(siniestrosDb);

      case HttpType.POST:
        if (conectedToNetwork) {
          response = await http.post(
            uri,
            body: jsonParam,
            headers: {'Content-type': 'application/json; charset=UTF-8'},
          );
          print("EL CODIGO DE RESPUESTA ES:  ${response.statusCode}");

          agregarUbicacion("POST");
        } else {
          SiniestroRepository.shared
              .insertSiniestro(tableName: "siniestros", siniestro: siniestro!);
        }
        break;
      case HttpType.PUT:
        if (conectedToNetwork) {
          response = await http.post(
            uri,
            body: jsonParam,
            headers: {'Content-type': 'application/json; charset=UTF-8'},
          );
          print("EL CODIGO DE RESPUESTA ES:  ${response.statusCode}");

          agregarUbicacion("PUT");
        } else {
          SiniestroRepository.shared
              .updateSiniestro(tableName: "siniestros", siniestro: siniestro!);
        }
        break;
      case HttpType.DELETE:
        if (conectedToNetwork) {
          response = await http.delete(uri);

          agregarUbicacion("DELETE");
        } else {
          SiniestroRepository.shared.deleteSiniestro(
              tableName: "siniestros", id: int.parse(siniestro!.idSiniestro!));
        }
    }

    return null;
  }

  Position? _initialPosition;
  Position? get initialPosition => _initialPosition;

  Future<void> agregarUbicacion(tipoPeticion) async {
    FirebaseFirestore firestores = FirebaseFirestore.instance;
    CollectionReference ubicaciones = firestores.collection('ubicaciones');

    Future<void> addUbicacion() async {
      // Call the user's CollectionReference to add a new user

      final isEnable = await Geolocator.isLocationServiceEnabled();

      if (isEnable == true) {
        _initialPosition = await Geolocator.getCurrentPosition();
      }

      return ubicaciones
          .add({
            'ubicacion': _initialPosition.toString(),
            "detalles":
                "Peticion ${tipoPeticion} de SINIESTROS a la API _ FECHA: ${DateTime.now()}"
          })
          .then((value) => print(
              "UBICACION ENVIADA ${tipoPeticion} API MANAGER SINIESTRO _ FECHA: ${DateTime.now()} ES: ${_initialPosition}"))
          .catchError((error) =>
              print("ENVIO DE UBICACION A FIRESTORE FALLIDA: $error"));
    }

    addUbicacion();
  }
}
