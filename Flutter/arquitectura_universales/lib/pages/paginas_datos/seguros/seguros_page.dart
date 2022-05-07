import 'package:another_flushbar/flushbar.dart';
import 'package:arquitectura_universales/blocs/seguro_bloc/seguro_bloc.dart';
import 'package:arquitectura_universales/localizations/localization.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/seguro-model.dart';
import 'package:arquitectura_universales/pages/paginas_datos/seguros/creacion_seguro.dart';
import 'package:arquitectura_universales/pages/paginas_datos/seguros/detalles_seguro.dart';
import 'package:arquitectura_universales/providers/api_manager_seguro.dart';
import 'package:arquitectura_universales/util/app_string.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SegurosPage extends StatelessWidget {
  final baseURL = MyApp().baseURL;
  final pathURL = "/seguro/buscar";
  List _seguros = [];

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return SafeArea(
      child: Scaffold(
        appBar: MyApp.conectedToNetwork
            ? AppBar(
                backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.blue[900]
                    : Colors.grey[900],
                bottom: const PreferredSize(
                  preferredSize: Size(13, 13),
                  child: Text(""),
                ),
                title: Text(
                  localizations.dictionary(Strings.tituloSegurosPage),
                  style: const TextStyle(height: 4),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(top: 33.0),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: BlocProvider(
                      create: (context) => SeguroBloc(),
                      child: BlocListener<SeguroBloc, SeguroState>(
                        listener: (context, state) {
                          switch (state.runtimeType) {
                            case IrACreacionState:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (cxt) => CreacionSeguro(
                                          titulo: localizations.dictionary(Strings
                                              .tituloCrearNuevoSeguroPage))));
                              break;
                          }
                        },
                        child: BlocBuilder<SeguroBloc, SeguroState>(
                          builder: (context, state) {
                            return IconButton(
                                icon: const Icon(Icons.health_and_safety,
                                    color: Colors.amber),
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => CreacionSeguro(
                                  //           titulo: "Crear nuevo seguro"),
                                  //     )).then((value) => null);

                                  BlocProvider.of<SeguroBloc>(context)
                                      .add(CreacionSeguroEvent());

                                  BlocProvider.of<SeguroBloc>(context)
                                      .add(ReturnListaPressedEvent());
                                });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : AppBar(
                backgroundColor: Colors.red[900],
                bottom: PreferredSize(
                  preferredSize: Size(0, 0),
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
          future: ApiManagerSeguro.shared
              .request(baseUrl: baseURL, pathUrl: pathURL, type: HttpType.GET),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final SegurosLista segurosLista =
                  snapshot.requireData as SegurosLista;
              _seguros = segurosLista.seguros;
              // print("SI HAY INFORMACIÓN");
              //print("LA LISTA DE CLIENTES ES: ${_clientes[0]}");
            } else {
              // print("NO HAY INFORMACIÓN");
            }

            // print("Por defecto");
            return ListView.builder(
              itemCount: _seguros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onLongPress: () {
                    eliminarSeguro(context, _seguros[index]);
                  },
                  title: Text(localizations.dictionary(Strings.poliza) +
                      _seguros[index].numeroPoliza +
                      localizations.dictionary(Strings.ramo) +
                      _seguros[index].ramo),

                  subtitle: Text(
                      localizations.dictionary(Strings.fechaVencimiento) +
                          _seguros[index].fechaVencimiento.toString()),
                  // subtitle: Text("Condiciones: " +
                  //     _seguros[index].condicionesParticulares),
                  leading: const CircleAvatar(
                      backgroundColor: Colors.amberAccent,
                      child: Icon(
                        Icons.security,
                      )
                      //Text(_clientes[index].nombre.substring(0, 1)),
                      ),
                  trailing: BlocProvider(
                    create: (context) => SeguroBloc(),
                    child: BlocListener<SeguroBloc, SeguroState>(
                      listener: (context, state) {
                        switch (state.runtimeType) {
                          case IrADetallesPageState:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (cxt) => DetallesSeguro(
                                        seguro: _seguros[index],
                                        titulo: localizations.dictionary(
                                            Strings.tituloDetalles))));
                            break;
                        }
                      },
                      child: BlocBuilder<SeguroBloc, SeguroState>(
                        builder: (context, state) {
                          return IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.indigo,
                              ),
                              onPressed: () {
                                BlocProvider.of<SeguroBloc>(context)
                                    .add(DetallesButtonPressedEvent());

                                BlocProvider.of<SeguroBloc>(context)
                                    .add(ReturnListaPressedEvent());
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
    );
  }

  eliminarSeguro(context, seguro) {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(localizations.dictionary(Strings.eliminar)),
              content: Text(
                  localizations.dictionary(Strings.consultaEliminarSeguro) +
                      seguro.numeroPoliza +
                      "?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(localizations.dictionary(Strings.botonCancelar),
                        style: const TextStyle(
                          color: Colors.blue,
                        ))),
                BlocProvider(
                  create: (context) => SeguroBloc(),
                  child: BlocListener<SeguroBloc, SeguroState>(
                    listener: (context, state) {
                      switch (state.runtimeType) {
                        case EliminandoSeguroState:
                          break;

                        case SeguroEliminadoState:
                          Navigator.pop(context);
                          Flushbar(
                            title: localizations.dictionary(Strings.eliminado),
                            message: localizations
                                .dictionary(Strings.seguroEliminado),
                            duration: const Duration(seconds: 2),
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 55.0, left: 8, right: 8),
                            borderRadius: BorderRadius.circular(8),
                          ).show(context);
                          break;
                      }
                    },
                    child: BlocBuilder<SeguroBloc, SeguroState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () {
                              if (MyApp.conectedToNetwork) {
                                final response = ApiManagerSeguro.shared
                                    .request(
                                        baseUrl: const MyApp().baseURL,
                                        pathUrl: "/seguro/eliminar/" +
                                            seguro.numeroPoliza.toString(),
                                        type: HttpType.DELETE,
                                        seguro: seguro);
                                if (response != null) {
                                  BlocProvider.of<SeguroBloc>(context)
                                      .add(SeguroEliminadoEvent());
                                }
                              } else {
                                mostrarFlushbar(context);
                              }
                            },
                            child: Text(
                              localizations.dictionary(Strings.eliminar),
                              style: const TextStyle(color: Colors.red),
                            ));
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
