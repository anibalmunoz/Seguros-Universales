import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/seguro-model.dart';
import 'package:arquitectura_universales/pages/paginas_datos/seguros/creacion_seguro.dart';
import 'package:arquitectura_universales/pages/paginas_datos/seguros/detalles_seguro.dart';
import 'package:arquitectura_universales/providers/api_manager_seguro.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';

class SegurosPage extends StatelessWidget {
  final baseURL = MyApp().baseURL;
  final pathURL = "/seguro/buscar";
  List _seguros = [];

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
            "Seguros",
            style: TextStyle(height: 4),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 33.0),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                  icon:
                      const Icon(Icons.health_and_safety, color: Colors.amber),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreacionSeguro(titulo: "Crear nuevo seguro"),
                        )).then((value) => null);
                  }),
            ),
          ],
        ),
        body: FutureBuilder(
          future: ApiManagerSeguro.shared
              .request(baseUrl: baseURL, pathUrl: pathURL, type: HttpType.GET),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final SegurosLista segurosLista =
                  snapshot.requireData as SegurosLista;
              _seguros = segurosLista.seguros;
              print("SI HAY INFORMACIÓN");
              //print("LA LISTA DE CLIENTES ES: ${_clientes[0]}");
            } else {
              print("NO HAY INFORMACIÓN");
            }

            print("Por defecto");
            return ListView.builder(
              itemCount: _seguros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onLongPress: () {
                    eliminarSeguro(context, _seguros[index]);
                  },
                  title: Text("Poliza # " +
                      _seguros[index].numeroPoliza +
                      ", Ramo: " +
                      _seguros[index].ramo),

                  subtitle: Text("Fecha de Vencimiento: " +
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
                  trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.indigo,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesSeguro(
                                  seguro: _seguros[index], titulo: "Detalles"),
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

  eliminarSeguro(context, seguro) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Eliminar"),
              content: Text("¿Estas seguro de eliminar el seguro " +
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
                      ApiManagerSeguro.shared.request(
                          baseUrl: MyApp().baseURL,
                          pathUrl: "/seguro/eliminar/" +
                              seguro.numeroPoliza.toString(),
                          type: HttpType.DELETE,
                          seguro: seguro);
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
