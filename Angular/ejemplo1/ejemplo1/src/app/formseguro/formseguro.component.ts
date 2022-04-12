import { Component, OnInit } from '@angular/core';
import { SeguroService } from '../servicios/seguro/seguro.service';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DynamicDialogConfig } from 'primeng/dynamicdialog';


@Component({
  selector: 'app-formseguro',
  templateUrl: './formseguro.component.html',
  styleUrls: ['./formseguro.component.css'],
})
export class FormseguroComponent implements OnInit {

  seguroNuevo: any = {};
  respuesta: boolean = true;
  cliente: any;
  mostrarFormulario: boolean = false;
  mostrarDatosCliente: boolean = false;
  sinCliente = true;

  constructor(private seguroService: SeguroService, public ref: DynamicDialogRef, public config: DynamicDialogConfig,
    private clienteService: ClienteService,) { }



  ngOnInit(): void {
  }


  display: boolean = false;





  validar() {
    if (this.cliente.dniCl == "") {
      this.mostrarFormulario = true;
      this.mostrarDatosCliente = true;
      //this.enviarFormulario();
    } else {
      this.showDialog();
    }
  }

  showDialog() {
    this.display = true;
  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearSeguro");
    this.seguroNuevo.fechaInicio = new Date(this.seguroNuevo.fechaI + "T00:00:00");
    this.seguroNuevo.fechaVencimiento = new Date(this.seguroNuevo.fechaV + "T00:00:00");

    if (formulario.reportValidity()) {
      this.seguroService.guardarSeguro(this.seguroNuevo).subscribe(
        (res: any) => this.finalizarGuardar(res)
      );
      formulario.reset();
      this.seguroNuevo = {};
      this.ref.close(this.respuesta);
    }
  }


  buscarCliente(dni: any) {
    this.clienteService.buscarClientePorDNI(dni).subscribe(
      (res: any) => this.asignarValor(res)
    );
  }

  asignarValor(client: any) {
    this.cliente = {};
    this.cliente = client[0];
    console.log(this.cliente);
    if (this.cliente == undefined) {
      this.showDialog();
      this.mostrarDatosCliente = false;
      this.mostrarFormulario = false;
    } else {
      this.mostrarDatosCliente = true;
      this.mostrarFormulario = true;
    }
  }



  finalizarGuardar(respuesta: any) {
  }


}
