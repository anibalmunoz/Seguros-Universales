class Seguro {
  late String? numeroPoliza;
  late String? ramo;
  late String? fechaInicio;
  late String? fechaVencimiento;
  late String? condicionesParticulares;
  late String? observaciones;
  late String? dniCliente;

  Seguro(
      {key,
      this.numeroPoliza,
      this.ramo,
      this.fechaInicio,
      this.fechaVencimiento,
      this.condicionesParticulares,
      this.observaciones,
      this.dniCliente});

  Map<String, dynamic> toDataBase() => {
        'numeropoliza': numeroPoliza,
        'ramo': ramo,
        'fechainicio': fechaInicio,
        'fechavencimiento': fechaVencimiento,
        'condicionesparticulares': condicionesParticulares,
        'observaciones': observaciones,
      };

  Map<String, dynamic> toMap() {
    return {
      'numeropoliza': numeroPoliza,
      'ramo': ramo,
      'fechainicio': fechaInicio,
      'fechavencimiento': fechaVencimiento,
      'condicionesparticulares': condicionesParticulares,
      'observaciones': observaciones,
    };
  }
}

class SegurosLista {
  late List seguros;

  SegurosLista.lista(List<Seguro> list) {
    seguros = list;
  }

  SegurosLista.fromDb(List<Seguro> list) {
    seguros = list;
  }
}
