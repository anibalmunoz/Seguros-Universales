import 'dart:convert';

import 'package:arquitectura_universales/model/seguro-model.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiManagerSeguro {
  ApiManagerSeguro._privateConstructor();
  static final ApiManagerSeguro shared = ApiManagerSeguro._privateConstructor();

  Future<SegurosLista?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
  }) async {
    final key = {};
    final uri = Uri.http(baseUrl, pathUrl);

    late http.Response response;
    switch (type) {
      case HttpType.GET:
        response = await http.get(uri);
        agregarUbicacion("GET");
        break;
      case HttpType.POST:
        response = await http.get(uri);
        break;
      case HttpType.DELETE:
        response = await http.get(uri);
    }
    // final request = await http.post(uri, body: bodyParams);

    List<Seguro> seguros = [];

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

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

      return SegurosLista.lista(seguros);
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
