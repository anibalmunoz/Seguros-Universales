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

  Map<String, dynamic> toDataBase() => {
        'idsiniestro': idSiniestro,
        'fechasiniestro': fechaSiniestro,
        'causas': causas,
        'aceptado': aceptado,
        'indemnizacion': indemnizacion,
      };

  Map<String, dynamic> toMap() {
    return {
      'idsiniestro': idSiniestro,
      'fechasiniestro': fechaSiniestro,
      'causas': causas,
      'aceptado': aceptado,
      'indemnizacion': indemnizacion,
    };
  }
}

class SiniestrosLista {
  late List siniestros;

  SiniestrosLista.lista(List<Siniestro> list) {
    siniestros = list;
  }

  SiniestrosLista.fromDb(List<Siniestro> list) {
    siniestros = list;
  }
}
