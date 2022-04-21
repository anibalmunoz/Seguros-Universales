import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/pages/paginas_datos/clientes/clientes_page.dart';
import 'package:arquitectura_universales/pages/paginas_datos/seguros/seguros_page.dart';
import 'package:arquitectura_universales/pages/paginas_datos/siniestros/siniestros_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarraNavegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                ? Colors.blue[900]
                : Colors.grey[900],
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded,
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.white
                          : Colors.white),
                  activeIcon: Icon(Icons.person_outline,
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.white
                          : Colors.white),
                  label: ("Clientes")),
              BottomNavigationBarItem(
                icon: Icon(Icons.security_rounded,
                    color: MyApp.themeNotifier.value == ThemeMode.light
                        ? Colors.white
                        : Colors.white),
                activeIcon: Icon(Icons.shield_outlined,
                    color: MyApp.themeNotifier.value == ThemeMode.light
                        ? Colors.white
                        : Colors.white),
                label: "Seguros",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.taxi_alert,
                    color: MyApp.themeNotifier.value == ThemeMode.light
                        ? Colors.white
                        : Colors.white),
                activeIcon: Icon(Icons.taxi_alert_outlined,
                    color: MyApp.themeNotifier.value == ThemeMode.light
                        ? Colors.white
                        : Colors.white),
                label: ("Siniestros"),
              ),
            ]),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (BuildContext context) {
                return ClientesPage();
              });
            case 1:
              return CupertinoTabView(builder: (BuildContext context) {
                return SegurosPage();
              });
            case 2:
              return CupertinoTabView(builder: (BuildContext context) {
                return SiniestrosPage();
              });
            default:
              return CupertinoTabView(
                builder: (BuildContext context) => ClientesPage(),
              );
          }
        },
      ),
    );
  }
}
