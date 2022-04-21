import 'dart:convert';

import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/seguro-model.dart';
import 'package:arquitectura_universales/providers/api_manager_seguro.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';
import 'package:arquitectura_universales/util/extension.dart';

class DetallesSeguro extends StatefulWidget {
  Seguro seguro;
  String titulo;

  DetallesSeguro({key, required this.seguro, required this.titulo});

  @override
  State<StatefulWidget> createState() => _RegistrarSeguro();
}

class _RegistrarSeguro extends State<DetallesSeguro> {
  final _keyForm = GlobalKey<FormState>();
  final baseURL = const MyApp().baseURL;
  final pathURL = "/seguro/guardar";

  final estiloBotonGuardar = ElevatedButton.styleFrom(
    primary: Colors.green,
    onPrimary: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  @override
  Widget build(BuildContext context) {
    Seguro seg = widget.seguro;

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
                                initialValue: seg.numeroPoliza.toString(),
                                //readOnly: true,
                                enabled: false,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.numbers),
                                    labelText: "Número Poliza",
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
                                  seg.ramo = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: seg.ramo,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.text_fields_rounded),
                                    labelText: "Ramo",
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
                                  seg.fechaInicio = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.datetime,
                                initialValue: seg.fechaInicio,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.date_range),
                                  labelText: "Fecha Inicio",
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
                                  seg.fechaVencimiento = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.datetime,
                                initialValue: seg.fechaVencimiento,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.date_range),
                                  labelText: "Fecha Vencimiento",
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
                                  seg.condicionesParticulares = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: seg.condicionesParticulares,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.read_more_outlined),
                                  labelText: "Condiciones Particulares",
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
                                  seg.observaciones = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: seg.observaciones,
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
                                      modificarSeguro(context, seg);
                                    }
                                  },
                                  child: const Text(
                                      '               Modificar Seguro               '),
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

  modificarSeguro(context, seguro) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Modificar"),
              content: Text("¿Estas seguro de modificar el seguro " +
                  seguro.numeroPoliza +
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
                      Seguro seguroEnviar = seguro;
                      Map<String, dynamic> bodyMap;
                      bodyMap = {
                        "numeroPoliza": seguro.numeroPoliza,
                        "ramo": seguro.ramo,
                        "fechaInicio": seguro.fechaInicio,
                        "fechaVencimiento": seguro.fechaVencimiento,
                        "condicionesParticulares":
                            seguro.condicionesParticulares,
                        "obervaciones": seguro.observaciones,
                      };

                      var jsonMap = json.encode(bodyMap);

                      print("EL SEGURO QUE ESTOY MANDANDO ES:  ${jsonMap}");

                      ApiManagerSeguro.shared.request(
                          baseUrl: baseURL,
                          pathUrl: pathURL,
                          jsonParam: jsonMap,
                          bodyParams: bodyMap,
                          type: HttpType.PUT,
                          seguro: seguro);

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
