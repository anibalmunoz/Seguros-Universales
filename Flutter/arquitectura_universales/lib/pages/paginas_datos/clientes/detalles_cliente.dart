import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:arquitectura_universales/blocs/cliente_bloc/cliente_bloc.dart';
import 'package:arquitectura_universales/localizations/localization.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.dart';
import 'package:arquitectura_universales/util/app_string.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';
import 'package:arquitectura_universales/util/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetallesCliente extends StatefulWidget {
  Cliente cliente;
  String titulo;

  DetallesCliente({key, required this.cliente, required this.titulo});

  @override
  State<StatefulWidget> createState() => _RegistrarContacto();
}

class _RegistrarContacto extends State<DetallesCliente> {
  final _keyForm = GlobalKey<FormState>();
  final baseURL = const MyApp().baseURL;
  final pathURL = "/cliente/guardar";
  bool guardando = false;
  bool guardado = false;

  // final clienteBloc = BlocBuilder<ClienteBloc, ClienteState>(
  //                         builder: (context, state);

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

    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

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
          margin: const EdgeInsets.only(top: 22.0),
          child: BlocProvider(
            create: (context) => ClienteBloc(),
            child: BlocListener<ClienteBloc, ClienteState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case ClienteInitial:
                    Navigator.pop(context);
                    break;
                }
              },
              child: BlocBuilder<ClienteBloc, ClienteState>(
                builder: (context, state) {
                  return IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        //Navigator.pop(context);
                        BlocProvider.of<ClienteBloc>(context)
                            .add(ReturnListaPressed());
                      });
                },
              ),
            ),
          ),
        ),

        title: Text(
          widget.titulo,
          style: const TextStyle(height: 4),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 37.0),
          ),
        ],
      ),
      // body: guardando == true
      //     ? Center(
      //         child: Container(
      //         width: 30.0,
      //         height: 30.0,
      //         child: const CircularProgressIndicator(),
      //       ))
      //     :
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
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                },
                                keyboardType: TextInputType.number,
                                initialValue: client.dnicl.toString(),
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
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.nombrecl = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.nombrecl,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.text_fields_rounded),
                                    labelText: localizations
                                        .dictionary(Strings.nombre),
                                    border: const OutlineInputBorder(),
                                    isDense: false,
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.apellido1 = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.apellido1,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.text_fields_rounded),
                                  labelText: localizations
                                      .dictionary(Strings.primerApellido),
                                  //helperText: "Aa@45678",
                                  border: const OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.apellido2 = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.apellido2,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.text_fields_rounded),
                                  labelText: localizations
                                      .dictionary(Strings.segundoApellido),
                                  border: const OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.clasevia = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.clasevia,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.read_more_outlined),
                                  labelText: localizations
                                      .dictionary(Strings.claseVia),
                                  border: const OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.nombrevia = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.nombrevia,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.read_more_outlined),
                                  labelText: localizations
                                      .dictionary(Strings.nombreVia),
                                  border: const OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.numerovia = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                initialValue: client.numerovia,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.read_more_outlined),
                                  labelText: localizations
                                      .dictionary(Strings.numeroVia),
                                  border: const OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.codpostal = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                initialValue: client.codpostal,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.directions),
                                  labelText: localizations
                                      .dictionary(Strings.codigoPostal),
                                  border: const OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.ciudad = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.ciudad,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.location_city),
                                  labelText:
                                      localizations.dictionary(Strings.ciudad),
                                  border: const OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.telefono = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                initialValue: client.telefono,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.phone),
                                  labelText: localizations
                                      .dictionary(Strings.telefono),
                                  border: const OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                              ),
                              TextFormField(
                                validator: (valor) {
                                  if (valor!.isEmpty) {
                                    return localizations
                                        .dictionary(Strings.campoVacio);
                                  }
                                  client.observaciones = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.observaciones,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.folder),
                                  labelText: localizations
                                      .dictionary(Strings.observaciones),
                                  border: const OutlineInputBorder(),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: estiloBotonGuardar,
                                  onPressed: () async {
                                    if (_keyForm.currentState!.validate()) {
                                      await modificarCliente(context, client)
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
                                  child: Text(localizations.dictionary(
                                      Strings.botonModificarCliente)),
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

  Future<bool> modificarCliente(context, cliente) async {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(localizations.dictionary(Strings.modifcar)),
              content: Text(
                  localizations.dictionary(Strings.consultaModificarcliente) +
                      cliente.nombrecl +
                      "?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                      // Navigator.of(context)
                      //   ..pop()
                      //   ..pop();
                    },
                    child: Text(localizations.dictionary(Strings.botonCancelar),
                        style: const TextStyle(
                          color: Colors.blue,
                        ))),
                BlocProvider(
                  create: (context) => ClienteBloc(),
                  child: BlocListener<ClienteBloc, ClienteState>(
                    listener: (context, state) {
                      switch (state.runtimeType) {
                        case GuardandoCliente:
                          break;
                        case ClienteGuardado:
                          break;
                      }
                    },
                    child: BlocBuilder<ClienteBloc, ClienteState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () async {
                              if (MyApp.conectedToNetwork) {
                                Map<String, dynamic> bodyMap;
                                bodyMap = {
                                  "dniCl": cliente.dnicl,
                                  "nombreCl": cliente.nombrecl,
                                  "apellido1": cliente.apellido1,
                                  "apellido2": cliente.apellido2,
                                  "claseVia": cliente.clasevia,
                                  "nombreVia": cliente.nombrevia,
                                  "numeroVia": cliente.numerovia,
                                  "codPostal": cliente.codpostal,
                                  "ciudad": cliente.ciudad,
                                  "telefono": (cliente.telefono),
                                  "observaciones": cliente.observaciones
                                };

                                var jsonMap = json.encode(bodyMap);

                                final response = ApiManagerCliente.shared
                                    .request(
                                        baseUrl: baseURL,
                                        pathUrl: pathURL,
                                        jsonParam: jsonMap,
                                        bodyParams: bodyMap,
                                        type: HttpType.PUT,
                                        cliente: cliente);

                                BlocProvider.of<ClienteBloc>(context)
                                    .add(ModificarCliente(cliente: cliente));

                                Navigator.pop(context, true);
                                //await mostrarCarga(context);
                                // int count = 0;
                                // Navigator.of(context)
                                //     .popUntil((_) => count++ >= 2);
                              } else {
                                mostrarFlushbar(context);
                              }
                            },
                            child: Text(
                              localizations.dictionary(Strings.botonConfirmar),
                              style: const TextStyle(color: Colors.green),
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ));
  }

  mostrarCarga(context) async {
    // setState(() {
    //   guardando = true;
    // });
    // await Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {
    //     guardando = false;
    //   });
    // });

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
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    if (!MyApp.conectedToNetwork) {
      Flushbar(
        title: localizations.dictionary(Strings.flushbarSinconexion),
        message: localizations.dictionary(Strings.noPuedeEditar),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
    }
  }
}
