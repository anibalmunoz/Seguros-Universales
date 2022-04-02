import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../servicios/cliente/cliente.service';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { Message } from 'primeng/api';
import { PrimeNGConfig } from 'primeng/api';



@Component({
  selector: 'app-clientes',
  templateUrl: './clientes.component.html',
  styleUrls: ['./clientes.component.css'],
  providers: [ConfirmationService, MessageService],

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
  //cliente: any = {};

  //customers: any = [];
  first = 0;
  rows = 10;

  msgs: Message[] = [];

  position: string = "";

  //private messageService: MessageService
  //private confirmationService: ConfirmationService,
  constructor(private clienteService: ClienteService, private confirmationService: ConfirmationService, private primengConfig: PrimeNGConfig, private messageService: MessageService) { }

  //  onConfirm() {
  //  this.messageService.clear('c');
  // }

  //onReject() {
  // this.messageService.clear('c');
  //}

  //clear() {
  //    this.messageService.clear();
  //  }


  confirm1(cliente: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de editar el cliente?',
      header: 'Edicion',
      icon: 'pi pi-exclamation-triangle',
      accept: () => {
        //this.msgs = [{ severity: 'info', summary: 'Confirmed', detail: 'You have accepted' }];
        this.modificarCliente(cliente);
      },
      reject: () => {
        // this.msgs = [{ severity: 'info', summary: 'Rejected', detail: 'You have rejected' }];
      }
    });
  }

  confirm2(cliente: any) {
    this.confirmationService.confirm({
      message: '¿Estas seguro de eliminar este cliente?',
      header: 'Confirmación de eliminación',
      icon: 'pi pi-info-circle',
      accept: () => {
        //this.msgs = [{ severity: 'info', summary: 'Confirmed', detail: 'Record deleted' }];
        this.eliminarCliente(cliente);
        this.reset();
      },
      reject: () => {
        //this.msgs = [{ severity: 'info', summary: 'Rejected', detail: 'You have rejected' }];
      }
    });
  }

  confirmPosition(position: string) {
    this.position = position;

    this.confirmationService.confirm({
      message: 'Do you want to delete this record?',
      header: 'Delete Confirmation',
      icon: 'pi pi-info-circle',
      accept: () => {
        this.msgs = [{ severity: 'info', summary: 'Confirmed', detail: 'Record deleted' }];
      },
      reject: () => {
        this.msgs = [{ severity: 'info', summary: 'Rejected', detail: 'You have rejected' }];
      },
      key: "positionDialog"
    });
  }


  //toast
  showSuccess() {
    this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Message Content' });
  }
  showTopCenter() {
    this.messageService.add({ key: 'tc', severity: 'success', summary: 'Info', detail: 'Cliente guardado correctamente' });
  }
  showTopDelete() {
    this.messageService.add({ key: 'td', severity: 'error', summary: 'Info', detail: 'Cliente eliminado correctamente' });
  }

  ngOnInit(): void {
    //this.obtenerClientes();
    this.obtenerPaginado(0, this.filas);
    //setInterval(()=>this.obtenerClientes(),1000) //FORMA DE CARGAR UN METODO CADA SEGUNDO
    this.primengConfig.ripple = true;

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
      this.showTopCenter();
      formulario.reset();
      this.clienteNuevo = {};
      this.mostrarFormulario = false;
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
  }

  last() {
    if (!this.finalPagina) {
      this.pagina = this.paginasTotales - 1;
      this.primeraPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

  prev() {
    if (!this.primeraPagina) {
      this.pagina = this.pagina - 1;
      this.finalPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

  primero() {
    if (!this.primeraPagina) {
      this.pagina = 0;
      this.finalPagina = false;
      this.filas = this.paginas.name;
      this.obtenerPaginado(this.pagina, this.filas);
    }
  }

    reset() {
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

  //Modificar cliente

  modificarCliente(cliente: any) {
    this.clienteNuevo = cliente
    this.mostrarFormulario = true;
  }

  //Eliminar Cliente

  eliminarCliente(cliente: any) {
    this.clienteService.eliminarCliente(cliente.dniCl).subscribe();
    this.showTopDelete();
    this.reset();
  }

  cancelarEditar() {
    this.mostrarFormulario = false;
    this.clienteNuevo = {};
  }

}
