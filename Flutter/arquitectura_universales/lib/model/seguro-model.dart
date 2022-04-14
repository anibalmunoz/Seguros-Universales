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
}

class SegurosLista {
  late List seguros;

  SegurosLista.lista(List list) {
    this.seguros = list;
  }
}
