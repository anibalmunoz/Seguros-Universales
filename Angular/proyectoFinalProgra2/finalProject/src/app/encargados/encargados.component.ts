import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Component({
  selector: 'app-encargados',
  templateUrl: './encargados.component.html',
  styleUrls: ['./encargados.component.css']
})
export class EncargadosComponent implements OnInit {

  usuario: any = { correoList: [], telefonoList: [], direccionList: [], rolUsuarioIdrolUsuario: 3 };

  usuarios: any = [];

  loading: boolean = false;

  creando: boolean = false;

  constructor() { }

  ngOnInit(): void {  
    this.buscarEncargados();
  }

  agregar() {
    this.creando = !this.creando;
  }

  //CREACION DE LOS ENCARGADOS

  crear() {
    let formulario: any = document.getElementById("crear");
    let formularioValido: boolean = formulario.reportValidity();
    if (formularioValido) {
      this.loading = true;
     // this.createService().subscribe(
      //  data => this.confirmar(data)
     // )
    }
  }

  confirmar(resultado: any) {
    this.loading = false;
    this.creando = false;
    if (resultado) {
      alert("Encargado de pedidos guardado exitosamente")
      this.usuario = { correoList: [], telefonoList: [], direccionList: [], rolUsuarioIdrolUsuario: 3 };
      this.buscarEncargados();
    } else {
      alert("Error al crear el encargado.");
    }
  }

  createService() {
    var httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json'
      })
    }
   // return this.http.post<any>("http://localhost:3030/usuario/guardar", this.usuario, httpOptions)
  }

  regresar() {
    location.href = "/";
  }



  //TELEFONOS

  agregarTelefono() {
    this.usuario.telefonoList.push({});
  }

  eliminarTelefono(telefono: any) {
    console.log(telefono)
   // this.eliminarTelefonoService(telefono).subscribe();
    this.usuario.telefonoList.splice(this.usuario.telefonoList.indexOf(telefono), 1);
    this.crear();
  } 

  //eliminarTelefonoService(telefono: any): Observable<any> {
   // return this.http.delete<any>("http://localhost:3030/telefonoUsuario/eliminar/" + telefono.idTelefonoUsuario).pipe(
  // /   catchError(e => "error")
  //  )
 // }

  //CORREOS

  agregarCorreo() {
    this.usuario.correoList.push({});
  }

 
  eliminarCorreo(correo: any) {
  //  console.log(correo)
  //  this.eliminarCorreoService(correo).subscribe();
  //  this.usuario.correoList.splice(this.usuario.correoList.indexOf(correo), 1);
  //  this.crear();
  }

 // eliminarCorreoService(correo: any): Observable<any> {
  //  return this.http.delete<any>("http://localhost:3030/correoUsuario/eliminar/" + correo.idCorreoUsuario).pipe(
  //    catchError(e => "error")
  //  )
 // }


  //DIRECCIONES
  agregarDireccion() {
    this.usuario.direccionList.push({});
  }
 
  eliminarDireccion(direccion: any) {
    console.log(direccion)
   // this.eliminarDireccionService(direccion).subscribe();
    this.usuario.direccionList.splice(this.usuario.direccionList.indexOf(direccion), 1);
    this.crear();
  }

 // eliminarDireccionService(direccion: any): Observable<any> {
  //  return this.http.delete<any>("http://localhost:3030/direccionUsuario/eliminar/" + direccion.idDireccionUsuario).pipe(
 //     catchError(e => "error")
 //   )
 // }


  //CONSULTAR LISTA DE ENCARGADOS

  buscarEncargados() {
    this.loading = true;
   // this.buscarEncargadosServicio().subscribe(
   ////   (response: any) => this.llenarEncargados(response)
   // );
  }
//
 // buscarEncargadosServicio(): Observable<any> {
  //  return this.http.get<any>("http://localhost:3030/usuario/buscar/rol/3").pipe(
  //    catchError(e => "error")
  //  )
 // }

  llenarEncargados(usuarios: any) {
    this.usuarios = usuarios;
    this.loading = false;
  }

  //MODIFICAR ENCARGADOS

  modificarEncargado(usuario: any) {
    this.usuario = usuario;
    this.creando = true;
  }

  //ELIMINAR ENCARGADOS

  eliminarEncargado(usuario: any) {
    //this.eliminarEncargadoServicio(usuario).subscribe();
    alert("Encargado eliminado exitosamente.");
    this.ngOnInit();
  }

 // eliminarEncargadoServicio(usuario: any): Observable<any> {
   // return this.http.delete<any>("http://localhost:3030/usuario/eliminar/" + usuario.idUsuario).pipe(
   //   catchError(e => "error")
  //  )
 // }

}
