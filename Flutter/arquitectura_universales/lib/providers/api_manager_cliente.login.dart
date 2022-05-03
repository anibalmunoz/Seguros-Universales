import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/repository/cliente_repository.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:http/http.dart' as http;

class ApiManagerClienteLogin {
  ApiManagerClienteLogin._privateConstructor();
  static final ApiManagerClienteLogin shared =
      ApiManagerClienteLogin._privateConstructor();

  Future<http.Response?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    String? jsonParam,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
    String? correo,
    String? contrasena,
  }) async {
    final uri = Uri.http(baseUrl, pathUrl);

    late http.Response response;

    switch (type) {
      case HttpType.GET:
        List<Cliente> loginList = await ClienteRepository.shared
            .buscarClienteLoguin(
                tableName: "clienteprueba",
                correo: correo!,
                contrasena: contrasena!);

        if (loginList.length == 1) {
          response = http.Response("", 200);
          return response;
        } else {
          response = http.Response("", 403);
          return response;
        }

      case HttpType.POST:
        response = await http.post(
          uri,
          body: jsonParam,
          headers: {'Content-type': 'application/json; charset=UTF-8'},
        );
        if (response.statusCode == 200 && response.body != null) {
          //final body = json.decode(response.body);
          //Cliente.fromObjeto(body);
          return response;
        }
        return response;

      case HttpType.DELETE:
    }
    // final request = await http.post(uri, body: bodyParams);

    return null;
  }
}
