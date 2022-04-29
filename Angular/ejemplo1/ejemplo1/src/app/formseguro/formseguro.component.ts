import { Component, OnInit } from '@angular/core';
import { SeguroService } from '../servicios/seguro/seguro.service';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DynamicDialogConfig } from 'primeng/dynamicdialog';
import { CompaniaSegurosService } from '../servicios/compania-seguros/compania-seguros.service';
import { CompaniaService } from '../servicios/compania/compania.service';

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
  companiaSeguro: any = {};

  lang = [
    { name: 5 },
    { name: 10 },
    { name: 15 },
  ];

  companias: any = [];


  compania: any = { nombreCompania: "PRUEBA" };
  paginas: any = { name: 5 };

  constructor(private seguroService: SeguroService, public ref: DynamicDialogRef, public config: DynamicDialogConfig,
    private clienteService: ClienteService, private companiaSeguroService: CompaniaSegurosService, private companiaService: CompaniaService) { }



  ngOnInit(): void {
    this.buscarCompania();
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
        (res: any) => this.guardarCompaniaSeguro(res)
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





  guardarCompaniaSeguro(seguro: any) {
    this.companiaSeguro.numeroPoliza = seguro.numeroPoliza;
    console.log(this.compania.nombreCompania);
    this.companiaSeguro.nombreCompania = this.compania.nombreCompania;
    this.companiaSeguroService.guardarCompaniaSeguro(this.companiaSeguro).subscribe(
      (res: any) => this.finalizarGuardarCompSeg(res)
    );
  }

  finalizarGuardarCompSeg(respuesta: any) {

  }


  //DROPDOWN




  buscarCompania() {
    this.companiaService.buscarCompanias().subscribe(
      (res: any) => this.asignarCompanias(res)
    );
  }

  asignarCompanias(companias: any) {
    this.companias = companias;
  }

}
