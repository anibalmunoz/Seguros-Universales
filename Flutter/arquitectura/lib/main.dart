import 'dart:async';

import 'package:arquitectura/pages/page_one/formulario_2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() => runApp(const MyApp()),
      (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _firebase;

  Future<void> inicializarFirebase() async {
    await Firebase.initializeApp();
    await _inicializarCrashlytics();
    await _inicializarCloudMessagin();
    await _inicializarRemoteConfig();
  }

  Future<void> _inicializarCrashlytics() async {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);

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

    firebaseRemoteConfig.fetchAndActivate();

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
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Formulario2(),
          );
        });
  }
}
