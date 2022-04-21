class Cliente {
  late int? dnicl;
  late String? nombrecl;
  late String? apellido1;
  late String? apellido2;
  late String? clasevia;
  late String? nombrevia;
  late String? numerovia;
  late String? codpostal;
  late String? ciudad;
  late String? telefono;
  late String? observaciones;
  late String? correo;
  late String? contrasena;

  Cliente(
      {key,
      this.dnicl,
      this.nombrecl,
      this.apellido1,
      this.apellido2,
      this.clasevia,
      this.nombrevia,
      this.numerovia,
      this.codpostal,
      this.ciudad,
      this.telefono,
      this.observaciones,
      this.correo,
      this.contrasena});

//EL METODO FROM OBJETO SOLO ME SIRVE PARA LOGIN

//   Cliente.fromObjeto(Map<String, dynamic> data) {
//     correo = data['correo'];
//     contrasena = data['contrasena'];
//   }

// //METODO PARA BASE DE DATOS LOCAL

//   Cliente.fromDb(Map<String, dynamic> data) {
//     dnicl = data['dnicl'];
//     nombrecl = data['nombrecl'];
//   }

  Map<String, dynamic> toDataBase() => {
        'dnicl': dnicl,
        'nombrecl': nombrecl,
        'apellido1': apellido1,
        'apellido2': apellido2,
        'clasevia': clasevia,
        'nombrevia': nombrevia,
        'numerovia': numerovia,
        'codpostal': codpostal,
        'ciudad': ciudad,
        'telefono': telefono,
        'observaciones': observaciones,
      };

  //METODO PARA UPDATE
  Map<String, dynamic> toMap() {
    return {
      'dnicl': dnicl,
      'nombrecl': nombrecl,
      'apellido1': apellido1,
      'apellido2': apellido2,
      'clasevia': clasevia,
      'nombrevia': nombrevia,
      'numerovia': numerovia,
      'codpostal': codpostal,
      'ciudad': ciudad,
      'telefono': telefono,
      'observaciones': observaciones,
    };
  }
}

class ClientesLista {
  late List<Cliente> clientes;

  ClientesLista.lista(List<Cliente> list) {
    clientes = list;
  }

  // //METODO PARA BASE DE DATOS LOCAL

  ClientesLista.fromDb(List<Cliente> list) {
    clientes = list;
  }
}
