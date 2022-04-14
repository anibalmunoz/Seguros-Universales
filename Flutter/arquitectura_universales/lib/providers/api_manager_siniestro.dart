import 'dart:convert';

import 'package:arquitectura_universales/model/siniestro_model.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:http/http.dart' as http;

class ApiManagerSiniestro {
  ApiManagerSiniestro._privateConstructor();
  static final ApiManagerSiniestro shared =
      ApiManagerSiniestro._privateConstructor();

  Future<SiniestrosLista?> request({
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

    List<Siniestro> siniestros = [];

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      for (var item in body) {
        siniestros.add(Siniestro(
          idSiniestro: item["idSiniestro"].toString(),
          fechaSiniestro: item["fechaSiniestro"],
          causas: item["causas"],
          aceptado: item["aceptado"],
          indemnizacion: item["indemnizacion"],
          numeroPoliza: item["numeroPoliza"].toString(),
        ));
      }

      return SiniestrosLista.lista(siniestros);
    }
    return null;
  }
}
