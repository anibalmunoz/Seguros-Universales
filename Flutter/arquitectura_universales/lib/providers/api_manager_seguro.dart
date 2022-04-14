import 'dart:convert';

import 'package:arquitectura_universales/model/seguro-model.dart';
import 'package:arquitectura_universales/util/app_type.dart';
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
}
