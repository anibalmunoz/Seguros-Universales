import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:arquitectura_universales/blocs/basic_bloc/basic_bloc.dart';
import 'package:arquitectura_universales/localizations/localization.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.login.dart';
import 'package:arquitectura_universales/util/app_string.dart';
import 'package:arquitectura_universales/util/app_type.dart';
import 'package:arquitectura_universales/widgets/barra_navegacion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:arquitectura_universales/util/extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as Encrypt;
import 'package:local_auth_android/local_auth_android.dart';

class FormularioLogin extends StatelessWidget {
  FormularioLogin({Key? key}) : super(key: key);
  String nombre = "Anibal";
  final _keyForm = GlobalKey<FormState>();
  final baseURL = const MyApp().baseURL;
  final pathURL = "/cliente/login";
  Cliente client = new Cliente();

  var correoController = TextEditingController();
  var contrasenaController = TextEditingController();
  static bool conectedToNetwork = false;
  static String? correoPrefs;
  static String? contrasenaPrefs;

  static BasicBloc? basicBloc;

  static LocalAuthentication? localAuth;
  static bool isBiometricAvailable = false;
  static bool hayHuellaDisponible = false;

  late Timer timer;

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    // String correo = FirebaseRemoteConfig.instance.getString("correo");
    // String password = FirebaseRemoteConfig.instance.getString("password");

    basicBloc = BlocProvider.of<BasicBloc>(context);

    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

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
      // appBar: AppBar(
      //   backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
      //       ? Colors.blue[900]
      //       : Colors.grey[900],
      //   title: Text(localizations.dictionary(Strings.tituloLogin)),
      //   actions: [
      //     IconButton(
      //         icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
      //             ? Icons.dark_mode
      //             : Icons.light_mode),
      //         onPressed: () {
      //           MyApp.themeNotifier.value =
      //               MyApp.themeNotifier.value == ThemeMode.light
      //                   ? ThemeMode.dark
      //                   : ThemeMode.light;
      //           if (MyApp.themeNotifier.value == ThemeMode.dark) {
      //             cambiarADarck();
      //           } else {
      //             cambiarALight();
      //           }
      //           print(
      //               "EL VALOR DEL THEME NOTIFIER ES ${MyApp.themeNotifier.value}");
      //         }),
      //   ],
      // ),

