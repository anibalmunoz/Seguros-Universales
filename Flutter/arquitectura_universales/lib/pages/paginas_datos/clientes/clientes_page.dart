import 'package:arquitectura_universales/blocs/cliente_bloc/cliente_bloc.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/creacion_cliente.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/detalles_cliente.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.dart';
import 'package:arquitectura_universales/repository/cliente_repository.dart';
import 'package:arquitectura_universales/util/app_type.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClienteBloc(),
      child: SafeArea(
        child: Scaffold(
          key: _scaffKey,
          appBar: AppBar(
            backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                ? Colors.blue[900]
                : Colors.grey[900],
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
                                      titulo: "Crear nuevo cliente")));
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
                    onPressed: () {
                      ClienteRepository.shared.modificarTablaCliente();
                    }),
              ),
            ],
          ),
          body: FutureBuilder(
            future: ApiManagerCliente.shared.request(
                baseUrl: baseURL, pathUrl: pathURL, type: HttpType.GET),
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
                                          titulo: "Detalles")));
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
                                onPressed: () {
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
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Eliminar"),
              content: Text("¿Estas seguro de eliminar el cliente " +
                  cliente.nombrecl +
                  "?"),
              actions: [
                TextButton(
                  child: const Text("Cancelar",
                      style: TextStyle(
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
                          break;
                      }
                    },
                    child: BlocBuilder<ClienteBloc, ClienteState>(
                      builder: (context, state) {
                        return TextButton(
                          child: const Text(
                            "Eliminar",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
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
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ));
  }
}
