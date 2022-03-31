import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { MessageService } from 'primeng/api';


@Component({
  selector: 'app-clientes',
  templateUrl: './clientes.component.html',
  styleUrls: ['./clientes.component.css']
})
export class ClientesComponent implements OnInit {

  lang = [
    { name: 5 },
    { name: 10 },
    { name: 15 },
  ];

  paginas: any = { name: 5 };

  clientes: any = [];
  clienteNuevo: any = {};
  mostrarFormulario: boolean = false;
  paginado: any = {};
  primeraPagina: boolean = false;
  finalPagina: boolean = false;
  pagina: number = 0;
  filas: number = 5;
  paginasTotales: number = 0;
  cantidadClientes: number = 0;
  listaSeguros: any = [];

  //customers: any = [];
  first = 0;
  rows = 10;

  //private messageService: MessageService
  constructor(private clienteService: ClienteService) { }




  ngOnInit(): void {
    //this.obtenerClientes();
    this.obtenerPaginado(0, this.filas);
    //setInterval(()=>this.obtenerClientes(),1000) //FORMA DE CARGAR UN METODO CADA SEGUNDO
  }

  obtenerClientes() {
    this.clienteService.buscarClientes().subscribe(
      (res: any) => this.mostrarClientes(res)
    );
  }

  mostrarClientes(clients: any) {
    this.clientes = clients;
  }

  enviarFormulario() {
    let formulario: any = document.getElementById("crearCliente");
    // this.clienteNuevo.fechacreacion= new Date(this.clienteNuevo.fecha+"T00:00:00");
    if (formulario.reportValidity()) {
      this.clienteService.guardarCliente(this.clienteNuevo).subscribe(
        (res: any) => this.finalizarGurdar(res)
      )
      alert("Cliente guardado correctamente");
      formulario.reset();
    }
  }

  finalizarGurdar(respuesta: any) {
    this.obtenerPaginado(this.pagina, this.filas);
  }

  mostrarFormularios() {
    this.mostrarFormulario = !this.mostrarFormulario;
  }


  //PRUEBA DE CONSUMO DE PAGEABLE 

  obtenerPaginado(pagina: number, cantidad: number) {
    //clientePaginado(pagina,cantidad)
    this.clienteService.clientePaginado(pagina, cantidad).subscribe(
      (res: any) => this.mostrarPaginado(res)
    );
  }

  mostrarPaginado(pageable: any) {
    this.paginado = pageable;
    this.clientes = pageable.content;
    this.paginasTotales = pageable.totalPages;
    this.cantidadClientes = pageable.totalElements;
    this.listaSeguros = this.clientes.segurosList;
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
  /*
    isLastPage(): boolean {
      return this.clientes ? this.first === (this.clientes.length - this.rows) : true;
    }
  
    isFirstPage(): boolean {
      return this.clientes ? this.first === 0 : true;
    }
  */
}
