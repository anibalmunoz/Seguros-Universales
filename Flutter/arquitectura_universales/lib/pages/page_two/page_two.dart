import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final String title;
  const PageTwo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(this.title),
        ),
        body: Column(children: [
          ElevatedButton(
            child: const Text("Generar Error"),
            onPressed: () {
              print(
                  FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled);
              FirebaseCrashlytics.instance
                  .log("Higgs-Boson detected! Bailing out");
            },
          ),
          ElevatedButton(
              onPressed: () async {
                FirebaseCrashlytics.instance.log(
                    "Envío de prueba de parte del correo: " +
                        FirebaseRemoteConfig.instance.getString("correo"));
                FirebaseCrashlytics.instance.crash();
              },
              child: const Text("Enviar Parámetros a Crashlitycs")),
        ]));
  }
}
