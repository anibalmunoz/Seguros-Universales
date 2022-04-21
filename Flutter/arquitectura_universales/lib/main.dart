import 'dart:async';

import 'package:arquitectura_universales/pages/page_one/formulario_login.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/clientes_page.dart';
import 'package:arquitectura_universales/widgets/barra_navegacion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runZonedGuarded(() => runApp(const MyApp()),
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

  Future<void> _inicializarCloudFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebase = inicializarFirebase();
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
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  darkTheme: ThemeData.dark(),
                  themeMode: currentMode,
                  home: FormularioLogin(),
                );
              });
        });
  }
}
