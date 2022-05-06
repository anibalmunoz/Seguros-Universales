import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:arquitectura_universales/blocs/basic_bloc/basic_bloc.dart';
import 'package:arquitectura_universales/localizations/localization.dart';
import 'package:arquitectura_universales/pages/loading/loading_screen.dart';
import 'package:arquitectura_universales/pages/page_one/formulario_login.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/clientes_page.dart';
import 'package:arquitectura_universales/providers/api_manager_cliente.dart';
import 'package:arquitectura_universales/providers/api_manager_seguro.dart';
import 'package:arquitectura_universales/providers/api_manager_siniestro.dart';
import 'package:arquitectura_universales/util/app_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runZonedGuarded(
      () => runApp(MultiBlocProvider(
            providers: [BlocProvider(create: (context) => BasicBloc())],
            child: const MyApp(),
          )),
      (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatefulWidget {
  final baseURL = "192.168.0.32:9595";

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  /*
Implementación de dark light mode
 */
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  static bool conectedToNetwork = false;

  static String? idioma = "";
}

class _MyAppState extends State<MyApp> {
  late Future<void> _firebase;

  Future<void> inicializarFirebase() async {
    await Firebase.initializeApp();
    await _inicializarCrashlytics();
    await _inicializarCloudMessagin();
    await _inicializarRemoteConfig();
    await _inicializarRealtimeDatabase();
    await _inicializarCloudFirestore();
    await _seleccionarTemaDeSharedPreferences();
    await _seleccionarIdiomaDeSharedPreferences();
  }

  Future<void> _inicializarCrashlytics() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    Function onOriginalError = FlutterError.onError as Function;
    FlutterError.onError = (FlutterErrorDetails detallesDeError) async {
      await FirebaseCrashlytics.instance.recordFlutterError(detallesDeError);
      onOriginalError(detallesDeError);
    };
  }

  Future<void> _inicializarRemoteConfig() async {
    FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    firebaseRemoteConfig.setDefaults(
        {"correo": "munoz2hernandez@gmail.com", "password": "@Anibal12345"});

    await firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: const Duration(seconds: 5),
    ));

    await firebaseRemoteConfig.fetchAndActivate();

    print("EL CORREO QUE ESTABLECÍ EN FIREBASE ES: " +
        firebaseRemoteConfig.getString("correo"));

    print("LA CONTRASEÑA QUE ESTABLECÍ EN FIREBASE ES: " +
        firebaseRemoteConfig.getString("password"));
  }

  Future<void> _inicializarCloudMessagin() async {
    FirebaseMessaging cloudMessagin = FirebaseMessaging.instance;

    String? tokenUnico = await cloudMessagin.getToken() ?? "";
    print("EL TOKEN UNICO ES $tokenUnico");

    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.title);
    });
  }

  Future<void> _inicializarRealtimeDatabase() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("modo");
    //await ref.set({"modo": "ThemeMode.system"});
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print("LA DATA OBTENIDA ES: ${data}");
      if (data.toString() == "{modo: ThemeMode.light}") {
        MyApp.themeNotifier.value = ThemeMode.light;
      } else {
        MyApp.themeNotifier.value = ThemeMode.dark;
      }
    });
  }

  Future<void> _seleccionarTemaDeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tema = prefs.getString("tema");
    print("EL TEMA DE SHARED PREFERENCES ES: $tema");
    if (tema == "ThemeMode.light") {
      MyApp.themeNotifier.value = ThemeMode.light;
    } else if (tema == "ThemeMode.dark") {
      MyApp.themeNotifier.value = ThemeMode.dark;
    }
  }

  Future<void> _seleccionarIdiomaDeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lenguaje = prefs.getString("idioma");
    if (lenguaje != null) {
      MyApp.idioma = lenguaje;
    }
    print("EL IDIOMA QUE ESTÁ EN SHARED PREFERENCES ES ${MyApp.idioma}");
  }

  Future<void> _inicializarCloudFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  }

  @override
  void initState() {
    super.initState();
    _firebase = inicializarFirebase();
    if (MyApp.conectedToNetwork) {
      if (!MyApp.conectedToNetwork) {
        Flushbar(
          title: "Sin conexión a internet",
          message: "No tienes conexión a internet",
          duration: const Duration(seconds: 2),
          margin:
              const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
          borderRadius: BorderRadius.circular(8),
        ).show(context);
      }
    }

    FormularioLogin.asignarDesdeSharedPreferences();

    //Lector de huellas

    // FormularioLogin.localAuth = LocalAuthentication();
    // FormularioLogin.localAuth!.canCheckBiometrics.then((value) {
    //   FormularioLogin.isBiometricAvailable = value;
    // });
    // FormularioLogin.localAuth!.getAvailableBiometrics().then((value) => {
    //       print("el valor es"),
    //       print(value),
    //       if (value.toString() != "[]")
    //         {FormularioLogin.hayHuellaDisponible = true}
    //     });

    //FIN DE LECTOR DE HUELLAS
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebase,
        builder: (context, snapshot) {
          return ValueListenableBuilder<ThemeMode>(
              valueListenable: MyApp.themeNotifier,
              builder: (_, ThemeMode currentMode, __) {
                return MaterialApp(
                    supportedLocales: const [
                      Locale('es'),
                      Locale('en'),
                    ],
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                    ),
                    darkTheme: ThemeData.dark(),
                    themeMode: currentMode,
                    home: OfflineBuilder(
                      connectivityBuilder: (
                        BuildContext context,
                        ConnectivityResult connectivity,
                        Widget child,
                      ) {
                        final bool connected =
                            connectivity != ConnectivityResult.none;

                        MyApp.conectedToNetwork = connected;
                        FormularioLogin.conectedToNetwork = connected;
                        ClientesPage.conectedToNetwork = connected;
                        ApiManagerCliente.conectedToNetwork = connected;
                        ApiManagerSeguro.conectedToNetwork = connected;
                        ApiManagerSiniestro.conectedToNetwork = connected;

                        // AppLocalizations localizations =
                        //     Localizations.of<AppLocalizations>(
                        //         context, AppLocalizations)!;

                        // MyApp.idioma =
                        //     localizations.dictionary(Strings.dispisitivo);

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              height: 24.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                color: connected
                                    ? Color(0xFF00EE44)
                                    : Color(0xFFEE4400),
                                child: Center(
                                  child: Text(
                                      "${connected ? 'ONLINE' : 'OFFLINE'}"),
                                ),
                              ),
                            ),
                            Scaffold(
                              body: child,
                            ),
                          ],
                        );
                      },
                      child: LoadingScreen(),
                    ));
              });
        });
  }
}
