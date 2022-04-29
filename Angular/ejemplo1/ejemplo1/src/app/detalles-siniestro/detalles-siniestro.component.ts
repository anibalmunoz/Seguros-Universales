import { Component, OnInit } from '@angular/core';
import { SiniestroService } from '../servicios/siniestro/siniestro.service';
import { SeguroService } from '../servicios/seguro/seguro.service';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { PeritoService } from '../servicios/perito/perito.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-detalles-siniestro',
  templateUrl: './detalles-siniestro.component.html',
  styleUrls: ['./detalles-siniestro.component.css']
})
export class DetallesSiniestroComponent implements OnInit {

  siniestroNuevo: any = {};
  cliente: any = {};
  seguro: any = {};
  perito: any = {};

  mostrarGuardar = false;

  clienteId: any;

  polizaSearch: any;
  dniPeritoSearch: any;
  dniSiniestroSearch: any;

  constructor(private seguroService: SeguroService, private siniestroService: SiniestroService,
    private clienteService: ClienteService, private peritoService: PeritoService, private activatedRoute: ActivatedRoute) { }

  ngOnInit(): void {

    this.activatedRoute.params.subscribe(parametros => {
      this.polizaSearch = parametros['param1'];
      this.dniPeritoSearch = parametros['param2'];
      this.dniSiniestroSearch = parametros['param3'];


      this.buscarSeguroPorNumeroPoliza(this.polizaSearch);
      this.buscarPeritoPorDNI(this.dniPeritoSearch);
      this.buscarSiniestro(this.dniSiniestroSearch);



    });
  }


  buscarSiniestro(id: any) {
    this.siniestroService.buscarSiniestroPorID(id).subscribe(
      (respuesta: any) => this.asignarSiniestro(respuesta)
    );
  }

  asignarSiniestro(siniestro: any) {
    this.siniestroNuevo = siniestro[0];
  }



  buscarCliente() {
    this.clienteService.buscarClientePorDNI(this.clienteId).subscribe(
      (res: any) => this.asignarCliente(res)
    );
  }

  asignarCliente(client: any) {
    this.cliente = client[0];
  }



  buscarSeguroPorNumeroPoliza(numeroPoliza: any) {
    this.seguroService.buscarPorPoliza(numeroPoliza).subscribe(
      (respuesta: any) => this.asignarSeguro(respuesta)
    );
  }

  asignarSeguro(seguro: any) {
    this.seguro = seguro[0];
    this.clienteId = this.seguro.dniCl;
    this.buscarCliente();
  }




  buscarPeritoPorDNI(perito: any) {
    this.peritoService.buscarPeritoPorDNI(perito).subscribe(
      (respuesta: any) => this.asginarPerito(respuesta)
    );
  }

  asginarPerito(perito: any) {
    this.perito = perito[0];
  }


}


