import 'package:arquitectura_universales/blocs/gps_bloc/gps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
          return !state.isGpsEnabled
              ? const _EnableGpsMessage()
              : const _AccessButton();
        }),
        // _AccessButton(),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Es necesario el acceso al GPS",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        MaterialButton(
            child: const Text(
              "Solicitar Acceso",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.blueGrey,
            shape: const StadiumBorder(),
            elevation: 0.0,
            splashColor: Colors.transparent,
            onPressed: () {
              //TODO: POR HACER
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              gpsBloc.askGpsAccess();
            }),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Por fabor habilite el GPS",
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w300,
        fontFamily: "Lato",
      ),
    );
  }
}
