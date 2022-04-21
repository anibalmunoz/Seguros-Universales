import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/siniestro_model.dart';
import 'package:arquitectura_universales/pages/paginas_datos/siniestros/creacion_siniestro.dart';
import 'package:arquitectura_universales/pages/paginas_datos/siniestros/detalles_siniestro.dart';
import 'package:arquitectura_universales/providers/api_manager_siniestro.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';

class SiniestrosPage extends StatelessWidget {
  final baseURL = MyApp().baseURL;
  final pathURL = "/siniestro/buscar";
  List _siniestros = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.blue[900]
              : Colors.grey[900],
          bottom: const PreferredSize(
            preferredSize: Size(13, 13),
            child: Text(""),
          ),
          title: const Text(
            "Siniestros",
            style: TextStyle(height: 4),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 33.0),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded,
                      color: Colors.amber),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreacionSiniestro(
                              titulo: "Crear nuevo siniestro"),
                        )).then((value) => null);
                  }),
            ),
          ],
        ),
        body: FutureBuilder(
          future: ApiManagerSiniestro.shared
              .request(baseUrl: baseURL, pathUrl: pathURL, type: HttpType.GET),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final SiniestrosLista siniestrosLista =
                  snapshot.requireData as SiniestrosLista;
              _siniestros = siniestrosLista.siniestros;
              print("SI HAY INFORMACIÓN");
              //print("LA LISTA DE CLIENTES ES: ${_clientes[0]}");
            } else {
              print("NO HAY INFORMACIÓN");
            }

            print("Por defecto");
            return ListView.builder(
              itemCount: _siniestros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onLongPress: () {
                    eliminarSiniestro(context, _siniestros[index]);
                  },

                  title: Text("ID # " +
                      _siniestros[index].idSiniestro +
                      " Causas: " +
                      _siniestros[index].causas),

                  subtitle: Text("Fecha de Siniestro: " +
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
                  trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.indigo,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesSiniestro(
                                  siniestro: _siniestros[index],
                                  titulo: "Detalles"),
                            ));
                      }),
                );
              },
            );
          },
        ),
      ),
    );
  }

  eliminarSiniestro(context, siniestro) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Eliminar"),
              content: Text("¿Estas seguro de eliminar el siniestro  " +
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
                      ApiManagerSiniestro.shared.request(
                          baseUrl: MyApp().baseURL,
                          pathUrl: "/seguro/eliminar/" +
                              siniestro.idSiniestro.toString(),
                          type: HttpType.DELETE,
                          siniestro: siniestro);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Eliminar",
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ));
  }
}
