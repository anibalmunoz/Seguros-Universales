import 'dart:convert';

import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/util/app_type.dart';
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
        break;
      case HttpType.POST:
        response = await http.post(
          uri,
          body: jsonParam,
          headers: {'Content-type': 'application/json; charset=UTF-8'},
        );
        print("EL CODIGO DE RESPUESTA ES:  ${response.statusCode}");
        break;
      case HttpType.DELETE:
        response = await http.delete(uri);
    }
    // final request = await http.post(uri, body: bodyParams);

    return null;
  }
}