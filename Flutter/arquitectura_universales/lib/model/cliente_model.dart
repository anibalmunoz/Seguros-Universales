class Cliente {
  late int dni;
  late String nombre;
  late String apeliido1;
  late String? apellido2;
  late String? claseVia;
  late String? nombreVia;
  late String? numeroVia;
  late String? codigoPostal;
  late String? ciudad;
  late String? telefono;
  late String? observaciones;

  Cliente(
      {key,
      required this.dni,
      required this.nombre,
      required this.apeliido1,
      this.apellido2,
      this.claseVia,
      this.nombreVia,
      this.numeroVia,
      this.codigoPostal,
      this.ciudad,
      this.telefono,
      this.observaciones});

  // Cliente.fromObjeto(Map<String, dynamic> data) {
  //   this.nombre = data['name'];
  // }

}

class ClientesLista {
  late List clientes;

  ClientesLista.lista(List list) {
    this.clientes = list;
  }
}
