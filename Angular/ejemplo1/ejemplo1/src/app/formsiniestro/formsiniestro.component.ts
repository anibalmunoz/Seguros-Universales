import { Component, OnInit } from '@angular/core';
import { SiniestroService } from '../servicios/siniestro/siniestro.service';
import { SeguroService } from '../servicios/seguro/seguro.service';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { DynamicDialogConfig } from 'primeng/dynamicdialog';
import { PeritoService } from '../servicios/perito/perito.service';

@Component({
  selector: 'app-formsiniestro',
  templateUrl: './formsiniestro.component.html',
  styleUrls: ['./formsiniestro.component.css']
})
export class FormsiniestroComponent implements OnInit {


  siniestroNuevo: any = { perito: {} };
  respuesta: boolean = true;
  cliente: any;
  seguro: any;
  mostrarFormulario: boolean = false;
  mostrarDatosCliente: boolean = false;
  sinCliente = true;
  clienteID: any;
  mostrarGuardar = false;
  perito:any;
  mostrarDatosPerito:boolean=false;

  display: boolean = false;
  display2: boolean = false;

  constructor(private seguroService: SeguroService, public ref: DynamicDialogRef, private siniestroService: SiniestroService,
    public config: DynamicDialogConfig, private clienteService: ClienteService,
    private peritoService: PeritoService) { }

  ngOnInit(): void {
    
  }



  validar() {
    if (this.cliente.dniCl == "") {
      this.mostrarFormulario = true;
      this.mostrarDatosCliente = true;
    } else {
      this.showDialog();
    }
  }

  showDialog() {
    this.display = true;
  }

  showDialog2() {
    this.display2 = true;
  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearSiniestro");
    this.siniestroNuevo.fechaSiniestro = new Date(this.siniestroNuevo.fechaS + "T00:00:00");
    this.siniestroNuevo.numeroPoliza = this.siniestroNuevo.numeroPoliza;




    //this.siniestroNuevo.perito.dniPerito = 1;




    if (formulario.reportValidity()) {
      this.siniestroService.guardarSiniestro(this.siniestroNuevo).subscribe(
        (res: any) => this.finalizarGuardar(res)
      );
      formulario.reset();
      this.siniestroNuevo = {};
      this.ref.close(this.respuesta);
    }
  }


  buscarCliente(dni: any) {
    this.clienteService.buscarClientePorDNI(dni).subscribe(
      (res: any) => this.asignarValorCliente(res)
    );
  }

  buscarSeguro(poliza: any) {
    this.seguroService.buscarPorPoliza(poliza).subscribe(
      (res: any) => this.asignarValorSeguro(res)
    );
  }

  asignarValorSeguro(seguro: any) {
    this.seguro = {};
    this.seguro = seguro[0];
    console.log(this.seguro);
    if (this.seguro == undefined) {
      this.clienteID = null;
      this.showDialog();
      this.mostrarDatosCliente = false;
      this.mostrarFormulario = false;
    } else {
      this.clienteID = this.seguro.dniCl;
    }
    if (this.clienteID == null) {
      this.showDialog();
      this.mostrarDatosCliente = false;
      this.mostrarFormulario = false;
    } else {
      this.buscarCliente(this.clienteID);
      this.mostrarDatosCliente = true;
      this.mostrarFormulario = true;
    }


  }

  asignarValorCliente(client: any) {
    this.cliente = {};
    this.cliente = client[0];
  }


  finalizarGuardar(respuesta: any) {
  }

  buscarPerito(idPerito: any) {
    this.peritoService.buscarPeritoPorDNI(idPerito).subscribe(
      (res: any) => this.asignarValorPerito(res)
    );
  }

  asignarValorPerito(perito:any){
    this.perito=perito[0];
    console.log(this.perito);    
    if(this.perito==undefined){
        this.showDialog2();
    }else{
      this.siniestroNuevo.perito.dniPerito = this.perito.dniPerito;
      this.mostrarDatosPerito=true;
      this.mostrarGuardar=true;
    }
    
  }

}
