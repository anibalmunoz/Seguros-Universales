import 'dart:convert';
import 'dart:io';

import 'package:arquitectura_universales/blocs/basic_bloc/basic_bloc.dart';

import 'package:arquitectura_universales/pages/page_one/formulario_login.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.login.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void main() {
  group("Encriptar y desencriptar", () {
    var formularioLogin = FormularioLogin();
    test(
        "Función encriptar: recibe una cadena de caracteres la cual encripta y"
        " retorna la cadena encriptada en base 64", () async {
      expect(
          await formularioLogin
              .encriptar("Cadena de caracteres encriptada en base 64"),
          'Q2FkZW5hIGRlIGNhcmFjdGVyZXMgZW5jcmlwdGFkYSBlbiBiYXNlIDY0');
    });

    test(
        "Función desencriptar: recibe una cadena de caracteres en base 64"
        " la desencripta y retorna la cadena en texto plano", () async {
      expect(
          await FormularioLogin.desencriptar(
              "Q2FkZW5hIGRlIGNhcmFjdGVyZXMgZW5jcmlwdGFkYSBlbiBiYXNlIDY0"),
          'Cadena de caracteres encriptada en base 64');
    });
  });

  test("Buscar en shared Preferences", () async {
    expect(FormularioLogin.asignarDesdeSharedPreferences(), isNotNull);
  });

  group("API LOGIN", () {
    var baseURL = "192.168.0.32:9595";
    var pathURL = "/cliente/login";
    test("Post Login", () async {
      Map<String, dynamic> bodyMap;
      bodyMap = {"correo": "prueba", "contrasena": "prueba"};
      var jsonMap = json.encode(bodyMap);
      var response;
      try {
        response = await ApiManagerClienteLogin.shared.request(
            baseUrl: baseURL,
            pathUrl: pathURL,
            jsonParam: jsonMap,
            type: HttpType.POST);
      } on SocketException catch (e) {
        print(e.message);
      }

      expect(response, isNotNull);
    });

    test("Error, codigo 403", () async {
      Map<String, dynamic> bodyMap;
      bodyMap = {
        "correo": "asdf",
        "contrasena": "asfd",
      };
      var jsonMap = json.encode(bodyMap);
      Response? response;
      try {
        response = await ApiManagerClienteLogin.shared.request(
            baseUrl: baseURL,
            pathUrl: pathURL,
            jsonParam: jsonMap,
            type: HttpType.POST);
      } on SocketException catch (e) {
        print(e.message);
      }

      expect(response!.statusCode == 403, true);
    });

    test("Login correcto, codigo 200", () async {
      Map<String, dynamic> bodyMap;
      bodyMap = {
        "correo": "munozhernandez@gmail.com",
        "contrasena": "@Anibal12345",
      };
      var jsonMap = json.encode(bodyMap);
      Response? response;
      try {
        response = await ApiManagerClienteLogin.shared.request(
            baseUrl: baseURL,
            pathUrl: pathURL,
            jsonParam: jsonMap,
            type: HttpType.POST);
      } on SocketException catch (e) {
        print(e.message);
      }

      expect(response!.statusCode == 200, true);
    });
  });

  group("Basic Bloc", () {
    BasicBloc bloc = BasicBloc();
    test("El estado inicial es deslogueado", () {
      expect(bloc.state.isLogueado, false);
    });

    test("Bloc logueado", () async {
      bloc.add(LogueadoEvent());
      expect(!bloc.state.isLogueado, true);
    });

    test("Bloc deslogueado", () {
      bloc.add(DeslogueadoEvent());
      expect(!bloc.state.isLogueado, false);
    });

    test("Bloc deslogueado por error 403", () {
      bloc.add(Error403());
      expect(bloc.state.isLogueado, false);
    });
  });

  group("API GET", () {
    var baseUrl = "192.168.0.32:9595";

    test("Buscar clientes", () async {
      var pathUrl = "/cliente/buscar";
      final uri = Uri.http(baseUrl, pathUrl);
      late http.Response response;
      try {
        response = await http.get(uri);
      } on SocketException catch (e) {
        print(e.message);
      }

      expect(response.statusCode == 200, true);
    });

    test("Buscar seguros", () async {
      var pathUrl = "/seguro/buscar";
      final uri = Uri.http(baseUrl, pathUrl);
      late http.Response response;
      try {
        response = await http.get(uri);
      } on SocketException catch (e) {
        print(e.message);
      }

      expect(response.statusCode == 200, true);
    });

    test("Buscar siniestros", () async {
      var pathUrl = "/siniestro/buscar";
      final uri = Uri.http(baseUrl, pathUrl);
      late http.Response response;

      try {
        response = await http.get(uri);
      } on SocketException catch (e) {
        print(e.message);
      }

      expect(response.statusCode == 200, true);
    });
  });

  group("Estado inicial en LOGIN: ", () {
    test("Estado inicial de conexión de red", () {
      expect(FormularioLogin.conectedToNetwork, false);
    });

    test(
        "Estado inicial de disponibilidad de lector"
        "biométrico", () {
      expect(FormularioLogin.isBiometricAvailable, false);
    });

    test("Estado inicial de huellas registradas", () {
      expect(FormularioLogin.hayHuellaDisponible, false);
    });
  });
}
