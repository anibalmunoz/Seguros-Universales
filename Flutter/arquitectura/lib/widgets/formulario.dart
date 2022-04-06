import 'package:arquitectura/pages/page_two/page_two.dart';
import 'package:arquitectura/widgets/formulario_personalizado.dart';
import 'package:flutter/material.dart';
import 'package:arquitectura/util/extension.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  _Formulario createState() => _Formulario();
}

class _Formulario extends State {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormularioPersonalizado(
                hintText: 'Email',
                validator: (val) {
                  //  if (!val.isValidEmail) 'Enter valid email';
                },
              ),
              FormularioPersonalizado(
                hintText: 'Password',
                validator: (val) {
                  //  if (!val.isValidPassword) return 'Enter valid password';
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PageTwo(title: "Login correcto"),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
