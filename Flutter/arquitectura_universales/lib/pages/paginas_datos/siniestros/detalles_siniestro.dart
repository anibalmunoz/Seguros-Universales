import 'dart:convert';

import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/siniestro_model.dart';
import 'package:arquitectura_universales/providers/api_manager_siniestro.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';

class DetallesSiniestro extends StatefulWidget {
  Siniestro siniestro;
  String titulo;

  DetallesSiniestro({key, required this.siniestro, required this.titulo});

  @override
  State<StatefulWidget> createState() => _RegistrarSiniestro();
}

class _RegistrarSiniestro extends State<DetallesSiniestro> {
  final _keyForm = GlobalKey<FormState>();
  final baseURL = const MyApp().baseURL;
  final pathURL = "/siniestro/guardar";

  final estiloBotonGuardar = ElevatedButton.styleFrom(
    primary: Colors.green,
    onPrimary: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  @override
  Widget build(BuildContext context) {
    Siniestro sinister = widget.siniestro;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
            ? Colors.blue[900]
            : Colors.grey[900],
        bottom: const PreferredSize(
          preferredSize: Size(12, 12),
          child: Text(""),
        ),
        //automaticallyImplyLeading: true,
        leading: Container(
          margin: EdgeInsets.only(top: 22.0),
          child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
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
                                initialValue: sinister.idSiniestro.toString(),
                                //readOnly: true,
                                enabled: false,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.numbers),
                                    labelText: "ID siniestro",
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
                                  sinister.fechaSiniestro = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.datetime,
                                initialValue: sinister.fechaSiniestro,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.date_range),
                                    labelText: "Fecha del Siniestro",
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
                                  sinister.causas = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: sinister.causas,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.short_text_sharp),
                                  labelText: "Causas",
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
                                  sinister.aceptado = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.datetime,
                                initialValue: sinister.aceptado,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.short_text_sharp),
                                  labelText: "Aceptado",
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
                                  sinister.indemnizacion = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                initialValue: sinister.indemnizacion,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.money_sharp),
                                  labelText: "Indemnización",
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
                                      modificarSiniestro(context, sinister);
                                    }
                                  },
                                  child: const Text(
                                      '               Modificar Siniestro               '),
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

  modificarSiniestro(context, siniestro) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Modificar"),
              content: Text("¿Estas seguro de modificar el siniestro " +
                  siniestro.idSiniestro +
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
                      Map<String, dynamic> bodyMap;
                      bodyMap = {
                        "idSiniestro": siniestro.idSiniestro,
                        "fechaSiniestro": siniestro.fechaSiniestro,
                        "causas": siniestro.causas,
                        "aceptado": siniestro.aceptado,
                        "indemnizacion": siniestro.indemnizacion,
                      };

                      var jsonMap = json.encode(bodyMap);

                      print("EL SINIESTRO QUE ESTOY MANDANDO ES:  ${jsonMap}");

                      ApiManagerSiniestro.shared.request(
                          baseUrl: baseURL,
                          pathUrl: pathURL,
                          jsonParam: jsonMap,
                          bodyParams: bodyMap,
                          type: HttpType.PUT,
                          siniestro: siniestro);

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
