import 'package:arquitectura_universales/bloc/basic_bloc/basic_bloc.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/widgets/text_box.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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

  // TextEditingController controllerNombre;
  // TextEditingController controllerApellido1;
  // TextEditingController controllerApellido2;

  // @override
  // void initState() {
  //   controllerNombre = TextEditingController();
  //   controllerApellido1 = TextEditingController();
  //   controllerApellido2 = TextEditingController();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    String nombre = widget.cliente.nombre;

    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                ? Colors.red
                : Colors.blue,
            bottom: const PreferredSize(
              preferredSize: Size(12, 12),
              child: Text(""),
            ),
            title: Text(
              widget.titulo,
              style: TextStyle(height: 4),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(top: 37.0),
                // child: const Text(
                //   "Registrar nuevo",
                //   style: TextStyle(color: Colors.amber, fontFamily: "Lato"),
                // ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 25.0),
              //   child: IconButton(
              //       icon:
              //           const Icon(Icons.person_add_alt_sharp, color: Colors.amber),
              //       onPressed: () {}),
              // ),
            ],
          ),
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
                              Icons.person,
                              color: Colors.amberAccent,
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
                                        return 'Correo vacío';
                                      }
                                      // if (!valor.isValidEmail) {
                                      //   return 'Correo Inválido';
                                      // }
                                      if (valor !=
                                          FirebaseRemoteConfig.instance
                                              .getString("correo")) {
                                        return 'El correo no está registrado';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.text_fields_rounded),
                                        labelText: "Nombre",
                                        hintText: "Nombre",
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

                                      if (valor !=
                                          FirebaseRemoteConfig.instance
                                              .getString("password")) {
                                        return "La contraseña no está registrada";
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.password_outlined),
                                      labelText: "Contraseña",
                                      helperText: "Aa@45678",
                                      border: OutlineInputBorder(),
                                      isDense: false,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: 450,
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: estiloBotonGuardar,
                                      onPressed: () {
                                        if (_keyForm.currentState!
                                            .validate()) {}
                                      },
                                      child: const Text(
                                          '                 Guardar                        '),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: estiloBotonEliminar,
                                      onPressed: () {
                                        eliminarCliente(
                                            context, widget.cliente);
                                      },
                                      child: const Text(
                                          '                 Eliminar                        '),
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
          )),
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
                    // style: TextButton.styleFrom(
                    //   padding: const EdgeInsets.all(16.0),
                    //   primary: Colors.white,
                    //   textStyle: const TextStyle(fontSize: 20),
                    // ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar",
                        style: TextStyle(
                          color: Colors.blue,
                        ))),
                TextButton(
                    onPressed: () {
                      print(cliente.nombre);

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
