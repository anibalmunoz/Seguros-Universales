import 'dart:convert';

import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/repository/cliente_repository.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiManagerCliente {
  ApiManagerCliente._privateConstructor();
  static final ApiManagerCliente shared =
      ApiManagerCliente._privateConstructor();

  var contador = 0;

  Future<ClientesLista?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    String? jsonParam,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
    Cliente? cliente,
  }) async {
    List<Cliente> clientesDb = [];
    final key = {};
    final uri = Uri.http(baseUrl, pathUrl);

    late http.Response response;
    switch (type) {
      case HttpType.GET:
        response = await http.get(uri);
        List<Cliente> clientes = [];

        if (response.statusCode == 200 &&
            response.body != null &&
            contador == 0) {
          final body = json.decode(response.body);

          for (var item in body) {
            clientes.add(Cliente(
              dnicl: item["dniCl"],
              nombrecl: item["nombreCl"],
              apellido1: item["apellido1"],
              apellido2: item["apellido2"],
              clasevia: item["claseVia"],
              nombrevia: item["nombreVia"],
              numerovia: item["numeroVia"],
              codpostal: item["codPostal"],
              ciudad: item["ciudad"],
              telefono: item["telefono"].toString(),
              observaciones: item["observaciones"],
            ));
          }

//MODIFICACIONES PARA BASE DE DATOS LOCAL

          //return ClientesLista.lista(clientes);

          ClienteRepository.shared.delete(tableName: "clienteprueba");

          ClienteRepository.shared
              .save(data: clientes, tableName: "clienteprueba");

          contador = contador + 1;
//          return ClientesLista.fromDb(clientesDb);

//FIN MODIFICACIONES PARA BASES DE DATOS LOCAL

        }
        List<dynamic> clientList = await ClienteRepository.shared
            .selectAll(tableName: 'clienteprueba');

        for (var item in clientList) {
          clientesDb.add(Cliente(
            dnicl: item["dnicl"],
            nombrecl: item["nombrecl"],
            apellido1: item["apellido1"],
            apellido2: item["apellido2"],
            clasevia: item["clasevia"],
            nombrevia: item["nombrevia"],
            numerovia: item["numerovia"],
            codpostal: item["codpostal"],
            ciudad: item["ciudad"],
            telefono: item["telefono"].toString(),
            observaciones: item["observaciones"],
          ));
        }
        print(
            "LA LISTA DE CLIENTES QUE VIENE DE LA BASE DE DATOS ES: ${clientList}");
        return ClientesLista.fromDb(clientesDb);

      //agregarUbicacion("GET");

      case HttpType.POST:
        // response = await http.post(
        //   uri,
        //   body: jsonParam,
        //   headers: {'Content-type': 'application/json; charset=UTF-8'},
        // );
        // print("EL CODIGO DE RESPUESTA ES:  ${response.statusCode}");

        //agregarUbicacion("POST");

//GUARDADO UNICAMENTE EN BASE DE DATOS

        ClienteRepository.shared
            .insertCliente(tableName: "clienteprueba", cliente: cliente!);

//FIN DE GUARDADO UNICAMENTE EN BASE DE DATOS
        break;
      case HttpType.PUT:
        // response = await http.post(
        //   uri,
        //   body: jsonParam,
        //   headers: {'Content-type': 'application/json; charset=UTF-8'},
        // );
        // print("EL CODIGO DE RESPUESTA ES:  ${response.statusCode}");

        //agregarUbicacion("POST");

//GUARDADO UNICAMENTE EN BASE DE DATOS

        ClienteRepository.shared
            .updateCliente(tableName: "clienteprueba", cliente: cliente!);

//FIN DE GUARDAD UNICAMENTE EN BASE DE DATOS
        break;
      case HttpType.DELETE:
        //response = await http.delete(uri);

        //agregarUbicacion("DELETE");

        ClienteRepository.shared
            .eliminarCliente(tableName: "clienteprueba", id: cliente!.dnicl!);
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
