import { Component, OnInit } from '@angular/core';
import { SeguroService } from '../servicios/seguro/seguro.service';

@Component({
  selector: 'app-seguros',
  templateUrl: './seguros.component.html',
  styleUrls: ['./seguros.component.css']
})
export class SegurosComponent implements OnInit {

  seguros: any = [];
  seguroNuevo: any = {};
  mostrarFormulario: boolean = false;
  paginado: any = {};
  primeraPagina: boolean = false;
  finalPagina: boolean = false;
  pagina: number = 0;
  filas: number = 5;
  paginasTotales: number = 0;
  cantidadSeguros: number = 0;

  //customers: any = [];
  first = 0;
  rows = 10;


  lang = [
    { name: 5 },
    { name: 10 },
    { name: 15 },
  ];

  paginas: any = { name: 5 };

  constructor(private seguroService: SeguroService) { }

  ngOnInit(): void {
    //this.obtenerSeguros();
    this.obtenerPaginado(0, this.filas);
    //setInterval(()=>this.obtenerClientes(),1000)
  }

  obtenerSeguros() {
    this.seguroService.buscarSeguros().subscribe(
      (res: any) => this.mostrarSeguros(res)
    );
  }

  mostrarSeguros(segs: any) {
    this.seguros = segs;
  }


  enviarFormulario() {
    let formulario: any = document.getElementById("crearSeguro");
    this.seguroNuevo.fechaInicio = new Date(this.seguroNuevo.fechaI + "T00:00:00");
    this.seguroNuevo.fechaVencimiento = new Date(this.seguroNuevo.fechaV + "T00:00:00");
    if (formulario.reportValidity()) {
      this.seguroService.guardarSeguro(this.seguroNuevo).subscribe(
        (res: any) => this.finalizarGuardar(res)
      )
      alert("Seguro guardado correctamente");
      formulario.reset();
    }
  }

  finalizarGuardar(respuesta: any) {
    this.obtenerPaginado(this.pagina, this.filas);
  }

  mostrarFormularios() {
    this.mostrarFormulario = !this.mostrarFormulario;
  }

  //PRUEBA DE CONSUMO DE PAGEABLE 

  obtenerPaginado(pagina: number, cantidad: number) {
    //clientePaginado(pagina,cantidad)
    this.seguroService.seguroPaginado(pagina, cantidad).subscribe(
      (res: any) => this.mostrarPaginado(res)
    );
  }

  mostrarPaginado(pageable: any) {
    this.paginado = pageable;
    this.seguros = pageable.content;
    this.paginasTotales = pageable.totalPages;
    this.cantidadSeguros = pageable.totalElements;
    this.filas = this.paginas.name;
    if (pageable.last) {
      this.finalPagina = true;
    }
    if (pageable.first) {
      this.primeraPagina = true;
    }
  }

  //IMPLEMENTACION DE LAS TABLAS CON PAGINACIÓN CUSTOM


  //    this.customerService.getCustomersLarge().then(customers => this.customers = customers);

  next() {
    if (!this.finalPagina) {
      this.pagina = this.pagina + 1;
      this.primeraPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
    //this.first = this.first + this.rows;
  }

  prev() {
    if (!this.primeraPagina) {
      this.pagina = this.pagina - 1;
      this.finalPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
    //this.first = this.first - this.rows;
  }

  reset() {
    //this.first = 0;
    this.finalPagina = false;
    this.primeraPagina = true;
    this.pagina = 0;
    this.filas = this.paginas.name;
    this.obtenerPaginado(0, this.filas);
  }

}
