import 'package:arquitectura_universales/blocs/basic_bloc/basic_bloc.dart';
import 'package:arquitectura_universales/localizations/localization.dart';
import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/pages/page_one/formulario_login.dart';
import 'package:arquitectura_universales/util/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  late BasicBloc basicBloc;
  late String idiomaBox;

  String? vista = MyApp.idioma;

  @override
  State<StatefulWidget> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    widget.basicBloc = BlocProvider.of<BasicBloc>(context);
    AppLocalizations localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    widget.idiomaBox = localizations.dictionary(Strings.dispisitivo);
    var listaIdiomas = [widget.idiomaBox, "Español", "English"];

    return SafeArea(
        child: Scaffold(
      appBar: MyApp.conectedToNetwork
          ? AppBar(
              backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                  ? Colors.blue[900]
                  : Colors.grey[900],
              bottom: const PreferredSize(
                preferredSize: Size(13, 13),
                child: Text(""),
              ),
              title: Text(
                localizations.dictionary(Strings.tituloAjustesPage),
                style: const TextStyle(
                  height: 4,
                ),
              ),
            )
          : AppBar(
              backgroundColor: Colors.red[900],
              bottom: const PreferredSize(
                preferredSize: Size(0, 0),
                child: Text(
                  "Sin conexión",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: const Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 4,
                ),
              ),
            ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 15.0, top: 10),
                  child: IconButton(
                      icon: Icon(
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        size: 35,
                      ),
                      onPressed: () {
                        MyApp.themeNotifier.value =
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
                        if (MyApp.themeNotifier.value == ThemeMode.dark) {
                          FormularioLogin.cambiarADarck();
                        } else {
                          FormularioLogin.cambiarALight();
                        }
                        print(
                            "EL VALOR DEL THEME NOTIFIER ES ${MyApp.themeNotifier.value}");
                      })),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "  " + localizations.dictionary(Strings.labelCambiarTema),
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 22),
                child: const Icon(
                  Icons.language,
                  size: 35,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    child: Text(
                      "   " +
                          localizations
                              .dictionary(Strings.labelSeleccionarOtroIdioma),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15.0, top: 10),
                    // child: IconButton(
                    //     icon: const Icon(
                    //       Icons.language,
                    //       size: 35,
                    //     ),
                    //     onPressed: () {})
                    child: DropdownButton(
                      items: listaIdiomas.map((String a) {
                        return DropdownMenuItem(value: a, child: Text(a));
                      }).toList(),
                      onChanged: (value) async => {
                        print(value.toString()),
                        await guardarEnSharedPreferences(value.toString()),
                        setState(() {
                          widget.vista = value.toString();
                        }),
                      },
                      hint: widget.vista != null &&
                              widget.vista != "Dispositivo" &&
                              widget.vista != "Device"
                          ? Text(widget.vista!)
                          : Text(localizations.dictionary(Strings.dispisitivo)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 15.0, top: 55),
                  child: IconButton(
                    onPressed: () {
                      widget.basicBloc.add(DeslogueadoEvent());
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 35,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 55),
                child: Text(
                  "   " + localizations.dictionary(Strings.labelCerrarSesion),
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  Future<void> guardarEnSharedPreferences(String lengua) async {
    String idioma = lengua;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("idioma", idioma);
    MyApp.idioma = idioma;
  }
}
