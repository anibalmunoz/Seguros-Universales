import 'package:arquitectura/bloc/basic_bloc/basic_bloc.dart';
import 'package:arquitectura/pages/page_two/page_two.dart';
import 'package:flutter/material.dart';
import 'package:arquitectura/util/extension.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Formulario2 extends StatelessWidget {
  final correo = "munoz4hernandez@gmail.com";
  final password = "@Anibal12345";

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final estiloBoton = ElevatedButton.styleFrom(
      primary: Colors.red,
      onPrimary: Colors.white,
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
                                            return 'Correo vacío';
                                          }
                                          if (!valor.isValidEmail) {
                                            return 'Correo Inválido';
                                          }
                                          if (valor != correo) {
                                            return 'El correo no está registrado';
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
                                        validator: (valor) {
                                          if (valor!.isEmpty) {
                                            return "Campo vacío";
                                          }
                                          if (!valor.isValidPassword) {
                                            return "La contraseña debe tener:\nMinimo 8 caracteres\nAl menos una letra mayúscula\n"
                                                "Al menos una letra minucula\n"
                                                "Al menos un dígito\n"
                                                "Al menos 1 caracter especial";
                                          }
                                          if (valor != password) {
                                            return "La contraseña no está registrada";
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
                                          onPressed: () {
                                            if (_keyForm.currentState!
                                                .validate()) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => const PageTwo(
                                                      title: "Login correcto"),
                                                ),
                                              );
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
}
