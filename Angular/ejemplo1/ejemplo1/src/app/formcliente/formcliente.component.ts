import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DynamicDialogConfig } from 'primeng/dynamicdialog';
import { ActivatedRoute } from '@angular/router';


@Component({
  selector: 'app-formcliente',
  templateUrl: './formcliente.component.html',
  styleUrls: ['./formcliente.component.css']
})

export class FormclienteComponent implements OnInit {

  clienteNuevo: any = {};
  respuesta: boolean = true;
  parametro: any;


  constructor(private clienteService: ClienteService, public ref: DynamicDialogRef, public config: DynamicDialogConfig,
    private activatedRoute: ActivatedRoute) { }

  ngOnInit(): void {

    this.activatedRoute.params.subscribe(parametros => {
      this.parametro = parametros['param1'];
      console.log(this.parametro);
    });

  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearCliente");
    if (formulario.reportValidity()) {
      this.clienteService.guardarCliente(this.clienteNuevo).subscribe(
        (res: any) => this.finalizarGurdar(res)
      )
      formulario.reset();
      this.clienteNuevo = {};
      this.ref.close(this.respuesta);
    }
  }

  finalizarGurdar(respuesta: any) {
  }

}
