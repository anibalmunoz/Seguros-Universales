import 'package:arquitectura_universales/widgets/barra_navegacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Prueba a lista de clientes vacía", (WidgetTester tester) async {
    var widget = BarraNavegacion();
    // AppLocalizations localizations =
    //     Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    tester.pumpWidget(MaterialApp(
      home: widget,
    ));
  });
}
