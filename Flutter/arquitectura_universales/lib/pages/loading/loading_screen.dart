import 'package:arquitectura_universales/blocs/basic_bloc/basic_bloc.dart';
import 'package:arquitectura_universales/pages/page_one/formulario_login.dart';
import 'package:arquitectura_universales/widgets/barra_navegacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<BasicBloc, BasicState>(
      builder: (context, state) {
        return state.isAllGranted ? BarraNavegacion() : FormularioLogin();
      },
    ));
  }
}
