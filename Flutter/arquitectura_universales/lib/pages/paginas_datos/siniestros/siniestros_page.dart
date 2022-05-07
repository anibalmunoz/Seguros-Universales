import 'package:another_flushbar/flushbar.dart';
import 'package:arquitectura_universales/blocs/siniestro_bloc/siniestro_bloc.dart';
import 'package:arquitectura_universales/localizations/localization.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/siniestro_model.dart';
import 'package:arquitectura_universales/pages/paginas_datos/siniestros/creacion_siniestro.dart';
import 'package:arquitectura_universales/pages/paginas_datos/siniestros/detalles_siniestro.dart';
import 'package:arquitectura_universales/providers/api_manager_siniestro.dart';
import 'package:arquitectura_universales/util/app_string.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SiniestrosPage extends StatelessWidget {
  final baseURL = MyApp().baseURL;
  final pathURL = "/siniestro/buscar";
  List _siniestros = [];

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
                  localizations.dictionary(Strings.tituloSiniestrosPage),
                  style: TextStyle(height: 4),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(top: 33.0),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: BlocProvider(
                      create: (context) => SiniestroBloc(),
                      child: BlocListener<SiniestroBloc, SiniestroState>(
                        listener: (context, state) {
                          switch (state.runtimeType) {
                            case IrACreacionState:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (cxt) => CreacionSiniestro(
                                          titulo: localizations.dictionary(Strings
                                              .tituloCrearNuevoSiniestroPage))));
                              break;
                          }
                        },
                        child: BlocBuilder<SiniestroBloc, SiniestroState>(
                          builder: (context, state) {
                            return IconButton(
                                icon: const Icon(
                                    Icons.add_circle_outline_rounded,
                                    color: Colors.amber),
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => CreacionSiniestro(
                                  //           titulo: "Crear nuevo siniestro"),
                                  //     )).then((value) => null);
                                  BlocProvider.of<SiniestroBloc>(context)
                                      .add(CreacionSiniestroEvent());

                                  BlocProvider.of<SiniestroBloc>(context)
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
          future: ApiManagerSiniestro.shared
              .request(baseUrl: baseURL, pathUrl: pathURL, type: HttpType.GET),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final SiniestrosLista siniestrosLista =
                  snapshot.requireData as SiniestrosLista;
              _siniestros = siniestrosLista.siniestros;
              // print("SI HAY INFORMACIÓN");
              //print("LA LISTA DE CLIENTES ES: ${_clientes[0]}");
            } else {
              // print("NO HAY INFORMACIÓN");
            }

            // print("Por defecto");
            return ListView.builder(
              itemCount: _siniestros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onLongPress: () {
                    eliminarSiniestro(context, _siniestros[index]);
                  },

                  title: Text("ID # " +
                      _siniestros[index].idSiniestro +
                      localizations.dictionary(Strings.listaCausas) +
                      _siniestros[index].causas),

                  subtitle: Text(
                      localizations.dictionary(Strings.listaFechaSiniestro) +
                          _siniestros[index].fechaSiniestro.toString()),
                  // subtitle: Text("Condiciones: " +
                  //     _seguros[index].condicionesParticulares),
                  leading: const CircleAvatar(
                      backgroundColor: Colors.amberAccent,
                      child: Icon(
                        Icons.taxi_alert,
                      )
                      //Text(_clientes[index].nombre.substring(0, 1)),
                      ),
                  trailing: BlocProvider(
                    create: (context) => SiniestroBloc(),
                    child: BlocListener<SiniestroBloc, SiniestroState>(
                      listener: (context, state) {
                        switch (state.runtimeType) {
                          case IrADetallesPageState:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (cxt) => DetallesSiniestro(
                                        siniestro: _siniestros[index],
                                        titulo: localizations.dictionary(
                                            Strings.tituloDetalles))));
                            break;
                        }
                      },
                      child: BlocBuilder<SiniestroBloc, SiniestroState>(
                        builder: (context, state) {
                          return IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.indigo,
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => DetallesSiniestro(
                                //           siniestro: _siniestros[index],
                                //           titulo: "Detalles"),
                                //     ));

                                BlocProvider.of<SiniestroBloc>(context)
                                    .add(DetallesButtonPressedEvent());

                                BlocProvider.of<SiniestroBloc>(context)
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

  eliminarSiniestro(context, siniestro) {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(localizations.dictionary(Strings.eliminar)),
              content: Text(
                  localizations.dictionary(Strings.consultaEliminarSiniestro) +
                      siniestro.idSiniestro +
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
                  create: (context) => SiniestroBloc(),
                  child: BlocListener<SiniestroBloc, SiniestroState>(
                    listener: (context, state) {
                      switch (state.runtimeType) {
                        case EliminandoSiniestroState:
                          break;

                        case SiniestroEliminadoState:
                          Navigator.pop(context);
                          Flushbar(
                            title: localizations.dictionary(Strings.eliminado),
                            message: localizations
                                .dictionary(Strings.siniestroEliminado),
                            duration: const Duration(seconds: 2),
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 55.0, left: 8, right: 8),
                            borderRadius: BorderRadius.circular(8),
                          ).show(context);
                          break;
                      }
                    },
                    child: BlocBuilder<SiniestroBloc, SiniestroState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () {
                              if (MyApp.conectedToNetwork) {
                                final response = ApiManagerSiniestro.shared
                                    .request(
                                        baseUrl: MyApp().baseURL,
                                        pathUrl: "/siniestro/eliminar/" +
                                            siniestro.idSiniestro.toString(),
                                        type: HttpType.DELETE,
                                        siniestro: siniestro);
                                if (response != null) {
                                  BlocProvider.of<SiniestroBloc>(context)
                                      .add(SiniestroEliminadoEvent());
                                }
                              } else {
                                mostrarFlushbar(context);
                              }
                            },
                            child: Text(
                              localizations.dictionary(Strings.eliminar),
                              style: TextStyle(color: Colors.red),
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
