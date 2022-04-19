import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/creacion_cliente.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/detalles_cliente.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';

class ClientesPage extends StatelessWidget {
  ClientesPage({Key? key}) : super(key: key);
  // final baseURL = "jsonplaceholder.typicode.com";
  // final pathURL = "/users/1";
  final baseURL = MyApp().baseURL;
  final pathURL = "/cliente/buscar";
  List _clientes = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.blue[900]
              : Colors.red,
          bottom: const PreferredSize(
            preferredSize: Size(12, 12),
            child: Text(""),
          ),
          title: const Text(
            "Clientes",
            style: TextStyle(height: 4),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 37.0),
              child: const Text(
                "Registrar nuevo",
                style: TextStyle(color: Colors.amber, fontFamily: "Lato"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: IconButton(
                  icon: const Icon(Icons.person_add_alt_sharp,
                      color: Colors.amber),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreacionCliente(titulo: "Crear nuevo cliente"),
                        )).then((value) => null);
                  }),
            ),
          ],
        ),
        body: FutureBuilder(
          future: ApiManagerCliente.shared
              .request(baseUrl: baseURL, pathUrl: pathURL, type: HttpType.GET),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final ClientesLista clientesLista =
                  snapshot.requireData as ClientesLista;
              _clientes = clientesLista.clientes;
              print("SI HAY INFORMACIÓN");
            } else {
              print("NO HAY INFORMACIÓN");
            }

            return ListView.builder(
              itemCount: _clientes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onLongPress: () {
                    eliminarCliente(context, _clientes[index]);
                  },
                  title: Text("Nombre: " +
                      _clientes[index].nombre +
                      " " +
                      _clientes[index].apeliido1),
                  subtitle: Text("DNI: " + _clientes[index].dni.toString()),
                  leading: const CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.photo_camera_front_outlined,
                      )
                      //Text(_clientes[index].nombre.substring(0, 1)),
                      ),
                  trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(255, 41, 106, 202),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesCliente(
                                  cliente: _clientes[index],
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

  eliminarCliente(context, cliente) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Eliminar"),
              content: Text("¿Estas seguro de eliminar el cliente " +
                  cliente.nombre +
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
                      ApiManagerCliente.shared.request(
                          baseUrl: MyApp().baseURL,
                          pathUrl:
                              "/cliente/eliminar/" + cliente.dni.toString(),
                          type: HttpType.DELETE);
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
