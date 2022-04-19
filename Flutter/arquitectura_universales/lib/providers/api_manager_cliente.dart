import 'dart:convert';

import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiManagerCliente {
  ApiManagerCliente._privateConstructor();
  static final ApiManagerCliente shared =
      ApiManagerCliente._privateConstructor();

  Future<ClientesLista?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    String? jsonParam,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
  }) async {
    final key = {};
    final uri = Uri.http(baseUrl, pathUrl);

    late http.Response response;
    switch (type) {
      case HttpType.GET:
        response = await http.get(uri);
        List<Cliente> clientes = [];

        if (response.statusCode == 200 && response.body != null) {
          final body = json.decode(response.body);

          for (var item in body) {
            clientes.add(Cliente(
              dni: item["dniCl"],
              nombre: item["nombreCl"],
              apeliido1: item["apellido1"],
              apellido2: item["apellido2"],
              claseVia: item["claseVia"],
              nombreVia: item["nombreVia"],
              numeroVia: item["numeroVia"],
              codigoPostal: item["codPostal"],
              ciudad: item["ciudad"],
              telefono: item["telefono"].toString(),
              observaciones: item["observaciones"],
            ));
          }

          return ClientesLista.lista(clientes);
        }
        agregarUbicacion("GET");
        break;
      case HttpType.POST:
        response = await http.post(
          uri,
          body: jsonParam,
          headers: {'Content-type': 'application/json; charset=UTF-8'},
        );
        print("EL CODIGO DE RESPUESTA ES:  ${response.statusCode}");
        agregarUbicacion("POST");
        break;
      case HttpType.DELETE:
        response = await http.delete(uri);

        agregarUbicacion("DELETE");
    }
    // final request = await http.post(uri, body: bodyParams);

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
                "Peticion ${tipoPeticion} de CLIENTES a la API _ FECHA: ${DateTime.now()}"
          })
          .then((value) => print(
              "UBICACION ENVIADA ${tipoPeticion} API MANAGER CLIENTE ${DateTime.now()} ES: ${_initialPosition}"))
          .catchError((error) =>
              print("ENVIO DE UBICACION A FIRESTORE FALLIDA: $error"));
    }

    addUbicacion();
  }
}
