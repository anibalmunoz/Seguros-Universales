import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/detalles_cliente.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:flutter/material.dart';

class ClientesPage extends StatelessWidget {
  ClientesPage({Key? key}) : super(key: key);
  // final baseURL = "jsonplaceholder.typicode.com";
  // final pathURL = "/users/1";
  final baseURL = "192.168.0.17:9595";
  final pathURL = "/cliente/buscar";
  List _clientes = [];

  @override
  Widget build(BuildContext context) {
    // return ValueListenableBuilder<ThemeMode>(
    //     valueListenable: MyApp.themeNotifier,
    //     builder: (_, ThemeMode currentMode, __) {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         theme: ThemeData(
    //           primarySwatch: Colors.blue,
    //           visualDensity: VisualDensity.adaptivePlatformDensity,
    //         ),
    //         darkTheme: ThemeData.dark(),
    //         themeMode: currentMode,
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.red
              : Colors.blue,
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
                  onPressed: () {}),
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
              //print("LA LISTA DE CLIENTES ES: ${_clientes[0]}");
            } else {
              print("NO HAY INFORMACIÓN");
            }

            return ListView.builder(
              itemCount: _clientes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // onLongPress: () {
                  //   print("IR A DETALLES");
                  // },
                  title: Text("Nombre: " +
                      _clientes[index].nombre +
                      " " +
                      _clientes[index].apeliido1),
                  subtitle: Text("DNI: " + _clientes[index].dni),
                  leading: const CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.photo_camera_front_outlined,
                      )
                      //Text(_clientes[index].nombre.substring(0, 1)),
                      ),
                  trailing: IconButton(
                      icon: const Icon(
                        Icons.list_alt,
                        color: Colors.indigo,
                      ),
                      onPressed: () {
                        print("Ir a detalles de Cliente");
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => DetallesCliente(cliente: ),
            //     ));
          },
          tooltip: "Agregar Cliente",
          child: Icon(Icons.person_add_alt),
        ),
      ),
    );
  }
}
