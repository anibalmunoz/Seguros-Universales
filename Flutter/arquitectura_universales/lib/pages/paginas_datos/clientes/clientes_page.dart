import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:arquitectura_universales/blocs/basic_bloc/basic_bloc.dart';
import 'package:arquitectura_universales/blocs/cliente_bloc/cliente_bloc.dart';
import 'package:arquitectura_universales/localizations/localization.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/creacion_cliente.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/detalles_cliente.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.login.dart';
import 'package:arquitectura_universales/util/app_string.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientesPage extends StatelessWidget {
  ClientesPage({Key? key}) : super(key: key);
  // final baseURL = "jsonplaceholder.typicode.com";
  // final pathURL = "/users/1";
  final baseURL = MyApp().baseURL;
  final pathURL = "/cliente/buscar";
  List _clientes = [];
  late ClienteBloc clienteBloc;
  final _scaffKey = GlobalKey<ScaffoldState>();
  static bool conectedToNetwork = false;

  @override
  Widget build(BuildContext context) {
    BasicBloc basicBloc;
    basicBloc = BlocProvider.of<BasicBloc>(context);

    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return BlocProvider(
      create: (context) => ClienteBloc(),
      child: SafeArea(
        child: Scaffold(
          key: _scaffKey,
          appBar: conectedToNetwork
              ? AppBar(
                  backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                      ? Colors.blue[900]
                      : Colors.grey[900],
                  bottom: const PreferredSize(
                    preferredSize: Size(12, 12),
                    child: Text(""),
                  ),
                  title: Text(
                    localizations.dictionary(Strings.tituloClientesPage),
                    style: const TextStyle(height: 4),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(top: 37.0),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: BlocProvider(
                        create: (context) => ClienteBloc(),
                        child: BlocListener<ClienteBloc, ClienteState>(
                          listener: (context, state) {
                            switch (state.runtimeType) {
                              case IrACreacionState:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (cxt) => CreacionCliente(
                                            titulo: localizations.dictionary(Strings
                                                .tituloCrearNuevoClientePage))));
                                break;
                            }
                          },
                          child: BlocBuilder<ClienteBloc, ClienteState>(
                            builder: (context, state) {
                              return IconButton(
                                  icon: const Icon(Icons.person_add_alt_sharp,
                                      color: Colors.amber),
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => CreacionCliente(
                                    //           titulo: "Crear nuevo cliente"),
                                    //     )).then((value) => null);

                                    BlocProvider.of<ClienteBloc>(context)
                                        .add(CreacionClienteEvent());

                                    BlocProvider.of<ClienteBloc>(context)
                                        .add(ReturnListaPressed());
                                  });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 37.0),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: IconButton(
                          icon: const Icon(Icons.dangerous_outlined,
                              color: Colors.amber),
                          onPressed: () async {
                            //ClienteRepository.shared.modificarTablaCliente();
                            //snack();
                            Map<String, dynamic> bodyMap;
                            bodyMap = {
                              "correo": "asdf",
                              "contrasena": "asfd",
                            };
                            var jsonMap = json.encode(bodyMap);
                            final response = await ApiManagerClienteLogin.shared
                                .request(
                                    baseUrl: baseURL,
                                    pathUrl: "cliente/login",
                                    jsonParam: jsonMap,
                                    type: HttpType.POST);

                            if (response?.statusCode == 403) {
                              basicBloc.add(Error403());
                            }
                            print(
                                "EL CODIGO DE ERROR DEVUELTO ES: ${response?.statusCode}");
                          }),
                    ),
                  ],
                )
              : AppBar(
                  backgroundColor: Colors.red[900],
                  bottom: PreferredSize(
                    preferredSize: const Size(0, 0),
                    child: Text(
                      localizations.dictionary(Strings.appbarSinConexion),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: const Text(
                    "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 4,
                    ),
                  ),
                ),
          body: FutureBuilder(
            future: ApiManagerCliente.shared.request(
                baseUrl: baseURL, pathUrl: pathURL, type: HttpType.GET),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                final ClientesLista clientesLista =
                    snapshot.requireData as ClientesLista;
                _clientes = clientesLista.clientes;
                // print("SI HAY INFORMACIÓN");
              } else {
                // print("NO HAY INFORMACIÓN");
              }

              return ListView.builder(
                itemCount: _clientes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      eliminarCliente(context, _clientes[index]);
                    },
                    title: Text(
                        localizations.dictionary(Strings.listaClienteNombre) +
                            _clientes[index].nombrecl +
                            " " +
                            _clientes[index].apellido1),
                    subtitle: Text("DNI: " + _clientes[index].dnicl.toString()),
                    leading: const CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Icon(
                          Icons.photo_camera_front_outlined,
                        )
                        //Text(_clientes[index].nombre.substring(0, 1)),
                        ),
                    trailing: BlocProvider(
                      create: (context) => ClienteBloc(),
                      child: BlocListener<ClienteBloc, ClienteState>(
                        listener: (context, state) {
                          switch (state.runtimeType) {
                            case IrADetallesPageState:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (cxt) => DetallesCliente(
                                          cliente: _clientes[index],
                                          titulo: localizations.dictionary(
                                              Strings
                                                  .tituloDetallesClientes))));
                              break;
                          }
                        },
                        child: BlocBuilder<ClienteBloc, ClienteState>(
                          builder: (context, state) {
                            return IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 41, 106, 202),
                                ),
                                onPressed: () async {
                                  await mostrarFlushbar(context);
                                  BlocProvider.of<ClienteBloc>(context)
                                      .add(DetallesButtonPressed());

                                  BlocProvider.of<ClienteBloc>(context)
                                      .add(ReturnListaPressed());
                                });
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  eliminarCliente(context, cliente) {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(localizations.dictionary(Strings.eliminar)),
              content: Text(
                  localizations.dictionary(Strings.consultaEliminarCliente) +
                      cliente.nombrecl +
                      "?"),
              actions: [
                TextButton(
                  child: Text(localizations.dictionary(Strings.botonCancelar),
                      style: const TextStyle(
                        color: Colors.blue,
                      )),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                BlocProvider(
                  create: (context) => ClienteBloc(),
                  child: BlocListener<ClienteBloc, ClienteState>(
                    listener: (context, state) {
                      switch (state.runtimeType) {
                        case EliminandoClienteState:
                          break;

                        case ClienteEliminadoState:
                          Navigator.pop(context);
                          Flushbar(
                            title: localizations.dictionary(Strings.eliminado),
                            message: localizations
                                .dictionary(Strings.clienteEliminado),
                            duration: const Duration(seconds: 2),
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 55.0, left: 8, right: 8),
                            borderRadius: BorderRadius.circular(8),
                          ).show(context);
                          break;
                      }
                    },
                    child: BlocBuilder<ClienteBloc, ClienteState>(
                      builder: (context, state) {
                        return TextButton(
                          child: Text(
                            localizations.dictionary(Strings.eliminar),
                            style: const TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            if (MyApp.conectedToNetwork) {
                              final response = ApiManagerCliente.shared.request(
                                  baseUrl: const MyApp().baseURL,
                                  pathUrl: "/cliente/eliminar/" +
                                      cliente.dnicl.toString(),
                                  type: HttpType.DELETE,
                                  cliente: cliente);

                              if (response != null) {
                                BlocProvider.of<ClienteBloc>(context)
                                    .add(ClienteEliminadoEvent());
                              }
                            } else {
                              mostrarFlushbar(context);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ));
  }

  mostrarFlushbar(context) async {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    if (!MyApp.conectedToNetwork) {
      Flushbar(
        title: localizations.dictionary(Strings.flushbarSinconexion),
        message: localizations.dictionary(Strings.noPuedeEliminar),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
    }
  }
}
