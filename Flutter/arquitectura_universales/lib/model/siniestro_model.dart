class Siniestro {
  late String? idSiniestro;
  late String? fechaSiniestro;
  late String? causas;
  late String? aceptado;
  late String? indemnizacion;
  late String? numeroPoliza;

  Siniestro(
      {key,
      this.idSiniestro,
      this.fechaSiniestro,
      this.causas,
      this.aceptado,
      this.indemnizacion,
      this.numeroPoliza});
}

class SiniestrosLista {
  late List siniestros;

  SiniestrosLista.lista(List list) {
    this.siniestros = list;
  }
}
