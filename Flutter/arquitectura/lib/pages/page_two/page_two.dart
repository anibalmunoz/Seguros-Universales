import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
            },
          ),
          ElevatedButton(
              onPressed: () {
                if (FirebaseCrashlytics
                    .instance.isCrashlyticsCollectionEnabled) {
                  FirebaseCrashlytics.instance.crash();
                } else {
                  print(FirebaseCrashlytics
                      .instance.isCrashlyticsCollectionEnabled);
                }
              },
              child: const Text("Enviar Parámetros a Crashlitycs")),
        ]));
  }
}
