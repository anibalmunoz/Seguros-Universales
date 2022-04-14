import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/seguro-model.dart';
import 'package:arquitectura_universales/providers/api_manager_seguro.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';

class SegurosPage extends StatelessWidget {
  final baseURL = "192.168.0.17:9595";
  final pathURL = "/seguro/buscar";
  List _seguros = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.red
              : Colors.blue,
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
              child: const Text(
                "Registrar nuevo",
                style: TextStyle(color: Colors.amber, fontFamily: "Lato"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                  icon:
                      const Icon(Icons.health_and_safety, color: Colors.amber),
                  onPressed: () {}),
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
                  // onLongPress: () {
                  //   print("IR A DETALLES");
                  // },
                  title: Text("Poliza # " + _seguros[index].numeroPoliza),

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
                        Icons.list_alt,
                        color: Colors.indigo,
                      ),
                      onPressed: () {
                        print("Ir a detalles de Seguro");
                        eliminarSeguro(context, _seguros[index]);
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
              title: Text("Eliminar"),
              content: Text("¿Estas seguro de eliminar la poliza # " +
                  seguro.numeroPoliza +
                  "?"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar",
                        style: TextStyle(
                          color: Colors.blue,
                        ))),
                FlatButton(
                    onPressed: () {
                      print(seguro.numeroPoliza);

                      //METODO PARA RECARGAR LA PÁGINA LUEGO DE BORRAR UN ELEMENTO this.setState(() {});
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
