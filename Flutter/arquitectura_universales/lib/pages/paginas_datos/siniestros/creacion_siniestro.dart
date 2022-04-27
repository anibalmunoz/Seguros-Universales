import 'dart:convert';

import 'package:arquitectura_universales/blocs/siniestro_bloc/siniestro_bloc.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/siniestro_model.dart';
import 'package:arquitectura_universales/providers/api_manager_siniestro.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreacionSiniestro extends StatefulWidget {
  String titulo;

  CreacionSiniestro({key, required this.titulo});

  @override
  State<StatefulWidget> createState() => _CreacionSiniestro();
}

class _CreacionSiniestro extends State<CreacionSiniestro> {
  var _currentSelectedDate = DateTime.now();

  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    if (selectedDate != null) {
      setState(() {
        _currentSelectedDate = selectedDate;
      });
      fechaSiniestroController.text =
          DateFormat('dd-MM-yyyy').format(_currentSelectedDate);
    }
  }

  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: _currentSelectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2023),
        builder: (context, child) {
          return Theme(
              data: MyApp.themeNotifier.value == ThemeMode.dark
                  ? ThemeData.dark()
                  : ThemeData.light(),
              child: child!);
        });
  }

  final _keyForm = GlobalKey<FormState>();
  final baseURL = const MyApp().baseURL;
  final pathURL = "/siniestro/guardar";

  var fechaSiniestroController = TextEditingController();
  var fechaInicioController = TextEditingController();
  var fechaVencimientoController = TextEditingController();
  var condicionesParticularesController = TextEditingController();
  var observacionesController = TextEditingController();

  bool guardando = false;

  final estiloBotonGuardar = ElevatedButton.styleFrom(
    primary: Colors.green,
    onPrimary: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  @override
  Widget build(BuildContext context) {
    Siniestro sin = new Siniestro();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
            ? Colors.blue[900]
            : Colors.grey[900],
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
                                Icons.report_problem_outlined,
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
                                      controller: fechaSiniestroController,
                                      validator: (valor) {
                                        if (valor!.isEmpty) {
                                          return 'Campo vacío';
                                        }
                                        //valor = _currentSelectedDate.toString();
                                        sin.fechaSiniestro = valor;
                                        return null;
                                      },
                                      //initialValue: _currentSelectedDate.toString(),

                                      //keyboardType: TextInputType.datetime,
                                      onTap: callDatePicker,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.date_range),
                                          labelText: "Fecha del siniestro",
                                          border: OutlineInputBorder(),
                                          isDense: false,
                                          contentPadding: EdgeInsets.all(10)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 15.0, bottom: 15.0),
                                    ),
                                    TextFormField(
                                      controller: fechaInicioController,
                                      validator: (valor) {
                                        if (valor!.isEmpty) {
                                          return "Campo vacío";
                                        }
                                        sin.causas = valor;
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.short_text_rounded),
                                        labelText: "Causas",
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
                                      controller: fechaVencimientoController,
                                      validator: (valor) {
                                        if (valor!.isEmpty) {
                                          return "Campo vacío";
                                        }
                                        sin.aceptado = valor;
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
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
                                      controller:
                                          condicionesParticularesController,
                                      validator: (valor) {
                                        if (valor!.isEmpty) {
                                          return "Campo vacío";
                                        }
                                        sin.indemnizacion = valor;
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.money),
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
                                            guardarSiniestro(context, sin)
                                                .then((value) {
                                              if (value) {
                                                mostrarCarga(context);
                                                Navigator.pop(context);
                                              }
                                            });
                                          }
                                        },
                                        child: const Text(
                                            '               Guardar Seguro               '),
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

  Future<bool> guardarSiniestro(context, siniestro) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Guardar"),
              content:
                  const Text("¿Estas seguro de guardar el nuevo Siniestro? "),
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
                          //mostrarCarga(context);
                          break;
                        case SiniestroGuardadoState:
                          //mostrarCarga(context);

                          break;
                      }
                    },
                    child: BlocBuilder<SiniestroBloc, SiniestroState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () {
                              Map<String, dynamic> bodyMap;
                              bodyMap = {
                                "fechaSiniestro": siniestro.fechaSiniestro,
                                "causas": siniestro.causas,
                                "aceptado": siniestro.aceptado,
                                "indemnizacion": siniestro.indemnizacion,
                              };

                              var jsonMap = json.encode(bodyMap);

                              print(
                                  "EL CLIENTE QUE ESTOY MANDANDO ES:  ${jsonMap}");

                              ApiManagerSiniestro.shared.request(
                                baseUrl: baseURL,
                                pathUrl: pathURL,
                                jsonParam: jsonMap,
                                bodyParams: bodyMap,
                                type: HttpType.POST,
                                siniestro: siniestro,
                              );

                              fechaSiniestroController.clear();
                              fechaInicioController.clear();
                              fechaVencimientoController.clear();
                              condicionesParticularesController.clear();
                              observacionesController.clear();

                              BlocProvider.of<SiniestroBloc>(context)
                                  .add(ModificarSiniestroEvent());

                              Navigator.pop(context, true);
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
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return const Dialog(
            child: LinearProgressIndicator(),
          );
        });
  }
}
