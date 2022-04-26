import 'package:arquitectura_universales/blocs/gps_bloc/gps_bloc.dart';
import 'package:arquitectura_universales/pages/acceso_gps/gps_access.dart';
import 'package:arquitectura_universales/widgets/barra_navegacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        return state.isAllGranted ? BarraNavegacion() : const GpsAccessScreen();
      },
    ));
  }
}
