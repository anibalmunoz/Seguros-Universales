import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:arquitectura_universales/blocs/cliente_bloc/cliente_bloc.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.dart';
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
          style: TextStyle(height: 4),
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
                                    return 'Campo vacío';
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
                                    return 'Campo vacío';
                                  }
                                  client.nombrecl = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.nombrecl,
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
                                  client.apellido1 = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.apellido1,
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
                                  client.clasevia = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.clasevia,
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
                                  client.nombrevia = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                initialValue: client.nombrevia,
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
                                  client.numerovia = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                initialValue: client.numerovia,
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
                                  client.codpostal = valor;
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                initialValue: client.codpostal,
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
                                keyboardType: TextInputType.number,
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
                                  child: const Text(
                                      '               Modificar Cliente               '),
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
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Modificar"),
              content: Text("¿Estas seguro de modificar el cliente " +
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
                    child: const Text("Cancelar",
                        style: TextStyle(
                          color: Colors.blue,
                        ))),
                BlocProvider(
                  create: (context) => ClienteBloc(),
                  child: BlocListener<ClienteBloc, ClienteState>(
                    listener: (context, state) {
                      switch (state.runtimeType) {
                        case GuardandoCliente:
//                          mostrarCarga(context);
                          break;
                        case ClienteGuardado:
                          //                        mostrarCarga(context);
                          break;
                      }
                    },
                    child: BlocBuilder<ClienteBloc, ClienteState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () async {
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

                              final response = ApiManagerCliente.shared.request(
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
}