      body: BlocProvider(
        create: (BuildContext context) => BasicBloc(),
        child: BlocListener<BasicBloc, BasicState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case AppStarted:
                break;
              case PageChanged:
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        child: IconButton(
                            icon: Icon(
                                MyApp.themeNotifier.value == ThemeMode.light
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
                            }),
                      ),
                    ],
                  ),
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
                                      ? Colors.blue
                                      : Colors.blueAccent,
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
                                        onTap: () async {},
                                        //autofillHints: [AutofillHints.email],
                                        controller: correoController,
                                        validator: (valor) {
                                          //client.correo = valor;
                                          if (valor!.isEmpty) {
                                            return localizations.dictionary(
                                                Strings.correoVacio);
                                          }
                                          if (!valor.isValidEmail) {
                                            return localizations.dictionary(
                                                Strings.correoInvalido);
                                          }

                                          return null;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            icon:
                                                const Icon(Icons.mail_outline),
                                            labelText: localizations.dictionary(
                                                Strings
                                                    .textFieldCorreoElectronico),
                                            helperText: "mail@mail.com",
                                            border: const OutlineInputBorder(),
                                            isDense: false,
                                            contentPadding:
                                                const EdgeInsets.all(10)),
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
                                            return localizations
                                                .dictionary(Strings.campoVacio);
                                          }
                                          if (!valor.isValidPassword) {
                                            return localizations.dictionary(
                                                Strings
                                                    .contrasenaInvalidaDebeTener);
                                          }

                                          return null;
                                        },
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          icon: const Icon(
                                              Icons.password_outlined),
                                          labelText: localizations.dictionary(
                                              Strings.textFieldContrasena),
                                          helperText: "Aa@45678",
                                          border: const OutlineInputBorder(),
                                          isDense: false,
                                          contentPadding:
                                              const EdgeInsets.all(10),
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
                                                  await login(context, false);
                                              //agregarUbicacion();
                                              if (logueado) {
                                                agregarUbicacion();
                                                basicBloc!.add(LogueadoEvent());
                                              }
                                            }
                                          },
                                          child: Text(localizations.dictionary(
                                              Strings.botonIngresar)),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: Column(
                                          children: isBiometricAvailable
                                              ? [
                                                  IconButton(
                                                      onPressed: () async {
                                                        await verificarDisponibilidadHuellas();

                                                        await asignarDesdeSharedPreferences();

                                                        if (correoPrefs !=
                                                                null &&
                                                            correoPrefs !=
                                                                "null" &&
                                                            isBiometricAvailable &&
                                                            hayHuellaDisponible) {
                                                          await mostrarSugerenciaLogin(
                                                              context);
                                                        } else if (correoPrefs ==
                                                                null ||
                                                            correoPrefs ==
                                                                "null") {
                                                          mostrarFlushbarNoCredencialesGuardadas(
                                                              context);
                                                        } else {
                                                          mostrarFlushbarProblemasFingerprint(
                                                              context);
                                                        }
                                                        // mostrarSugerenciaLogin(
                                                        //     context);
                                                      },
                                                      icon: const Icon(
                                                          Icons.fingerprint)),
                                                  Text(localizations.dictionary(
                                                      Strings.accesoBiometrico))
                                                ]
                                              : [],
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  static Future<void> cambiarALight() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("modo");
    await ref.set({"modo": "ThemeMode.light"});

    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('modo');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print("LA DATA OBTENIDA ES: ${data}");
    });

    //GUARDAR EN SHARED PREFERENCES

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tema", "ThemeMode.light");
  }

  static Future<void> cambiarADarck() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("modo");
    await ref.set({"modo": "ThemeMode.dark"});

    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('modo');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print("LA DATA OBTENIDA ES: ${data}");
    });

    //GUARDAR EN SHARED PREFERENCES

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tema", "ThemeMode.dark");
  }

  Future<bool> login(context, bool guardado) async {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    if (!guardado) {
      if (conectedToNetwork) {
        Map<String, dynamic> bodyMap;
        bodyMap = {
          "correo": correoController.text,
          "contrasena": contrasenaController.text
        };
        var jsonMap = json.encode(bodyMap);

        final response = await ApiManagerClienteLogin.shared.request(
            baseUrl: baseURL,
            pathUrl: pathURL,
            jsonParam: jsonMap,
            type: HttpType.POST);

        if (response?.body != "") {
          //SHARED PREFERENCES

          await verificarDisponibilidadHuellas();

          if (hayHuellaDisponible && isBiometricAvailable) {
            await consultarGuardarCredenciales(context).then((value) async {
              if (value == true) {
                await guardarEnSharedPreferences(
                    correoController.text, contrasenaController.text);
              } else {
                await guardarEnSharedPreferences("null", "null");
              }
            });
          }

          //FIN SHARED PREFERENCES

          return true;
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: const Text("Error"),
                  content: Text(localizations
                      .dictionary(Strings.errorCredencialesInvalidas))));
          return false;
        }
      } else {
        final response = await ApiManagerClienteLogin.shared.request(
            baseUrl: baseURL,
            pathUrl: pathURL,
            correo: correoController.text,
            contrasena: contrasenaController.text,
            type: HttpType.GET);

        if (response?.statusCode == 200) {
          return true;
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: const Text("Error"),
                  content: Text(localizations
                      .dictionary(Strings.errorCredencialesInvalidas))));

          Flushbar(
            title: localizations.dictionary(Strings.flushbarSinconexion),
            message: localizations.dictionary(Strings.flushbarNoTienesConexion),
            duration: const Duration(seconds: 2),
            margin:
                const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
            borderRadius: BorderRadius.circular(8),
          ).show(context);

          return false;
        }
      }
    } else {
      return true;
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

  Future<void> guardarEnSharedPreferences(correo, contrasena) async {
    String correoEncriptado = await encriptar(correo);
    String contrasenaEncriptada = await encriptar(contrasena);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    await prefs.setString("correo", correoEncriptado.toString());
    await prefs.setString("contrasena", contrasenaEncriptada.toString());
  }

  static Future<void> asignarDesdeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    correoPrefs = prefs.getString("correo");
    contrasenaPrefs = prefs.getString("contrasena");

    if (correoPrefs != null && contrasenaPrefs != null) {
      String correoDesencriptado = await desencriptar(correoPrefs);
      String contrasenaDesencriptada = await desencriptar(contrasenaPrefs);

      correoPrefs = correoDesencriptado;
      contrasenaPrefs = contrasenaDesencriptada;

      print(
          "EL NOMBRE Y LA CONTRASEÑA ALMACENADAS EN SHARED PREFERENES Y DESENCRIPTADAS SON");
      print(correoDesencriptado);
      print(contrasenaDesencriptada);
    }
  }

  // static Future<void> eliminarSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  // }

  mostrarSugerenciaLogin(context) async {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(localizations.dictionary(Strings.botonIngresar)),
              content: Text(localizations
                      .dictionary(Strings.dialogUltimaSesionCon) +
                  correoPrefs! +
                  localizations.dictionary(Strings.dialogQuieresIniciarCon)),
              actions: [
                TextButton(
                  child: Text(localizations.dictionary(Strings.botonCancelar),
                      style: const TextStyle(
                        color: Colors.grey,
                      )),
                  onPressed: () async {
                    // await eliminarSharedPreferences();
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    localizations.dictionary(Strings.botonIngresar),
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onPressed: () async {
                    try {
                      var androidStrings = AndroidAuthMessages(
                          signInTitle:
                              localizations.dictionary(Strings.botonIngresar),
                          biometricHint:
                              localizations.dictionary(Strings.verifiqueHuella),
                          cancelButton:
                              localizations.dictionary(Strings.botonCancelar),
                          biometricRequiredTitle: "",
                          deviceCredentialsSetupDescription: "",
                          //biometricNotRecognized: "No reconocida",
                          //biometricSuccess: "Huella reconocida",
                          deviceCredentialsRequiredTitle: "",
                          goToSettingsButton: "",
                          goToSettingsDescription: "");

                      //     // goToSettingsButton: 'settings',
                      //     // goToSettingsDescription:
                      //     //     'Please set up your Touch ID.',
                      //     // lockOut: 'Please reenable your Touch ID'
                      //     );

                      var didAuthenticate = await localAuth!.authenticate(
                          authMessages: [androidStrings],
                          localizedReason: localizations
                              .dictionary(Strings.lectorSolicitudIdentificarse),
                          options: const AuthenticationOptions(
                            biometricOnly: true,
                            useErrorDialogs: false,
                            stickyAuth: false,
                          ));

                      if (didAuthenticate) {
                        Navigator.pop(context);
                        bool logueado = await login(context, true);
                        if (logueado) {
                          agregarUbicacion();
                          FormularioLogin.basicBloc!.add(LogueadoEvent());
                        }
                      } else {
                        Navigator.pop(context);
                      }
                    } on PlatformException catch (e) {
                      if (e.code.toString() == "LockedOut") {
                        print("Intento de manejar error ${e.code.toString()}");
                        Navigator.pop(context);
                        mostrarFlushbar(context, "temporal");
                      }
                      if (e.code.toString() == "PermanentlyLockedOut") {
                        print("Intento de manejar error ${e.code.toString()}");
                        Navigator.pop(context);
                        mostrarFlushbar(context, "permanente");
                      }
                      print("${e.message}");
                    }
                  },
                ),
              ],
            ));
  }

  Future<bool> consultarGuardarCredenciales(context) async {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(localizations.dictionary(Strings.botonIngresar)),
              content: Text(
                  localizations.dictionary(Strings.dialogSugerenciaIngresar)),
              actions: [
                TextButton(
                  child: Text(localizations.dictionary(Strings.botonCancelar),
                      style: const TextStyle(
                        color: Colors.grey,
                      )),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                TextButton(
                  child: Text(
                    localizations.dictionary(Strings.botonGuardar),
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onPressed: () async {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ));
  }

  Future<String> encriptar(cadenas) async {
    //final String plainText = cadenas;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(cadenas);
    // final key = Encrypt.Key.fromUtf8('my 32 length key................');
    // final iv = Encrypt.IV.fromLength(16);

    // final encrypter = Encrypt.Encrypter(Encrypt.AES(key));

    // final encrypted = encrypter.encrypt(plainText, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);

    // print("SE ENCRIPTÓ LO IGUIENTE");
    // //print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    // print(encrypted.bytes);

    return encoded;
  }

  static Future<String> desencriptar(cadenas) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final String plainText = stringToBase64.decode(cadenas);

    // final key = Encrypt.Key.fromUtf8('my 32 length key................');
    // final iv = Encrypt.IV.fromLength(16);

    // final encrypter = Encrypt.Encrypter(Encrypt.AES(key));

    // //final encrypted = encrypter.encrypt(plainText, iv: iv);
    // //final decrypted = encrypter.decrypt(plainText, iv: iv);

    // print("SE Desencriptó LO IGUIENTE");
    // // print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    // //print(encrypted.base64);

    return plainText;
  }

  static Future<void> verificarDisponibilidadHuellas() async {
    localAuth = LocalAuthentication();
    await localAuth!.canCheckBiometrics.then((value) {
      isBiometricAvailable = value;
    });
    await localAuth!.getAvailableBiometrics().then((value) => {
          print("LA LISTA DE BIOMETRICOS DISPONIBLES ES: $value"),
          if (value.toString() != "[]")
            {hayHuellaDisponible = true}
          else
            {hayHuellaDisponible = false}
        });
  }

  mostrarFlushbar(context, String tipo) async {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    int segundos = 30;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      segundos = segundos - 1;
    });
    if (tipo == "temporal") {
      Flushbar(
        title: localizations
            .dictionary(Strings.flushbarBloqueoLectorTemporalTitulo),
        message: localizations
            .dictionary(Strings.flushbarBloqueoLectorTemporalMensaje),
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
    } else {
      Flushbar(
        title: localizations
            .dictionary(Strings.flushbarBloqueoLectorPermanenteTitulo),
        message: localizations
            .dictionary(Strings.flushbarBloqueoLectorPermanenteMensaje),
        duration: const Duration(seconds: 6),
        margin: const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
    }
  }

  mostrarFlushbarNoCredencialesGuardadas(context) async {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    Flushbar(
      title: localizations.dictionary(Strings.noHayCredencialesAlmacenadas),
      message: localizations.dictionary(Strings.ingresaUsuarioYContrasena),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  mostrarFlushbarProblemasFingerprint(context) async {
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    Flushbar(
      title: localizations.dictionary(Strings.noTienesHuella),
      message: localizations.dictionary(Strings.configuraHuella),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }
}
