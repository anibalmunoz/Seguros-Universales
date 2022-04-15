import 'dart:convert';

import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';
import 'package:arquitectura_universales/util/extension.dart';

class DetallesCliente extends StatefulWidget {
  Cliente cliente;
  String titulo;

  DetallesCliente({key, required this.cliente, required this.titulo});

  @override
  State<StatefulWidget> createState() => _RegistrarContacto();
}

class _RegistrarContacto extends State<DetallesCliente> {
  final _keyForm = GlobalKey<FormState>();
  final baseURL = "192.168.0.17:9595";
  final pathURL = "/cliente/guardar";

  final estiloBotonGuardar = ElevatedButton.styleFrom(
    primary: Colors.green,
    onPrimary: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  final estiloBotonEliminar = ElevatedButton.styleFrom(
    primary: Colors.red,
    onPrimary: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  @override
  Widget build(BuildContext context) {
    Cliente client = widget.cliente;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
            ? Colors.red
            : Colors.blue,
        bottom: const PreferredSize(
          preferredSize: Size(12, 12),
          child: Text(""),
        ),
        title: Text(
          widget.titulo,
          style: TextStyle(height: 4),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 37.0),
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: SafeArea(
                child: SingleChildScrollView(
              child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: _keyForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.assignment_ind_outlined,
                          color: Colors.amber,
                          size: 150.0,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return 'Campo vacío';
                                  }
                                },
                                keyboardType: TextInputType.number,
                                initialValue: client.dni.toString(),
                                //readOnly: true,
                                enabled: false,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.numbers),
                                    labelText: "DNI",
                                    border: OutlineInputBorder(),
                                    isDense: false,
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return 'Campo vacío';
                                  }
                                  client.nombre = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.nombre,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.text_fields_rounded),
                                    labelText: "Nombre",
                                    border: OutlineInputBorder(),
                                    isDense: false,
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return "Campo vacío";
                                  }
                                  client.apeliido1 = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.apeliido1,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.text_fields_rounded),
                                  labelText: "Primer Apellido",
                                  //helperText: "Aa@45678",
                                  border: OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return "Campo vacío";
                                  }
                                  client.apellido2 = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.apellido2,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.text_fields_rounded),
                                  labelText: "Segundo Apellido",
                                  border: OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return "Campo vacío";
                                  }
                                  client.claseVia = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.claseVia,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.read_more_outlined),
                                  labelText: "Clase Vía",
                                  border: OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return "Campo vacío";
                                  }
                                  client.nombre = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.nombreVia,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.read_more_outlined),
                                  labelText: "Nombre Vía",
                                  border: OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return "Campo vacío";
                                  }
                                  client.numeroVia = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                initialValue: client.numeroVia,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.read_more_outlined),
                                  labelText: "Número Vía",
                                  border: OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return "Campo vacío";
                                  }
                                  client.codigoPostal = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                initialValue: client.codigoPostal,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.directions),
                                  labelText: "Código Postal",
                                  border: OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return "Campo vacío";
                                  }
                                  client.ciudad = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.ciudad,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.location_city),
                                  labelText: "Ciudad",
                                  border: OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return "Campo vacío";
                                  }
                                  client.telefono = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                initialValue: client.telefono,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.phone),
                                  labelText: "Teléfono",
                                  border: OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return "Campo vacío";
                                  }
                                  client.observaciones = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.observaciones,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.folder),
                                  labelText: "Observaciones",
                                  border: OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: estiloBotonGuardar,
                                  onPressed: () {
                                    if (_keyForm.currentState!.validate()) {
                                      modificarCliente(context, client);
                                    }
                                  },
                                  child: const Text(
                                      '               Guardar Cliente               '),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            )),
          ),
          // Row(
          //   children: [],
          // )
        ],
      ),
    );
  }

  modificarCliente(context, cliente) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Modificar"),
              content: Text("¿Estas seguro de modificar el cliente " +
                  cliente.nombre +
                  "?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar",
                        style: TextStyle(
                          color: Colors.blue,
                        ))),
                TextButton(
                    onPressed: () {
                      Cliente clienteEnviar = cliente;
                      Map<String, dynamic> bodyMap;
                      bodyMap = {
                        "dniCl": cliente.dni,
                        "nombreCl": cliente.nombre,
                        "apellido1": cliente.apeliido1,
                        "apellido2": cliente.apellido2,
                        "claseVia": cliente.claseVia,
                        "nombreVia": cliente.nombreVia,
                        "numeroVia": cliente.numeroVia,
                        "codPostal": cliente.codigoPostal,
                        "ciudad": cliente.ciudad,
                        "telefono": (cliente.telefono),
                        "observaciones": cliente.observaciones
                      };

                      var jsonMap = json.encode(bodyMap);

                      print("EL CLIENTE QUE ESTOY MANDANDO ES:  ${jsonMap}");

                      ApiManagerCliente.shared.request(
                          baseUrl: baseURL,
                          pathUrl: pathURL,
                          jsonParam: jsonMap,
                          bodyParams: bodyMap,
                          type: HttpType.POST);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Confirmar",
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ));
  }
}
