import 'dart:convert';

import 'package:arquitectura_universales/blocs/basic_bloc/basic_bloc.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.login.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:arquitectura_universales/widgets/barra_navegacion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:arquitectura_universales/util/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class FormularioLogin extends StatelessWidget {
  FormularioLogin({Key? key}) : super(key: key);
  String nombre = "Anibal";
  final _keyForm = GlobalKey<FormState>();
  final baseURL = const MyApp().baseURL;
  final pathURL = "/cliente/login";
  Cliente client = new Cliente();

  var correoController = TextEditingController();
  var contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    // String correo = FirebaseRemoteConfig.instance.getString("correo");
    // String password = FirebaseRemoteConfig.instance.getString("password");

    BasicBloc basicBloc;
    basicBloc = BlocProvider.of<BasicBloc>(context);

    askGpsAccess();

    final estiloBoton = ElevatedButton.styleFrom(
      primary: MyApp.themeNotifier.value == ThemeMode.light
          ? Color.fromARGB(255, 41, 106, 202)
          : Colors.teal,
      onPrimary: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return Scaffold(
      //backgroundColor:  Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
            ? Colors.blue[900]
            : Colors.grey[900],
        title: const Text('Login'),
        actions: [
          IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
                if (MyApp.themeNotifier.value == ThemeMode.dark) {
                  cambiarADarck();
                } else {
                  cambiarALight();
                }
                print(
                    "EL VALOR DEL THEME NOTIFIER ES ${MyApp.themeNotifier.value}");
              })
        ],
      ),

      body: BlocProvider(
        create: (BuildContext context) => BasicBloc(),
        child: BlocListener<BasicBloc, BasicState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case AppStarted:
                break;
              case PageChanged:
                final estado = state as PageChanged;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (cxt) => BarraNavegacion()));
                break;
            }
          },
          child: BlocBuilder<BasicBloc, BasicState>(
            builder: (context, state) {
              if (state is AppStarted) {
                print('aplicacion iniciada');
              }

              return Stack(
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
                                Icon(
                                  Icons.login_sharp,
                                  color: MyApp.themeNotifier.value ==
                                          ThemeMode.light
                                      ? Color.fromARGB(255, 41, 202, 154)
                                      : Colors.teal[100],
                                  size: 150.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      TextFormField(
                                        controller: correoController,
                                        validator: (valor) {
                                          //client.correo = valor;
                                          if (valor!.isEmpty) {
                                            return 'Correo vacío';
                                          }
                                          if (!valor.isValidEmail) {
                                            return 'Correo Inválido';
                                          }

                                          return null;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.mail_outline),
                                            labelText: "Correo electrónico",
                                            helperText: "correo@correo.com",
                                            border: OutlineInputBorder(),
                                            isDense: false,
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 15.0, bottom: 15.0),
                                      ),
                                      TextFormField(
                                        controller: contrasenaController,
                                        validator: (valor) {
                                          client.contrasena = valor;
                                          if (valor!.isEmpty) {
                                            return "Campo vacío";
                                          }
                                          if (!valor.isValidPassword) {
                                            return "La contraseña debe tener:\nMinimo 8 caracteres\nAl menos una letra mayúscula\n"
                                                "Al menos una letra minucula\n"
                                                "Al menos un dígito\n"
                                                "Al menos 1 caracter especial";
                                          }

                                          return null;
                                        },
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
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
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          style: estiloBoton,
                                          onPressed: () async {
                                            if (_keyForm.currentState!
                                                .validate()) {
                                              bool logueado =
                                                  await login(context);
                                              //agregarUbicacion();
                                              if (logueado) {
                                                agregarUbicacion();
                                                basicBloc.add(LogueadoEvent());
                                              }
                                            }
                                          },
                                          child: const Text('Login'),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    )),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> cambiarALight() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("modo");
    await ref.set({"modo": "ThemeMode.light"});

    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('modo');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print("LA DATA OBTENIDA ES: ${data}");
    });
  }

  //  update(data) {
  //     return null;
  //   }

  Future<void> cambiarADarck() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("modo");
    await ref.set({"modo": "ThemeMode.dark"});

    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('modo');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print("LA DATA OBTENIDA ES: ${data}");
    });
  }

  Future<bool> login(context) async {
    Map<String, dynamic> bodyMap;
    bodyMap = {
      "correo": correoController.text,
      "contrasena": contrasenaController.text
    };
    var jsonMap = json.encode(bodyMap);
    print(
        "EL CLIENTE QUE ESTOY MANDANDO EN ESTE LOGIN DE AHORA ES:  ${jsonMap}");
    final response = await ApiManagerClienteLogin.shared.request(
        baseUrl: baseURL,
        pathUrl: pathURL,
        jsonParam: jsonMap,
        type: HttpType.POST);

    print(
        "LA RESPUESTA DESDE LA PAGINA DE CLIENTE ES: ${response?.statusCode}");

    print("EL CUERPO DE LA RESPUESTA ES: ${response?.body}");

    if (response?.body != "") {
      // BlocProvider.of<BasicBloc>(context)
      //     .add(LoginButtonPressed(nombre: nombre));
      // BasicBloc basicBloc;
      // basicBloc = BlocProvider.of<BasicBloc>(context);

      // basicBloc.add(LogueadoEvent());

      return true;
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
              title: const Text("Error"),
              content: Text("Credenciales Inválidas, intenta nuevamente")));
      return false;
    }
  }

  Position? _initialPosition;
  Position? get initialPosition => _initialPosition;

  Future<void> agregarUbicacion() async {
    FirebaseFirestore firestores = FirebaseFirestore.instance;
    CollectionReference ubicaciones = firestores.collection('ubicaciones');

    Future<void> addUbicacion() async {
      // Call the user's CollectionReference to add a new user

      final isEnable = await Geolocator.isLocationServiceEnabled();

      if (isEnable == true) {
        _initialPosition = await Geolocator.getCurrentPosition();
      }

      return ubicaciones
          .add({
            'ubicacion': _initialPosition.toString(),
            "detalles": "Post Login  ${DateTime.now()}"
          })
          .then((value) => print(
              "UBICACION ENVIADA A FIRESTORE ${DateTime.now()} ES: ${_initialPosition}"))
          .catchError((error) =>
              print("ENVIO DE UBICACION A FIRESTORE FALLIDA: $error"));
    }

    addUbicacion();
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        print("EL PERMISO HA SIDO OTORGADO");
        break;
      case PermissionStatus.denied:

      case PermissionStatus.restricted:

      case PermissionStatus.limited:

      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
