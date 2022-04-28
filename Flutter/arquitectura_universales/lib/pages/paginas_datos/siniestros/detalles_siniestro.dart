import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:arquitectura_universales/blocs/siniestro_bloc/siniestro_bloc.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/siniestro_model.dart';
import 'package:arquitectura_universales/providers/api_manager_siniestro.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  bool guardando = false;

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
      body: guardando == true
          ? Center(
              child: Container(
              width: 30.0,
              height: 30.0,
              child: const CircularProgressIndicator(),
            ))
          : ListView(
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
                                      initialValue:
                                          sinister.idSiniestro.toString(),
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
                                          if (_keyForm.currentState!
                                              .validate()) {
                                            modificarSiniestro(
                                                    context, sinister)
                                                .then((value) {
                                              if (value) {
                                                mostrarCarga(context);
                                                Navigator.pop(context);
                                              }
                                            });

                                            // if (guardado) {
                                            //   Navigator.pop(context);
                                            // }
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

  Future<bool> modificarSiniestro(context, siniestro) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Modificar"),
              content: Text("¿Estas seguro de modificar el siniestro " +
                  siniestro.idSiniestro +
                  "?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("Cancelar",
                        style: TextStyle(
                          color: Colors.blue,
                        ))),
                BlocProvider(
                  create: (context) => SiniestroBloc(),
                  child: BlocListener<SiniestroBloc, SiniestroState>(
                    listener: (context, state) {
                      switch (state.runtimeType) {
                        case GuardandoSiniestroState:
                          //mostrarCarga();
                          break;
                        case SiniestroGuardadoState:
                          //mostrarCarga();
                          break;
                      }
                    },
                    child: BlocBuilder<SiniestroBloc, SiniestroState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () {
                              if (MyApp.conectedToNetwork) {
                                Map<String, dynamic> bodyMap;
                                bodyMap = {
                                  "idSiniestro": siniestro.idSiniestro,
                                  "fechaSiniestro": siniestro.fechaSiniestro,
                                  "causas": siniestro.causas,
                                  "aceptado": siniestro.aceptado,
                                  "indemnizacion": siniestro.indemnizacion,
                                };

                                var jsonMap = json.encode(bodyMap);

                                print(
                                    "EL SINIESTRO QUE ESTOY MANDANDO ES:  ${jsonMap}");

                                ApiManagerSiniestro.shared.request(
                                    baseUrl: baseURL,
                                    pathUrl: pathURL,
                                    jsonParam: jsonMap,
                                    bodyParams: bodyMap,
                                    type: HttpType.PUT,
                                    siniestro: siniestro);
                                BlocProvider.of<SiniestroBloc>(context)
                                    .add(ModificarSiniestroEvent());

                                Navigator.pop(context, true);
                              } else {
                                mostrarFlushbar(context);
                              }
                            },
                            child: const Text(
                              "Confirmar",
                              style: TextStyle(color: Colors.green),
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ));
  }

  mostrarCarga(context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return const Dialog(
            child: LinearProgressIndicator(),
          );
        });
  }

  mostrarFlushbar(context) async {
    if (!MyApp.conectedToNetwork) {
      Flushbar(
        title: "Sin conexión a internet",
        message: "No puedes editar el cliente",
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
    }
  }
}
