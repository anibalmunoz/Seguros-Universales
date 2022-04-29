import 'dart:convert';

import 'package:arquitectura_universales/model/seguro-model.dart';
import 'package:arquitectura_universales/repository/seguro_repository.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiManagerSeguro {
  ApiManagerSeguro._privateConstructor();
  static final ApiManagerSeguro shared = ApiManagerSeguro._privateConstructor();

  var contador = 0;

  static bool conectedToNetwork = false;

  Future<SegurosLista?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    String? jsonParam,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
    Seguro? seguro,
  }) async {
    List<Seguro> segurosDb = [];
    final key = {};
    final uri = Uri.http(baseUrl, pathUrl);

    late http.Response response;
    switch (type) {
      case HttpType.GET:
        if (conectedToNetwork) {
          response = await http.get(uri);
          //   agregarUbicacion("GET");
          List<Seguro> seguros = [];

          if (response.statusCode == 200) {
            final body = json.decode(utf8.decode(response.bodyBytes));

            for (var item in body) {
              seguros.add(Seguro(
                numeroPoliza: item["numeroPoliza"].toString(),
                ramo: item["ramo"],
                fechaInicio: item["fechaInicio"],
                fechaVencimiento: item["fechaVencimiento"],
                condicionesParticulares: item["condicionesParticulares"],
                observaciones: item["obervaciones"],
                dniCliente: item["dniCl"].toString(),
              ));
            }
            SeguroRepository.shared.delete(tableName: "seguros");

            SeguroRepository.shared.save(data: seguros, tableName: "seguros");

            contador = contador + 1;
          }
        }
        List<dynamic> segList =
            await SeguroRepository.shared.selectAll(tableName: 'seguros');

        for (var item in segList) {
          segurosDb.add(Seguro(
            numeroPoliza: item['numeropoliza'].toString(),
            ramo: item['ramo'],
            fechaInicio: item['fechainicio'],
            fechaVencimiento: item['fechavencimiento'],
            condicionesParticulares: item['condicionesparticulares'],
            observaciones: item['observaciones'],
          ));
        }

        return SegurosLista.fromDb(segurosDb);

      case HttpType.POST:
        if (conectedToNetwork) {
          response = await http.post(
            uri,
            body: jsonParam,
            headers: {'Content-type': 'application/json; charset=UTF-8'},
          );
          agregarUbicacion("POST");
        } else {
          SeguroRepository.shared
              .insertSeguro(tableName: "seguros", seguro: seguro!);
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
          SeguroRepository.shared
              .updateSeguro(tableName: "seguros", seguro: seguro!);
        }
        break;
      case HttpType.DELETE:
        if (conectedToNetwork) {
          response = await http.delete(uri);

          agregarUbicacion("DELETE");
        } else {
          SeguroRepository.shared.eliminarSeguro(
              tableName: "seguros", id: int.parse(seguro!.numeroPoliza!));
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
                "Peticion ${tipoPeticion} de SEGUROS a la API _ FECHA: ${DateTime.now()}"
          })
          .then((value) => print(
              "UBICACION ENVIADA ${tipoPeticion} API MANAGER SEGURO ${DateTime.now()} ES: ${_initialPosition}"))
          .catchError((error) =>
              print("ENVIO DE UBICACION A FIRESTORE FALLIDA: $error"));
    }

    addUbicacion();
  }
}
