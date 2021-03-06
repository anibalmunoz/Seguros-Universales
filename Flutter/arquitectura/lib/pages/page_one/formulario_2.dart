import 'package:arquitectura/bloc/basic_bloc/basic_bloc.dart';
import 'package:arquitectura/main.dart';
import 'package:arquitectura/pages/page_two/page_two.dart';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:arquitectura/util/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Formulario2 extends StatelessWidget {
  Formulario2({Key? key}) : super(key: key);
  String nombre = "Anibal";
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    // String correo = FirebaseRemoteConfig.instance.getString("correo");
    // String password = FirebaseRemoteConfig.instance.getString("password");

    final estiloBoton = ElevatedButton.styleFrom(
      primary: Colors.red,
      onPrimary: Colors.white,
    );

    return Scaffold(
      //backgroundColor:  Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Colors.red,
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
                print(
                    "EL VALOR DEL THEME NOTIFIER ES ${MyApp.themeNotifier.value}");
                enviarDato(true);
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (cxt) => PageTwo(title: estado.title)));
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
                                const Icon(
                                  Icons.login_sharp,
                                  color: Colors.red,
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
                                        validator: (valor) {
                                          if (valor!.isEmpty) {
                                            return 'Correo vac??o';
                                          }
                                          if (!valor.isValidEmail) {
                                            return 'Correo Inv??lido';
                                          }
                                          if (valor !=
                                              FirebaseRemoteConfig.instance
                                                  .getString("correo")) {
                                            return 'El correo no est?? registrado';
                                          }
                                          return null;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.mail_outline),
                                            labelText: "Correo electr??nico",
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
                                        validator: (valor) {
                                          if (valor!.isEmpty) {
                                            return "Campo vac??o";
                                          }
                                          if (!valor.isValidPassword) {
                                            return "La contrase??a debe tener:\nMinimo 8 caracteres\nAl menos una letra may??scula\n"
                                                "Al menos una letra minucula\n"
                                                "Al menos un d??gito\n"
                                                "Al menos 1 caracter especial";
                                          }
                                          if (valor !=
                                              FirebaseRemoteConfig.instance
                                                  .getString("password")) {
                                            return "La contrase??a no est?? registrada";
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.password_outlined),
                                          labelText: "Contrase??a",
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
                                          onPressed: () {
                                            if (_keyForm.currentState!
                                                .validate()) {
                                              BlocProvider.of<BasicBloc>(
                                                      context)
                                                  .add(LoginButtonPressed(
                                                      nombre: nombre));
                                            }
                                            //   //else {
                                            //   //   ScaffoldMessenger.of(context)
                                            //   //       .showSnackBar(
                                            //   //     const SnackBar(
                                            //   //         content: Text(
                                            //   //             "Informaci??n incorrecta")),
                                            //   //   );
                                            //   // }
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
}

Future<void> enviarDato(bool modo) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('modo', modo);
}
