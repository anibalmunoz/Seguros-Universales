import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DynamicDialogConfig } from 'primeng/dynamicdialog';


@Component({
  selector: 'app-formcliente',
  templateUrl: './formcliente.component.html',
  styleUrls: ['./formcliente.component.css']
})
export class FormclienteComponent implements OnInit {

  clienteNuevo: any = {};
  respuesta: boolean = true;


  constructor(private clienteService: ClienteService, public ref: DynamicDialogRef, public config: DynamicDialogConfig) { }

  ngOnInit(): void {
  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearCliente");
    // this.clienteNuevo.fechacreacion= new Date(this.clienteNuevo.fecha+"T00:00:00");
    if (formulario.reportValidity()) {
      this.clienteService.guardarCliente(this.clienteNuevo).subscribe(
        (res: any) => this.finalizarGurdar(res)
      )
      //this.showTopCenter();
      formulario.reset();
      this.clienteNuevo = {};
      // this.mostrarFormulario = false;
      //this.reset();
    }
    this.ref.close(this.respuesta);
  }

  finalizarGurdar(respuesta: any) {
    //this.obtenerPaginado(this.pagina, this.filas);
  }

}
